import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:bonsoir/bonsoir.dart';
import 'package:bookstore_management_system/core/common/secrets/app_secrets.dart';
import 'package:bookstore_management_system/core/theme/app_pallete.dart';
import 'package:bookstore_management_system/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:bookstore_management_system/features/product/presentation/blocs/product_bloc.dart';
import 'package:bookstore_management_system/features/product/utils/isbn_scanner_utils.dart';
import 'package:bookstore_management_system/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shelf_router/shelf_router.dart' as shelf_router;
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:webview_windows/webview_windows.dart';
import 'package:bookstore_management_system/core/common/logger/app_logger.dart';

class ProductInfoEditorView extends StatefulWidget {
  final ProductModel? product;

  const ProductInfoEditorView({super.key, this.product});

  @override
  State<ProductInfoEditorView> createState() => _ProductInfoEditorViewState();
}

class _ProductInfoEditorViewState extends State<ProductInfoEditorView> {
  final _logger = AppLogger.logger;
  final _formKey = GlobalKey<FormState>();
  final AudioPlayer _audioPlayer = AudioPlayer();

  late final TextEditingController _bookIdController;
  late final TextEditingController _idController;
  late final TextEditingController _titleController;
  late final TextEditingController _authorController;
  late final TextEditingController _isbnController;
  late final TextEditingController _priceController;
  late final TextEditingController _categoryController;
  late final TextEditingController _publisherController;
  late final TextEditingController _selfEncodingController;
  late final TextEditingController _internalPricingController;
  late final TextEditingController _purchasePriceController;
  late final TextEditingController _publicationYearController;
  late final TextEditingController _retailDiscountController;
  late final TextEditingController _wholesaleDiscountController;
  late final TextEditingController _wholesalePriceController;
  late final TextEditingController _memberDiscountController;
  late final TextEditingController _purchaseSaleModeController;
  late final TextEditingController _bookmarkController;
  late final TextEditingController _packagingController;
  late final TextEditingController _properityController;
  late final TextEditingController _statisticalClassController;
  late final TextEditingController _operatorController;

  HttpServer? _server;
  BonsoirBroadcast? _broadcast;
  late final Box _draftBox;

  final List<String> _categoryOptions = ['不区分', '小说', '科技', '教育', '历史', '儿童'];
  final List<String> _publisherOptions = [
    '不区分',
    '人民出版社',
    '清华大学出版社',
    '上海文艺出版社',
    '北京大学出版社',
  ];
  final List<String> _purchaseSaleModeOptions = ['不区分', '零售', '批发', '会员特价'];
  final List<String> _packagingOptions = ['不区分', '精装', '平装', '简装'];
  final List<String> _properityOptions = ['不区分', '普通图书', '畅销书', '新书'];
  final List<String> _statisticalClassOptions = [
    '不区分',
    '小说',
    '诗歌',
    '哲学',
    '人类学',
    '传记',
    '社会学',
    '历史',
    '非虚构',
    '其他',
  ];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _startService();
    _draftBox = GetIt.instance<Box<Map<String, String>>>();
    context.read<AuthBloc>().add(GetCurrentUserEvent());
  }

  void _initializeControllers() {
    _bookIdController = TextEditingController();
    _idController = TextEditingController();
    _titleController = TextEditingController();
    _authorController = TextEditingController();
    _isbnController = TextEditingController();
    _priceController = TextEditingController();
    _categoryController = TextEditingController(text: '不区分');
    _publisherController = TextEditingController(text: '不区分');
    _selfEncodingController = TextEditingController();
    _internalPricingController = TextEditingController();
    _purchasePriceController = TextEditingController();
    _publicationYearController = TextEditingController();
    _retailDiscountController = TextEditingController();
    _wholesaleDiscountController = TextEditingController();
    _wholesalePriceController = TextEditingController();
    _memberDiscountController = TextEditingController();
    _purchaseSaleModeController = TextEditingController(text: '不区分');
    _bookmarkController = TextEditingController(text: '08/404');
    _packagingController = TextEditingController(text: '不区分');
    _properityController = TextEditingController(text: '不区分');
    _statisticalClassController = TextEditingController(text: '不区分');
    _operatorController = TextEditingController();
  }

  void _populateFields(ProductModel product) {
    _bookIdController.text = product.productId;
    _idController.text = product.id.toString();
    _titleController.text = product.title;
    _authorController.text = product.author;
    _isbnController.text = product.isbn;
    _priceController.text = product.price.toString();
    _categoryController.text = product.category;
    _publisherController.text = product.publisher;
    _selfEncodingController.text = product.selfEncoding;
    _internalPricingController.text = product.internalPricing.toString();
    _purchasePriceController.text = product.purchasePrice.toString();
    _publicationYearController.text = product.publicationYear.toString();
    _retailDiscountController.text = product.retailDiscount.toString();
    _wholesaleDiscountController.text = product.wholesaleDiscount.toString();
    _wholesalePriceController.text = product.wholesalePrice.toString();
    _memberDiscountController.text = product.memberDiscount.toString();
    _purchaseSaleModeController.text =
        product.purchaseSaleMode.isEmpty ? '不区分' : product.purchaseSaleMode;
    _bookmarkController.text =
        product.bookmark.isEmpty ? '08/404' : product.bookmark;
    _packagingController.text =
        product.packaging.isEmpty ? '不区分' : product.packaging;
    _properityController.text =
        product.properity.isEmpty ? '不区分' : product.properity;
    _statisticalClassController.text =
        product.statisticalClass.isEmpty ? '不区分' : product.statisticalClass;
  }

  @override
  void dispose() {
    _broadcast?.stop();
    _server?.close();
    _audioPlayer.dispose();
    _disposeControllers();
    super.dispose();
  }

  void _disposeControllers() {
    _bookIdController.dispose();
    _idController.dispose();
    _titleController.dispose();
    _authorController.dispose();
    _isbnController.dispose();
    _priceController.dispose();
    _categoryController.dispose();
    _publisherController.dispose();
    _selfEncodingController.dispose();
    _internalPricingController.dispose();
    _purchasePriceController.dispose();
    _publicationYearController.dispose();
    _retailDiscountController.dispose();
    _wholesaleDiscountController.dispose();
    _wholesalePriceController.dispose();
    _memberDiscountController.dispose();
    _purchaseSaleModeController.dispose();
    _bookmarkController.dispose();
    _packagingController.dispose();
    _properityController.dispose();
    _statisticalClassController.dispose();
    _operatorController.dispose();
  }

  // ... 其他代码不变，仅替换 _startService 方法 ...

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
            if (mounted) {
              setState(() {
                _isbnController.text = isbn;
                _selfEncodingController.text = isbn;
              });
            }
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
      final InternetAddress localAddress = interfaces
          .expand((i) => i.addresses)
          .firstWhere((addr) => !addr.isLoopback);
      final ipv4 = localAddress.address;

      _logger.i('HTTP server listening on http://$ipv4:$port');

      final service = BonsoirService(
        name: 'Bookstore Desktop',
        type: AppSecrets.serviceType!,
        port: port,
        attributes: {'ip': ipv4},
      );

      _broadcast = BonsoirBroadcast(service: service);
      await _broadcast!.isReady;
      await _broadcast!.start();

      _logger.i(
        'Advertised Bonsoir service ${AppSecrets.serviceType} on port $port with IP $ipv4',
      );
    } on SocketException catch (e) {
      if (e.osError?.errorCode == 10013) {
        _logger.e(
          '端口绑定失败 (errno 10013)。请检查：1. 端口 ${AppSecrets.servicePort} 是否被其他进程占用（命令：netstat -ano | findstr ${AppSecrets.servicePort}）；2. Windows 防火墙/杀毒软件是否阻挡；3. 以管理员身份运行应用。',
        );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('HTTP 服务启动失败，请检查防火墙或端口占用')),
          );
        }
      } else {
        _logger.e('Error starting HTTP server and Bonsoir broadcast: $e');
      }
    } catch (e) {
      _logger.e('Error starting HTTP server and Bonsoir broadcast: $e');
    }
  }

  Future<void> _openDesktopScanner() async {
    if (kIsWeb ||
        !(Platform.isWindows || Platform.isMacOS || Platform.isLinux)) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('当前平台不支持桌面摄像头扫码')));
      return;
    }

    try {
      final result = await showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) => const _DesktopIsbnScannerDialog(),
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

      setState(() {
        _isbnController.text = isbn;
        _selfEncodingController.text = isbn;
      });
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
    if (_formKey.currentState!.validate()) {
      final product = ProductModel(
        productId: _bookIdController.text,
        id: int.tryParse(_idController.text) ?? 0,
        title: _titleController.text,
        author: _authorController.text,
        isbn: _isbnController.text,
        price: double.tryParse(_priceController.text) ?? 0.0,
        category: _categoryController.text,
        publisher: _publisherController.text,
        selfEncoding: _selfEncodingController.text,
        internalPricing:
            double.tryParse(_internalPricingController.text) ?? 0.0,
        purchasePrice: double.tryParse(_purchasePriceController.text) ?? 0.0,
        publicationYear: int.tryParse(_publicationYearController.text) ?? 2025,
        retailDiscount:
            double.tryParse(_retailDiscountController.text) ?? 100.0,
        wholesaleDiscount:
            double.tryParse(_wholesaleDiscountController.text) ?? 100.0,
        wholesalePrice: double.tryParse(_wholesalePriceController.text) ?? 0.0,
        memberDiscount:
            double.tryParse(_memberDiscountController.text) ?? 100.0,
        purchaseSaleMode: _purchaseSaleModeController.text,
        bookmark:
            _bookmarkController.text.isEmpty ? '不区分' : _bookmarkController.text,
        packaging: _packagingController.text,
        properity: _properityController.text,
        statisticalClass: _statisticalClassController.text,
        operator: _operatorController.text,
        createdAt: widget.product?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      if (widget.product != null) {
        context.read<ProductBloc>().add(UpdateBookEvent(product));
      } else {
        context.read<ProductBloc>().add(AddBookEvent(product));
      }
    }
  }

  void _saveDraft() {
    final isbn = _isbnController.text;
    if (isbn.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('ISBN is required')));
      return;
    }
    final draftData = {
      'productId': _bookIdController.text,
      'id': _idController.text,
      'title': _titleController.text,
      'author': _authorController.text,
      'isbn': isbn,
      'price': _priceController.text,
      'category': _categoryController.text,
      'publisher': _publisherController.text,
      'selfEncoding': _selfEncodingController.text,
      'internalPricing': _internalPricingController.text,
      'purchasePrice': _purchasePriceController.text,
      'publicationYear': _publicationYearController.text,
      'retailDiscount': _retailDiscountController.text,
      'wholesaleDiscount': _wholesaleDiscountController.text,
      'wholesalePrice': _wholesalePriceController.text,
      'memberDiscount': _memberDiscountController.text,
      'purchaseSaleMode': _purchaseSaleModeController.text,
      'bookmark': _bookmarkController.text,
      'packaging': _packagingController.text,
      'properity': _properityController.text,
      'statisticalClass': _statisticalClassController.text,
      'operator': _operatorController.text,
    };
    _draftBox.put(isbn, draftData);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Draft saved')));
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
                setState(() {
                  if (widget.product != null) _populateFields(widget.product!);
                  _operatorController.text = authState.user.username;
                });
              }
            },
          ),
          BlocListener<ProductBloc, ProductState>(
            listener: (context, state) {
              if (state is ProductAdded ||
                  state is ProductUpdated ||
                  state is ProductDeleted) {
                Navigator.pop(context);
              } else if (state is ProductError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('错误: ${state.message}')));
              }
            },
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
                _buildGrid(),
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

  Widget _buildGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossCount = constraints.maxWidth > 800 ? 4 : 2;
        return GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossCount,
            crossAxisSpacing: 32,
            mainAxisSpacing: 32,
            childAspectRatio: 3.2,
          ),
          children: [
            _textField(_bookIdController, '图书ID', required: true),
            _textField(
              _idController,
              'ID',
              type: TextInputType.number,
              required: true,
            ),
            _textField(
              _isbnController,
              'ISBN',
              required: true,
              suffixIcon: IconButton(
                icon: const Icon(Icons.qr_code_scanner, color: Colors.blue),
                onPressed: _openDesktopScanner,
              ),
            ),
            _textField(_titleController, '书名', required: true),
            _textField(_authorController, '作者', required: true),
            _dropdown(_categoryController, '商品分类', _categoryOptions),
            _dropdown(_publisherController, '出版社', _publisherOptions),
            _textField(_selfEncodingController, '自编码'),
            _textField(
              _priceController,
              '售价',
              type: TextInputType.number,
              required: true,
            ),
            _textField(
              _internalPricingController,
              '内部定价',
              type: TextInputType.number,
            ),
            _textField(
              _purchasePriceController,
              '进货价',
              type: TextInputType.number,
            ),
            _textField(
              _publicationYearController,
              '出版年',
              type: TextInputType.number,
            ),
            _textField(
              _retailDiscountController,
              '零售折扣',
              type: TextInputType.number,
            ),
            _textField(
              _wholesaleDiscountController,
              '批发折扣',
              type: TextInputType.number,
            ),
            _textField(
              _wholesalePriceController,
              '批发价',
              type: TextInputType.number,
            ),
            _textField(
              _memberDiscountController,
              '会员折扣',
              type: TextInputType.number,
            ),
            _dropdown(
              _purchaseSaleModeController,
              '购销方式',
              _purchaseSaleModeOptions,
            ),
            _textField(_bookmarkController, '书标'),
            _dropdown(_packagingController, '包装', _packagingOptions),
            _dropdown(_properityController, '商品属性', _properityOptions),
            _dropdown(
              _statisticalClassController,
              '统计分类',
              _statisticalClassOptions,
            ),
            _textField(_operatorController, '操作人员', readOnly: true),
          ],
        );
      },
    );
  }

  Widget _textField(
    TextEditingController ctrl,
    String label, {
    TextInputType type = TextInputType.text,
    bool required = false,
    Widget? suffixIcon,
    bool readOnly = false,
  }) {
    return TextFormField(
      controller: ctrl,
      keyboardType: type,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: required ? '$label *' : label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        filled: true,
        fillColor: Colors.grey[100],
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator:
          required
              ? (v) => v == null || v.isEmpty ? '$label 不能为空' : null
              : null,
    );
  }

  Widget _dropdown(
    TextEditingController ctrl,
    String label,
    List<String> opts,
  ) {
    return DropdownButtonFormField<String>(
      value: opts.contains(ctrl.text) ? ctrl.text : opts.first,
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      items:
          opts.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: (v) => setState(() => ctrl.text = v!),
    );
  }
}

class _DesktopIsbnScannerDialog extends StatefulWidget {
  const _DesktopIsbnScannerDialog();

  @override
  State<_DesktopIsbnScannerDialog> createState() =>
      _DesktopIsbnScannerDialogState();
}

class _DesktopIsbnScannerDialogState extends State<_DesktopIsbnScannerDialog> {
  final WebviewController _controller = WebviewController();
  StreamSubscription<dynamic>? _webMessageSub;
  HttpServer? _assetServer;
  String _pageUrl = '';
  WebviewPermissionDecision _permissionDecision =
      WebviewPermissionDecision.none;
  bool _hasAskedPermission = false;
  bool _isReady = false;
  String? _errorText;
  String _statusText = '初始化扫描器...';
  ScannerDebugMetrics _metrics = const ScannerDebugMetrics();

  @override
  void initState() {
    super.initState();
    _initScannerPage();
  }

  @override
  void dispose() {
    _webMessageSub?.cancel();
    _assetServer?.close(force: true);
    super.dispose();
  }

  Future<void> _initScannerPage() async {
    try {
      _pageUrl = await _startLocalScannerAssetServer();
      await _controller.initialize();
      await _controller.loadUrl(_pageUrl);

      _webMessageSub = _controller.webMessage.listen((event) {
        final methodName = event['methodName'] as String?;
        final data = event['data'];

        if (!mounted) return;
        if (methodName == 'successCallback') {
          final result = data?.toString() ?? '';
          if (result.isNotEmpty) {
            Navigator.of(context).pop(result);
          }
          return;
        }

        if (methodName == 'errorCallback') {
          final message = data?.toString() ?? '未知错误';
          setState(() {
            _errorText = message;
            _metrics = _metrics.copyWith(startupError: message);
          });
          return;
        }

        if (methodName == 'statusCallback') {
          setState(() => _statusText = data?.toString() ?? _statusText);
          return;
        }

        if (methodName == 'metricsCallback' && data is Map) {
          setState(() {
            _metrics = _metrics.copyWith(
              cameraCount: _toInt(data['cameraCount'], _metrics.cameraCount),
              cameraLabel:
                  data['cameraLabel']?.toString() ?? _metrics.cameraLabel,
              decodeErrorCount: _toInt(
                data['decodeErrors'],
                _metrics.decodeErrorCount,
              ),
              elapsedSeconds: _toInt(
                data['elapsedSeconds'],
                _metrics.elapsedSeconds,
              ),
              requestedWidth: _toInt(
                data['requestedWidth'],
                _metrics.requestedWidth,
              ),
              requestedHeight: _toInt(
                data['requestedHeight'],
                _metrics.requestedHeight,
              ),
              cameraFound: _toInt(data['cameraCount'], 0) > 0,
              pageUrl: data['pageUrl']?.toString() ?? _metrics.pageUrl,
              secureContext: data['secureContext'] == true,
              engine: data['engine']?.toString() ?? _metrics.engine,
              lastDecodeError:
                  data['lastDecodeError']?.toString() ??
                  _metrics.lastDecodeError,
            );
          });
        }
      });

      if (!mounted) return;
      setState(() => _isReady = true);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isReady = true;
        _errorText = '初始化桌面扫描器失败: $e';
      });
    }
  }

  Future<String> _startLocalScannerAssetServer() async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    _assetServer = server;
    final baseUrl = 'http://127.0.0.1:${server.port}';
    _statusText = '本地扫描服务已启动：$baseUrl';

    server.listen((request) async {
      try {
        final normalizedPath = request.uri.path.replaceFirst(
          RegExp(r'^/+'),
          '',
        );
        switch (normalizedPath) {
          case '':
          case 'isbn_scanner.html':
            final html = await rootBundle.loadString(
              'assets/scanner/isbn_scanner.html',
            );
            request.response.headers.contentType = ContentType.html;
            request.response.write(html);
            break;
          case 'html5-qrcode.min.js':
            final data = await rootBundle.load(
              'assets/scanner/html5-qrcode.min.js',
            );
            request.response.headers.contentType = ContentType(
              'application',
              'javascript',
              charset: 'utf-8',
            );
            request.response.add(_byteDataToBytes(data));
            break;
          default:
            request.response.statusCode = HttpStatus.notFound;
            request.response.write('Not found');
        }
      } catch (e) {
        request.response.statusCode = HttpStatus.internalServerError;
        request.response.write('Asset server error: $e');
      } finally {
        await request.response.close();
      }
    });

    return '$baseUrl/isbn_scanner.html';
  }

  List<int> _byteDataToBytes(ByteData data) {
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  Future<void> _closeDialog() async {
    try {
      await _controller.postWebMessage(jsonEncode({'event': 'close'}));
    } catch (_) {}
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future<WebviewPermissionDecision> _onPermissionRequested(
    BuildContext context,
    WebviewPermissionKind permissionKind,
  ) async {
    if (_hasAskedPermission) {
      return _permissionDecision == WebviewPermissionDecision.none
          ? WebviewPermissionDecision.deny
          : _permissionDecision;
    }
    _hasAskedPermission = true;

    final decision = await showDialog<WebviewPermissionDecision>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('请求摄像头权限'),
            content: Text('扫描 ISBN 需要 ${permissionKind.name} 权限，是否允许？'),
            actions: [
              TextButton(
                onPressed:
                    () => Navigator.of(ctx).pop(WebviewPermissionDecision.deny),
                child: const Text('拒绝'),
              ),
              FilledButton(
                onPressed:
                    () =>
                        Navigator.of(ctx).pop(WebviewPermissionDecision.allow),
                child: const Text('允许'),
              ),
            ],
          ),
    );
    final finalDecision = decision ?? WebviewPermissionDecision.deny;
    _permissionDecision = finalDecision;
    if (!mounted) return finalDecision;
    setState(() {
      _metrics = _metrics.copyWith(
        permissionGranted: finalDecision == WebviewPermissionDecision.allow,
      );
      _statusText =
          finalDecision == WebviewPermissionDecision.allow
              ? '摄像头权限已授予，准备开始扫描...'
              : '摄像头权限被拒绝';
    });
    return finalDecision;
  }

  int _toInt(dynamic value, int fallback) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? fallback;
    return fallback;
  }

  String _buildDebugCode() {
    final suggestion = buildScannerDiagnosis(_metrics);
    return [
      'ISBN_SCANNER_DEBUG_V1',
      'time=${DateTime.now().toIso8601String()}',
      'platform=${Platform.operatingSystem}',
      'status=$_statusText',
      'error=${_errorText ?? ''}',
      'pageUrl=${_metrics.pageUrl.isEmpty ? _pageUrl : _metrics.pageUrl}',
      'secureContext=${_metrics.secureContext}',
      'engine=${_metrics.engine}',
      'cameraLabel=${_metrics.cameraLabel}',
      'cameraCount=${_metrics.cameraCount}',
      'permissionGranted=${_metrics.permissionGranted}',
      'decodeErrors=${_metrics.decodeErrorCount}',
      'elapsedSeconds=${_metrics.elapsedSeconds}',
      'requestedResolution=${_metrics.requestedWidth}x${_metrics.requestedHeight}',
      'lastDecodeError=${_metrics.lastDecodeError}',
      'startupError=${_metrics.startupError}',
      'diagnosis=$suggestion',
    ].join('\n');
  }

  Future<void> _copyDebugCode() async {
    final debugCode = _buildDebugCode();
    await Clipboard.setData(ClipboardData(text: debugCode));
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('调试码已复制到剪贴板')));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: 1100,
        height: 760,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  const Text(
                    '桌面 ISBN 扫描',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: _closeDialog,
                    icon: const Icon(Icons.close),
                    tooltip: '关闭',
                  ),
                  IconButton(
                    onPressed: _copyDebugCode,
                    icon: const Icon(Icons.copy_all),
                    tooltip: '复制调试码',
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child:
                  !_isReady
                      ? const Center(child: CircularProgressIndicator())
                      : _errorText != null
                      ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(
                            _errorText!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.redAccent),
                          ),
                        ),
                      )
                      : Webview(
                        _controller,
                        permissionRequested:
                            (url, permissionKind, isUserInitiated) =>
                                _onPermissionRequested(context, permissionKind),
                      ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: const BoxDecoration(
                color: Color(0xFFF8FAFC),
                border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _ScanWaveIndicator(),
                  const SizedBox(height: 8),
                  Text(
                    '调试状态: $_statusText',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 14,
                    runSpacing: 6,
                    children: [
                      Text('摄像头: ${_metrics.cameraLabel}'),
                      Text('设备数: ${_metrics.cameraCount}'),
                      Text('权限: ${_metrics.permissionGranted ? '已允许' : '未允许'}'),
                      Text('解码失败: ${_metrics.decodeErrorCount}'),
                      Text('运行时长: ${_metrics.elapsedSeconds}s'),
                      Text(
                        '请求分辨率: ${_metrics.requestedWidth}x${_metrics.requestedHeight}',
                      ),
                      Text('安全上下文: ${_metrics.secureContext ? '是' : '否'}'),
                      Text('扫描引擎: ${_metrics.engine}'),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '诊断建议: ${buildScannerDiagnosis(_metrics)}',
                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScanWaveIndicator extends StatelessWidget {
  const _ScanWaveIndicator();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: const LinearProgressIndicator(minHeight: 6),
    );
  }
}
