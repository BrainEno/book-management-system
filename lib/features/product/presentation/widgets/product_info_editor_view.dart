import 'dart:async';
import 'dart:math' as math;
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:bookstore_management_system/app/bootstrap/app_runtime.dart';
import 'package:bookstore_management_system/core/common/logger/app_logger.dart';
import 'package:bookstore_management_system/core/di/service_locator.dart';
import 'package:bookstore_management_system/core/window/app_window_manager.dart';
import 'package:bookstore_management_system/core/window/current_app_window.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:bookstore_management_system/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:bookstore_management_system/features/product/presentation/blocs/product_bloc.dart';
import 'package:bookstore_management_system/features/product/presentation/controllers/product_editor_isbn_receiver_service.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_info_editor/desktop_isbn_scanner_dialog.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_info_editor/product_info_editor_form_grid.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_info_editor/product_info_editor_form_state.dart';
import 'package:bookstore_management_system/features/product/utils/isbn_scanner_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

class ProductInfoEditorView extends StatefulWidget {
  const ProductInfoEditorView({
    super.key,
    this.product,
    this.initialDraft,
    this.initialOperatorUsername,
  });

  final ProductModel? product;
  final Map<String, String>? initialDraft;
  final String? initialOperatorUsername;

  @override
  State<ProductInfoEditorView> createState() => _ProductInfoEditorViewState();
}

class _ProductInfoEditorViewState extends State<ProductInfoEditorView> {
  final _logger = AppLogger.logger;
  final _formKey = GlobalKey<FormState>();
  final AudioPlayer _audioPlayer = AudioPlayer();

  late final ProductInfoEditorFormControllers _formControllers;
  late final Box<Map<String, String>> _draftBox;
  late final ProductEditorIsbnReceiverService _isbnReceiverService;
  late final AppRuntime _appRuntime;
  final _editorChannel = const WindowMethodChannel(
    'bookstore_product_editor',
    mode: ChannelMode.unidirectional,
  );
  final _subWindowEvents = const WindowMethodChannel(
    'bookstore_sub_window_events',
    mode: ChannelMode.unidirectional,
  );
  Timer? _draftSyncDebounce;

  @override
  void initState() {
    super.initState();
    _formControllers = ProductInfoEditorFormControllers();
    _draftBox = sl<Box<Map<String, String>>>();
    _isbnReceiverService = ProductEditorIsbnReceiverService();
    _appRuntime = sl<AppRuntime>();
    _applyInitialFormData();
    _registerDraftListeners();
    _startIsbnReceiverService();
    _seedOperatorFromAuthStateIfAvailable();
    if (context.read<AuthBloc>().state is! AuthSuccess &&
        (widget.initialOperatorUsername?.trim().isNotEmpty != true)) {
      context.read<AuthBloc>().add(GetCurrentUserEvent());
    }
  }

  @override
  void dispose() {
    _draftSyncDebounce?.cancel();
    _unregisterDraftListeners();
    _isbnReceiverService.stop();
    _audioPlayer.dispose();
    _formControllers.dispose();
    super.dispose();
  }

  void _applyInitialFormData() {
    if (widget.product != null) {
      _formControllers.populateFromProduct(widget.product!);
    }
    final initialOperatorUsername = widget.initialOperatorUsername?.trim();
    if (initialOperatorUsername != null && initialOperatorUsername.isNotEmpty) {
      _formControllers.setOperator(initialOperatorUsername);
    }
    final draft = widget.initialDraft;
    if (draft != null && draft.isNotEmpty) {
      _formControllers.applyDraftData(draft);
    }
  }

  void _seedOperatorFromAuthStateIfAvailable() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess) {
      _formControllers.setOperator(authState.user.username);
    }
  }

  void _registerDraftListeners() {
    for (final controller in _formControllers.allControllers) {
      controller.addListener(_scheduleDraftSync);
    }
  }

  void _unregisterDraftListeners() {
    for (final controller in _formControllers.allControllers) {
      controller.removeListener(_scheduleDraftSync);
    }
  }

  void _scheduleDraftSync() {
    if (!_appRuntime.isSubWindow || _appRuntime.hostWindowId == null) {
      return;
    }

    _draftSyncDebounce?.cancel();
    _draftSyncDebounce = Timer(const Duration(milliseconds: 180), () {
      unawaited(_syncDraftToParent());
    });
  }

  Future<void> _syncDraftToParent() async {
    final hostWindowId = _appRuntime.hostWindowId;
    if (!_appRuntime.isSubWindow || hostWindowId == null) {
      return;
    }

    try {
      await _subWindowEvents.invokeMethod('sync-editor-draft', {
        'windowId': hostWindowId,
        'draft': _formControllers.buildDraftData(),
      });
    } catch (_) {
      // Best effort.
    }
  }

  void _dismissTextInput() {
    FocusManager.instance.primaryFocus?.unfocus();
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('HTTP 服务启动失败，请检查防火墙或端口占用')),
        );
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('当前平台不支持桌面摄像头扫码')));
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('识别结果不是有效 ISBN：$result')));
        return;
      }

      _formControllers.updateIsbn(isbn);
      await _audioPlayer.play(AssetSource('sounds/scan_success.mp3'));
    } catch (e) {
      _logger.e('Desktop scanner error: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('扫码失败：$e')));
    }
  }

  void _saveOrUpdateBook() {
    _dismissTextInput();
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final product = _formControllers.buildProduct(
      existingProduct: widget.product,
    );
    if (widget.product != null) {
      context.read<ProductBloc>().add(UpdateBookEvent(product));
    } else {
      context.read<ProductBloc>().add(AddBookEvent(product));
    }
  }

  void _saveDraft() {
    _dismissTextInput();
    final isbn = _formControllers.isbnController.text;
    if (isbn.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('请先填写 ISBN 再保存草稿')));
      return;
    }

    _draftBox.put(isbn, _formControllers.buildDraftData());
    unawaited(_syncDraftToParent());
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('草稿已保存')));
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

  Future<void> _clearDraftAfterSave() async {
    final isbn = _formControllers.isbnController.text.trim();
    if (isbn.isNotEmpty) {
      await _draftBox.delete(isbn);
    }
  }

  void _handleAuthSuccess(AuthSuccess authState) {
    setState(() {
      final hasDraftOperator =
          widget.initialDraft?['operator']?.trim().isNotEmpty == true;
      final hasInitialOperator =
          widget.initialOperatorUsername?.trim().isNotEmpty == true;
      if (!hasDraftOperator && !hasInitialOperator) {
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
      await _clearDraftAfterSave();
      _resetEditorAfterCreate();
      await _syncDraftToParent();
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('商品资料已保存并清空表单')));
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('错误: ${state.message}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isUpdate = widget.product != null;
    final theme = Theme.of(context);
    final operatorName = _formControllers.operatorController.text.trim();

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
                                        const SizedBox(height: 6),
                                        Text(
                                          '操作人员：${operatorName.isEmpty ? (widget.initialOperatorUsername ?? '-') : operatorName}',
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
                                                color: const Color(0xFF6F6B65),
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
                                      OutlinedButton.icon(
                                        onPressed: _saveDraft,
                                        icon: const Icon(
                                          Icons.note_add_outlined,
                                        ),
                                        label: const Text('保存草稿'),
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
