import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:bookstore_management_system/app/bootstrap/app_runtime.dart';
import 'package:bookstore_management_system/core/common/logger/app_logger.dart';
import 'package:bookstore_management_system/core/di/service_locator.dart';
import 'package:bookstore_management_system/core/theme/app_pallete.dart';
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

  void _handleProductState(ProductState state) {
    if (state is ProductAdded ||
        state is ProductUpdated ||
        state is ProductDeleted) {
      _dismissTextInput();
      Navigator.pop(context);
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

    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdate ? '更新图书信息' : '添加图书信息'),
        backgroundColor: AppPallete.transparentColor,
      ),
      backgroundColor: const Color(0xFFF6F1E8),
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '图书信息',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '完善商品基础资料、归类信息与经营参数，保存后会同步到查询页面。',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF6F6B65),
                  ),
                ),
                const SizedBox(height: 24),
                ProductInfoEditorFormGrid(
                  controllers: _formControllers,
                  onOpenScanner: _openDesktopScanner,
                  onDropdownChanged: () => setState(() {}),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
          decoration: BoxDecoration(
            color: Theme.of(
              context,
            ).colorScheme.surface.withValues(alpha: 0.96),
            border: const Border(top: BorderSide(color: Color(0xFFE6DCCF))),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 16,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(onPressed: _saveDraft, child: const Text('保存草稿')),
              const SizedBox(width: 12),
              FilledButton(
                onPressed: _saveOrUpdateBook,
                child: Text(isUpdate ? '保存修改' : '保存资料'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
