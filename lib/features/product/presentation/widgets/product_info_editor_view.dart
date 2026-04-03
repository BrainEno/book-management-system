import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:bookstore_management_system/app/bootstrap/app_runtime.dart';
import 'package:bookstore_management_system/core/common/logger/app_logger.dart';
import 'package:bookstore_management_system/core/di/service_locator.dart';
import 'package:bookstore_management_system/core/theme/app_pallete.dart';
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
import 'package:window_manager/window_manager.dart';

class ProductInfoEditorView extends StatefulWidget {
  const ProductInfoEditorView({super.key, this.product});

  final ProductModel? product;

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

  @override
  void initState() {
    super.initState();
    _formControllers = ProductInfoEditorFormControllers();
    _draftBox = sl<Box<Map<String, String>>>();
    _isbnReceiverService = ProductEditorIsbnReceiverService();
    _appRuntime = sl<AppRuntime>();
    _startIsbnReceiverService();
    context.read<AuthBloc>().add(GetCurrentUserEvent());
  }

  @override
  void dispose() {
    _isbnReceiverService.stop();
    _audioPlayer.dispose();
    _formControllers.dispose();
    super.dispose();
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
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('草稿已保存')));
  }

  void _handleAuthSuccess(AuthSuccess authState) {
    setState(() {
      if (widget.product != null) {
        _formControllers.populateFromProduct(widget.product!);
      }
      _formControllers.setOperator(authState.user.username);
    });
  }

  Future<void> _closeEditor() async {
    if (_appRuntime.isSubWindow) {
      await windowManager.close();
      return;
    }

    if (mounted && Navigator.of(context).canPop()) {
      Navigator.pop(context);
    }
  }

  Future<void> _handleProductState(ProductState state) async {
    if (state is ProductAdded ||
        state is ProductUpdated ||
        state is ProductDeleted) {
      _dismissTextInput();
      final savedProductId = state is ProductAdded
          ? state.product.id
          : widget.product?.id;
      if (_appRuntime.isSubWindow && savedProductId != null) {
        await _editorChannel.invokeMethod('product-editor-saved', {
          'productId': savedProductId,
        });
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
    final windowId = _appRuntime.windowId;
    final idBadge = isUpdate ? '内部 ID ${widget.product!.id}' : '内部 ID 保存后生成';

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
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 1320,
                  maxHeight: MediaQuery.sizeOf(context).height - 40,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface.withValues(alpha: 0.98),
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
                          padding: const EdgeInsets.fromLTRB(24, 20, 24, 18),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFFF9F4EB), Color(0xFFF4EADF)],
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      '把最重要的字段放在前面，保存后会自动同步到商品查询页。',
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                            color: const Color(0xFF6F6B65),
                                          ),
                                    ),
                                    const SizedBox(height: 12),
                                    Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      children: [
                                        _HeaderPill(
                                          label: '内部主键',
                                          value: idBadge,
                                        ),
                                        _HeaderPill(
                                          label: '操作人员',
                                          value:
                                              _formControllers
                                                  .operatorController
                                                  .text
                                                  .isEmpty
                                              ? '加载中'
                                              : _formControllers
                                                    .operatorController
                                                    .text,
                                        ),
                                        if (_appRuntime.isSubWindow &&
                                            windowId?.isNotEmpty == true)
                                          _HeaderPill(
                                            label: '子窗口',
                                            value: '#$windowId',
                                          ),
                                      ],
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
                                    icon: const Icon(Icons.note_add_outlined),
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
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderPill extends StatelessWidget {
  const _HeaderPill({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F1E7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2D3BF)),
      ),
      child: RichText(
        text: TextSpan(
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppPallete.ink),
          children: [
            TextSpan(
              text: '$label\n',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}
