import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:bonsoir/bonsoir.dart';
import 'package:bookstore_management_system/core/common/logger/app_logger.dart';
import 'package:bookstore_management_system/core/common/secrets/app_secrets.dart';
import 'package:bookstore_management_system/core/theme/app_pallete.dart';
import 'package:bookstore_management_system/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:bookstore_management_system/features/product/presentation/blocs/product_bloc.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_info_editor/desktop_isbn_scanner_dialog.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_info_editor/product_info_editor_form_grid.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_info_editor/product_info_editor_form_state.dart';
import 'package:bookstore_management_system/features/product/utils/isbn_scanner_utils.dart';
import 'package:bookstore_management_system/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart' as shelf_router;

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

  HttpServer? _server;
  BonsoirBroadcast? _broadcast;

  @override
  void initState() {
    super.initState();
    _formControllers = ProductInfoEditorFormControllers();
    _draftBox = GetIt.instance<Box<Map<String, String>>>();
    _startService();
    context.read<AuthBloc>().add(GetCurrentUserEvent());
  }

  @override
  void dispose() {
    _broadcast?.stop();
    _server?.close();
    _audioPlayer.dispose();
    _formControllers.dispose();
    super.dispose();
  }

  void _dismissTextInput() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future<void> _startService() async {
    if (isSubWindowInstance) {
      AppLogger.logger.i('Detected sub-window, skipping HTTP server start.');
      return;
    }

    try {
      final router =
          shelf_router.Router()..post('/isbn', (Request req) async {
            final isbn = await req.readAsString();
            _logger.i('Received ISBN via HTTP: $isbn');
            _formControllers.updateIsbn(isbn);
            return Response.ok('OK');
          });

      _server = await io.serve(
        logRequests().addHandler(router.call),
        InternetAddress.anyIPv4,
        AppSecrets.servicePort,
      );

      final port = _server!.port;
      final interfaces = await NetworkInterface.list(
        type: InternetAddressType.IPv4,
        includeLoopback: false,
      );
      final localAddress = interfaces
          .expand((interface) => interface.addresses)
          .firstWhere((address) => !address.isLoopback);
      final ipv4 = localAddress.address;

      _logger.i('HTTP server listening on http://$ipv4:$port');

      final service = BonsoirService(
        name: 'Bookstore Desktop',
        type: AppSecrets.serviceType!,
        port: port,
        attributes: {'ip': ipv4},
      );

      _broadcast = BonsoirBroadcast(service: service);
      await _broadcast!.initialize();
      await _broadcast!.start();

      _logger.i(
        'Advertised Bonsoir service ${AppSecrets.serviceType} on port $port with IP $ipv4',
      );
    } on SocketException catch (e) {
      if (e.osError?.errorCode == 10013) {
        _logger.e(
          '端口绑定失败 (errno 10013)。请检查：1. 端口 ${AppSecrets.servicePort} 是否被其他进程占用（命令：netstat -ano | findstr ${AppSecrets.servicePort}）；2. Windows 防火墙/杀毒软件是否阻挡；3. 以管理员身份运行应用。',
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
      ).showSnackBar(const SnackBar(content: Text('ISBN is required')));
      return;
    }

    _draftBox.put(isbn, _formControllers.buildDraftData());
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Draft saved')));
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
                Text('图书信息', style: Theme.of(context).textTheme.headlineSmall),
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'draft',
            onPressed: _saveDraft,
            backgroundColor: Colors.green,
            child: const Icon(Icons.drafts),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'save',
            onPressed: _saveOrUpdateBook,
            backgroundColor: const Color(0xFF3A4568),
            child: Icon(isUpdate ? Icons.update : Icons.save),
          ),
        ],
      ),
    );
  }
}
