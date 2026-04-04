import 'dart:async';
import 'dart:math' as math;
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:bookstore_management_system/app/bootstrap/app_runtime.dart';
import 'package:bookstore_management_system/core/common/logger/app_logger.dart';
import 'package:bookstore_management_system/core/di/service_locator.dart';
import 'package:bookstore_management_system/core/window/app_window_manager.dart';
import 'package:bookstore_management_system/core/window/current_app_window.dart';
import 'package:bookstore_management_system/core/window/sub_window_feature_policy.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:bookstore_management_system/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:bookstore_management_system/features/product/presentation/blocs/product_bloc.dart';
import 'package:bookstore_management_system/features/product/presentation/controllers/product_editor_isbn_receiver_service.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_info_editor/desktop_isbn_scanner_dialog.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_info_editor/product_info_editor_form_grid.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_info_editor/product_info_editor_form_state.dart';
import 'package:bookstore_management_system/features/product/utils/isbn_scanner_utils.dart';
import 'package:bookstore_management_system/core/domain/entities/app_user.dart';
import 'package:bookstore_management_system/core/presentation/widgets/admin_support.dart';
import 'package:bookstore_management_system/features/auth/data/datasources/local/auth_local_data_source.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

Future<AppUser> _defaultAdminModeVerifier({
  required String username,
  required String password,
}) {
  return sl<AuthLocalDataSource>().verifyAdminCredentials(
    username: username,
    password: password,
  );
}

class ProductInfoEditorView extends StatefulWidget {
  const ProductInfoEditorView({
    super.key,
    this.product,
    this.initialOperatorUsername,
    this.adminModeVerifier = _defaultAdminModeVerifier,
    this.adminModeTimeout = const Duration(minutes: 5),
  });

  final ProductModel? product;
  final String? initialOperatorUsername;
  final AdminModeVerifier adminModeVerifier;
  final Duration adminModeTimeout;

  @override
  State<ProductInfoEditorView> createState() => _ProductInfoEditorViewState();
}

class _ProductInfoEditorViewState extends State<ProductInfoEditorView> {
  final _logger = AppLogger.logger;
  final _formKey = GlobalKey<FormState>();
  AudioPlayer? _audioPlayer;

  late final ProductInfoEditorFormControllers _formControllers;
  late final ProductEditorIsbnReceiverService _isbnReceiverService;
  late final AppRuntime _appRuntime;
  final _editorChannel = const WindowMethodChannel(
    'bookstore_product_editor',
    mode: ChannelMode.unidirectional,
  );
  Timer? _feedbackClearTimer;
  _EditorFeedbackState? _feedbackState;
  bool _isAdminModeEnabled = false;
  AppUser? _adminModeUser;
  Timer? _adminModeTimer;

  @override
  void initState() {
    super.initState();
    _formControllers = ProductInfoEditorFormControllers();
    _isbnReceiverService = ProductEditorIsbnReceiverService();
    _formControllers.isbnController.addListener(_handleSensitiveFieldEdited);
    _formControllers.priceController.addListener(_handleSensitiveFieldEdited);
    _appRuntime = sl<AppRuntime>();
    if (_supportsAudioFeedback) {
      _audioPlayer = AudioPlayer();
    } else {
      _logger.i(
        'Audio feedback disabled for Windows sub-window product editor to '
        'avoid child-engine plugin instability.',
      );
    }
    _applyInitialFormData();
    _startIsbnReceiverService();
    _seedOperatorFromAuthStateIfAvailable();
    if (context.read<AuthBloc>().state is! AuthSuccess &&
        (widget.initialOperatorUsername?.trim().isNotEmpty != true)) {
      context.read<AuthBloc>().add(GetCurrentUserEvent());
    }
  }

  @override
  void dispose() {
    if (_isAdminModeEnabled) {
      _logAdminAudit('admin-mode.ended', reason: 'editor-disposed');
    }

    _isbnReceiverService.stop();
    final audioPlayer = _audioPlayer;
    if (audioPlayer != null) {
      unawaited(
        audioPlayer.dispose().catchError((Object error, StackTrace stackTrace) {
          _logger.w(
            'Ignoring audio player dispose failure in product editor: $error',
            error: error,
            stackTrace: stackTrace,
          );
        }),
      );
    }
    _formControllers.dispose();
    super.dispose();
  }

  bool get _supportsAudioFeedback =>
      SubWindowFeaturePolicy.supportsAudioFeedback(
        isSubWindow: _appRuntime.isSubWindow,
        isWindows: !kIsWeb && Platform.isWindows,
      );

  void _applyInitialFormData() {
    if (widget.product != null) {
      _formControllers.populateFromProduct(widget.product!);
    }
    final initialOperatorUsername = widget.initialOperatorUsername?.trim();
    if (initialOperatorUsername != null && initialOperatorUsername.isNotEmpty) {
      _formControllers.setOperator(initialOperatorUsername);
    }
  }

  void _seedOperatorFromAuthStateIfAvailable() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess) {
      _formControllers.setOperator(authState.user.username);
    }
  }

  void _dismissTextInput() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void _showEditorFeedback(
    String message, {
    bool isError = false,
    Duration duration = const Duration(seconds: 3),
  }) {
    _logger.i(
      'Product editor feedback: isSubWindow=${_appRuntime.isSubWindow}, '
      'kind=${isError ? 'error' : 'info'}, message=$message',
    );
    if (_appRuntime.isSubWindow) {
      _feedbackClearTimer?.cancel();
      setState(() {
        _feedbackState = _EditorFeedbackState(
          message: message,
          isError: isError,
        );
      });
      _feedbackClearTimer = Timer(duration, () {
        if (!mounted) {
          return;
        }
        setState(() {
          _feedbackState = null;
        });
      });
      return;
    }

    final messenger = ScaffoldMessenger.maybeOf(context);
    messenger
      ?..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _handleSensitiveFieldEdited() {
    if (!_isAdminModeEnabled) {
      return;
    }
    _restartAdminModeTimer();
  }

  String _currentOperatorUsername() {
    final operatorName = _formControllers.operatorController.text.trim();
    if (operatorName.isNotEmpty) {
      return operatorName;
    }

    final initialOperator = widget.initialOperatorUsername?.trim();
    if (initialOperator != null && initialOperator.isNotEmpty) {
      return initialOperator;
    }

    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess) {
      return authState.user.username;
    }

    return '当前操作员';
  }

  String get _adminModeTimeoutLabel =>
      AdminSupport.formatTimeoutLabel(widget.adminModeTimeout);

  void _logAdminAudit(
    String event, {
    ProductModel? before,
    ProductModel? after,
    String? reason,
    Map<String, Object?> extras = const {},
  }) {
    final anchor = after ?? before ?? widget.product;
    final fields = <String, Object?>{
      'event': event,
      'operator': _currentOperatorUsername(),
      'admin': _adminModeUser?.username,
      'productId': anchor?.id,
      'businessId': anchor?.productId,
      if (reason != null) 'reason': reason,
      ...extras,
    };
    final serialized = fields.entries
        .map((entry) => '${entry.key}=${entry.value ?? '-'}')
        .join(', ');
    _logger.i('Product editor admin audit: $serialized');
  }

  void _restartAdminModeTimer() {
    if (!_isAdminModeEnabled) {
      return;
    }
    _adminModeTimer?.cancel();
    _adminModeTimer = Timer(widget.adminModeTimeout, _handleAdminModeTimeout);
  }

  void _handleAdminModeTimeout() {
    if (!_isAdminModeEnabled || !mounted) {
      return;
    }
    _disableAdminMode(reason: 'timeout', showFeedback: true);
  }

  bool _hasSensitiveFieldChanges(
    ProductModel? existingProduct,
    ProductModel nextProduct,
  ) {
    if (existingProduct == null) {
      return false;
    }

    return existingProduct.isbn != nextProduct.isbn ||
        existingProduct.price != nextProduct.price;
  }

  Future<bool> _requestAdminMode({String reason = 'manual'}) async {
    if (_isAdminModeEnabled) {
      _restartAdminModeTimer();
      return true;
    }

    _logAdminAudit(
      'admin-mode.requested',
      reason: reason,
      extras: {'timeout': _adminModeTimeoutLabel},
    );

    final shouldContinue = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(Icons.admin_panel_settings_outlined),
        title: const Text('需要管理员权限'),
        content: Text(
          '修改 ISBN 和售价需要管理员权限。\n\n当前操作员：${_currentOperatorUsername()}\n\n是否进入管理员模式？',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('暂不'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('进入管理员模式'),
          ),
        ],
      ),
    );

    if (!mounted || shouldContinue != true) {
      _logAdminAudit('admin-mode.request-cancelled', reason: reason);
      return false;
    }

    final verifiedUser = await showDialog<AppUser>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AdminCredentialsDialog(
        verifier: widget.adminModeVerifier,
        modeDescription:
            '请输入管理员级别账户的名称和密码。验证通过后，本次商品资料编辑页会进入管理员模式，允许修改 ISBN 和售价。',
        usernameFieldKey: const ValueKey('product-editor-admin-username'),
        passwordFieldKey: const ValueKey('product-editor-admin-password'),
        auditLogPrefix: 'Product editor admin audit',
      ),
    );

    if (!mounted || verifiedUser == null) {
      _logAdminAudit('admin-mode.verification-cancelled', reason: reason);
      return false;
    }

    setState(() {
      _isAdminModeEnabled = true;
      _adminModeUser = verifiedUser;
    });
    _restartAdminModeTimer();
    _logAdminAudit(
      'admin-mode.granted',
      extras: {'timeout': _adminModeTimeoutLabel},
    );

    _showEditorFeedback('管理员模式已开启：${verifiedUser.username}');
    return true;
  }

  void _disableAdminMode({String reason = 'manual', bool showFeedback = true}) {
    if (!_isAdminModeEnabled) {
      return;
    }

    _adminModeTimer?.cancel();
    _logAdminAudit('admin-mode.ended', reason: reason);

    setState(() {
      _isAdminModeEnabled = false;
      _adminModeUser = null;
    });

    if (!showFeedback || !mounted) {
      return;
    }

    final message = switch (reason) {
      'timeout' => '管理员模式已因长时间未操作自动退出',
      _ => '已退出管理员模式',
    };
    _showEditorFeedback(message);
  }

  Future<void> _startIsbnReceiverService() async {
    if (_appRuntime.isSubWindow) {
      AppLogger.logger.i('Detected sub-window, skipping HTTP server start.');
      return;
    }

    try {
      await _isbnReceiverService.start(
        onIsbnReceived: _formControllers.updateIsbn,
      );
    } on SocketException catch (e) {
      if (e.osError?.errorCode == 10013) {
        _logger.e(
          '端口绑定失败 (errno 10013)。请检查：1. 当前服务端口是否被其他进程占用；2. Windows 防火墙/杀毒软件是否阻挡；3. 以管理员身份运行应用。',
        );
        if (!mounted) return;
        _showEditorFeedback('HTTP 服务启动失败，请检查防火墙或端口占用', isError: true);
      } else {
        _logger.e('Error starting HTTP server and Bonsoir broadcast: $e');
      }
    } catch (e) {
      _logger.e('Error starting HTTP server and Bonsoir broadcast: $e');
    }
  }

  Future<void> _openDesktopScanner() async {
    if (kIsWeb || !(Platform.isWindows || Platform.isMacOS)) {
      if (!mounted) return;
      _showEditorFeedback('当前平台不支持桌面摄像头扫码', isError: true);
      return;
    }

    try {
      _dismissTextInput();
      final result = await showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) => const DesktopIsbnScannerDialog(),
      );

      if (!mounted) return;
      if (result == null || result == '-1') return;

      final isbn = normalizeIsbn(result);
      if (!isLikelyIsbn(isbn)) {
        _showEditorFeedback('识别结果不是有效 ISBN：$result', isError: true);
        return;
      }

      _formControllers.updateIsbn(isbn);
      await _playSuccessSound();
    } catch (e) {
      _logger.e('Desktop scanner error: $e');
      if (!mounted) return;
      _showEditorFeedback('扫码失败：$e', isError: true);
    }
  }

  Future<void> _playSuccessSound() async {
    final audioPlayer = _audioPlayer;
    if (audioPlayer == null) {
      _logger.i(
        'Skipping product editor success audio because the current '
        'sub-window profile does not register the audio plugin.',
      );
      return;
    }

    try {
      await audioPlayer.play(AssetSource('sounds/scan_success.mp3'));
    } on MissingPluginException catch (error, stackTrace) {
      _logger.w(
        'Audio feedback plugin unavailable in product editor window: $error',
        error: error,
        stackTrace: stackTrace,
      );
    } catch (error, stackTrace) {
      _logger.w(
        'Product editor success audio failed: $error',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> _saveOrUpdateBook() async {
    _dismissTextInput();
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final existingProduct = widget.product;
    final draftProduct = _formControllers.buildProduct(
      existingProduct: existingProduct,
    );

    final requiresAdmin = _hasSensitiveFieldChanges(
      existingProduct,
      draftProduct,
    );

    if (requiresAdmin) {
      final granted = await _requestAdminMode(reason: 'save-sensitive-fields');
      if (!mounted || !granted) {
        return;
      }
    }

    final product = _formControllers.buildProduct(
      existingProduct: existingProduct,
    );

    if (_isAdminModeEnabled && existingProduct != null) {
      final isbnChanged = product.isbn != existingProduct.isbn;
      final priceChanged = product.price != existingProduct.price;

      if (isbnChanged || priceChanged) {
        _logAdminAudit(
          'sensitive-fields.updated',
          before: existingProduct,
          after: product,
          extras: {
            'isbnBefore': existingProduct.isbn,
            'isbnAfter': product.isbn,
            'priceBefore': existingProduct.price,
            'priceAfter': product.price,
          },
        );
      }

      _restartAdminModeTimer();
    }

    if (existingProduct != null) {
      context.read<ProductBloc>().add(UpdateBookEvent(product));
    } else {
      context.read<ProductBloc>().add(AddBookEvent(product));
    }
  }

  String? _resolveOperatorForReset() {
    final operatorName = _formControllers.operatorController.text.trim();
    if (operatorName.isNotEmpty) {
      return operatorName;
    }

    final initialOperator = widget.initialOperatorUsername?.trim();
    if (initialOperator != null && initialOperator.isNotEmpty) {
      return initialOperator;
    }

    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess) {
      return authState.user.username;
    }

    return null;
  }

  void _resetEditorAfterCreate() {
    _formKey.currentState?.reset();
    _formControllers.resetForNewEntry(
      operatorUsername: _resolveOperatorForReset(),
    );
  }

  Future<void> _notifyEditorSaved({required int productId}) async {
    if (!_appRuntime.isSubWindow) {
      return;
    }

    try {
      await _editorChannel.invokeMethod('product-editor-saved', {
        'productId': productId,
      });
    } catch (_) {
      // Some host windows don't subscribe to the editor channel.
    }
  }

  void _handleAuthSuccess(AuthSuccess authState) {
    setState(() {
      final hasInitialOperator =
          widget.initialOperatorUsername?.trim().isNotEmpty == true;
      final hasResolvedOperator = _formControllers.operatorController.text
          .trim()
          .isNotEmpty;
      if (!hasInitialOperator && !hasResolvedOperator) {
        _formControllers.setOperator(authState.user.username);
      }
    });
  }

  Future<void> _closeEditor() async {
    if (_appRuntime.isSubWindow) {
      await windowManager.close();
      return;
    }

    final currentWindow = Provider.of<CurrentAppWindow?>(
      context,
      listen: false,
    );
    if (currentWindow != null) {
      context.read<AppWindowManager>().closeWindow(currentWindow.windowId);
      return;
    }

    if (mounted && Navigator.of(context).canPop()) {
      Navigator.pop(context);
    }
  }

  Future<void> _handleProductState(ProductState state) async {
    if (state is ProductAdded) {
      _dismissTextInput();
      await _notifyEditorSaved(productId: state.product.id);
      _resetEditorAfterCreate();
      if (!mounted) {
        return;
      }
      _showEditorFeedback('商品资料已保存并清空表单');
      return;
    }

    if (state is ProductUpdated || state is ProductDeleted) {
      _dismissTextInput();
      final savedProductId = widget.product?.id;
      if (savedProductId != null) {
        await _notifyEditorSaved(productId: savedProductId);
      }
      await _closeEditor();
      return;
    }

    if (state is ProductError) {
      _showEditorFeedback('错误: ${state.message}', isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isUpdate = widget.product != null;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF2EBDD),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, authState) {
              if (authState is AuthSuccess) {
                _handleAuthSuccess(authState);
              }
            },
          ),
          BlocListener<ProductBloc, ProductState>(
            listener: (context, state) => _handleProductState(state),
          ),
        ],
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final normalizedMaxHeight = constraints.maxHeight.isFinite
                    ? math.max(0.0, constraints.maxHeight)
                    : double.infinity;

                return Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 1320,
                      maxHeight: normalizedMaxHeight,
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface.withValues(
                          alpha: 0.98,
                        ),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: const Color(0xFFE3D6C5)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.10),
                            blurRadius: 28,
                            offset: const Offset(0, 16),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(28),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(
                                24,
                                20,
                                24,
                                18,
                              ),
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFF9F4EB),
                                    Color(0xFFF4EADF),
                                  ],
                                ),
                                border: Border(
                                  bottom: BorderSide(color: Color(0xFFE6D8C6)),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          isUpdate ? '编辑商品资料' : '新建商品资料',
                                          style: theme.textTheme.headlineSmall
                                              ?.copyWith(
                                                fontWeight: FontWeight.w800,
                                              ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          isUpdate
                                              ? (_isAdminModeEnabled
                                                    ? '管理员模式已开启：${_adminModeUser?.username ?? '-'} · $_adminModeTimeoutLabel无操作自动退出'
                                                    : '修改 ISBN / 售价时需要管理员权限')
                                              : '新建商品资料',
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
                                                color: const Color(0xFF6B6258),
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(width: 16),
                                  Wrap(
                                    spacing: 12,
                                    runSpacing: 12,
                                    alignment: WrapAlignment.end,
                                    children: [
                                      if (isUpdate)
                                        _isAdminModeEnabled
                                            ? OutlinedButton.icon(
                                                onPressed: () =>
                                                    _disableAdminMode(),
                                                icon: const Icon(
                                                  Icons.lock_open_outlined,
                                                ),
                                                label: Text(
                                                  '管理员模式 · ${_adminModeUser?.username ?? ''}',
                                                ),
                                              )
                                            : OutlinedButton.icon(
                                                onPressed: () {
                                                  unawaited(
                                                    _requestAdminMode(
                                                      reason: 'manual',
                                                    ),
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons
                                                      .admin_panel_settings_outlined,
                                                ),
                                                label: const Text('进入管理员模式'),
                                              ),
                                      FilledButton.icon(
                                        onPressed: _saveOrUpdateBook,
                                        icon: const Icon(Icons.save_outlined),
                                        label: Text(isUpdate ? '保存修改' : '保存资料'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 180),
                              child: _feedbackState == null
                                  ? const SizedBox.shrink()
                                  : _EditorFeedbackBanner(
                                      key: ValueKey(
                                        '${_feedbackState!.isError}:${_feedbackState!.message}',
                                      ),
                                      state: _feedbackState!,
                                    ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                padding: const EdgeInsets.all(24),
                                child: Form(
                                  key: _formKey,
                                  child: ProductInfoEditorFormGrid(
                                    controllers: _formControllers,
                                    onOpenScanner: _openDesktopScanner,
                                    onDropdownChanged: () => setState(() {}),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _EditorFeedbackState {
  const _EditorFeedbackState({required this.message, required this.isError});

  final String message;
  final bool isError;
}

class _EditorFeedbackBanner extends StatelessWidget {
  const _EditorFeedbackBanner({super.key, required this.state});

  final _EditorFeedbackState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = state.isError
        ? const Color(0xFFFDE8E6)
        : const Color(0xFFE8F3E8);
    final borderColor = state.isError
        ? const Color(0xFFE8B4AF)
        : const Color(0xFFB7D8B7);
    final iconColor = state.isError
        ? const Color(0xFFB4473C)
        : const Color(0xFF3E7A45);
    final icon = state.isError
        ? Icons.warning_amber_rounded
        : Icons.check_circle;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  state.message,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF3E3A36),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
