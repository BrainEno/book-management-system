import 'dart:io';
import 'package:bonsoir/bonsoir.dart';
import 'package:bookstore_management_system/core/common/secrets/app_secrets.dart';
import 'package:bookstore_management_system/core/theme/app_pallete.dart';
import 'package:bookstore_management_system/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookstore_management_system/features/book/data/models/book_model.dart';
import 'package:bookstore_management_system/features/book/presentation/blocs/book_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:shelf_router/shelf_router.dart' as shelf_router;
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:bookstore_management_system/core/common/logger/app_logger.dart';

class ProductInfoEditorView extends StatefulWidget {
  final BookModel? book;

  const ProductInfoEditorView({super.key, this.book});

  @override
  State<ProductInfoEditorView> createState() => _ProductInfoEditorViewState();
}

class _ProductInfoEditorViewState extends State<ProductInfoEditorView> {
  final _logger = AppLogger.logger;
  final _formKey = GlobalKey<FormState>();
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

  void _populateFields(BookModel book) {
    _bookIdController.text = book.bookId;
    _idController.text = book.id.toString();
    _titleController.text = book.title;
    _authorController.text = book.author;
    _isbnController.text = book.isbn;
    _priceController.text = book.price.toString();
    _categoryController.text = book.category;
    _publisherController.text = book.publisher;
    _selfEncodingController.text = book.selfEncoding;
    _internalPricingController.text = book.internalPricing.toString();
    _purchasePriceController.text = book.purchasePrice.toString();
    _publicationYearController.text = book.publicationYear.toString();
    _retailDiscountController.text = book.retailDiscount.toString();
    _wholesaleDiscountController.text = book.wholesaleDiscount.toString();
    _wholesalePriceController.text = book.wholesalePrice.toString();
    _memberDiscountController.text = book.memberDiscount.toString();
    _purchaseSaleModeController.text =
        book.purchaseSaleMode.isEmpty ? '不区分' : book.purchaseSaleMode;
    _bookmarkController.text = book.bookmark.isEmpty ? '08/404' : book.bookmark;
    _packagingController.text = book.packaging.isEmpty ? '不区分' : book.packaging;
    _properityController.text = book.properity.isEmpty ? '不区分' : book.properity;
    _statisticalClassController.text =
        book.statisticalClass.isEmpty ? '不区分' : book.statisticalClass;
    _operatorController.text = book.operator;
  }

  @override
  void dispose() {
    _broadcast?.stop();
    _server?.close();
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

  Future<void> _startService() async {
    final router =
        shelf_router.Router()..post('/isbn', (Request req) async {
          final isbn = await req.readAsString();
          _logger.i('Received ISBN via HTTP: $isbn');
          setState(() {
            _isbnController.text = isbn;
            _selfEncodingController.text = isbn;
          });
          return Response.ok('OK');
        });

    final interfaces = await NetworkInterface.list(
      type: InternetAddressType.IPv4,
      includeLoopback: false,
    );

    final InternetAddress localAddress = interfaces
        .expand((i) => i.addresses)
        .firstWhere((addr) => !addr.isLoopback);

    final ipv4 = localAddress.address;

    _server = await io.serve(
      logRequests().addHandler(router.call),
      ipv4,
      AppSecrets.servicePort,
    );

    final port = _server!.port;

    _logger.i('HTTP server listening on http://$ipv4:$port');

    final service = BonsoirService(
      name: 'Bookstore Desktop',
      type: AppSecrets.serviceType!,
      port: port,
      attributes: {'ip': ipv4},
    );

    _broadcast = BonsoirBroadcast(service: service);

    await _broadcast!.ready;
    await _broadcast!.start();
    _logger.i(
      'Advertised Bonsoir service ${AppSecrets.serviceType} on port $port with IP $ipv4',
    );
  }

  void _saveOrUpdateBook() {
    if (_formKey.currentState!.validate()) {
      final book = BookModel(
        bookId: _bookIdController.text,
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
        createdAt: widget.book?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      if (widget.book != null) {
        context.read<BookBloc>().add(UpdateBookEvent(book));
      } else {
        context.read<BookBloc>().add(AddBookEvent(book));
      }
    }
  }

  void _saveDraft() {
    final isbn = _isbnController.text;
    if (isbn.isNotEmpty) {
      final draftData = {
        'bookId': _bookIdController.text,
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ISBN is required to save draft')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isUpdate = widget.book != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isUpdate ? '更新图书信息' : '添加图书信息',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppPallete.transparentColor,
        actions: [
          if (isUpdate)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.white),
              onPressed: () {
                context.read<BookBloc>().add(DeleteBookEvent(widget.book!.id));
                Navigator.pop(context);
              },
            ),
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, authState) {
          if (authState is AuthSuccess) {
            setState(() {
              if (widget.book != null) {
                _populateFields(widget.book!);
              }
            });
          }
        },
        child: BlocListener<BookBloc, BookState>(
          listener: (context, state) {
            if (state is BookAdded ||
                state is BookUpdated ||
                state is BookDeleted) {
              Navigator.pop(context);
            } else if (state is BookError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: ultrasoftText('错误: ${state.message}')),
              );
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '图书信息',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 24),
                    _buildGrid(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _saveDraft,
            backgroundColor: Colors.green,
            child: const Icon(Icons.drafts, size: 28), // Changed to draft icon
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: _saveOrUpdateBook,
            backgroundColor: const Color(0xFF3A4568),
            child: Icon(isUpdate ? Icons.update : Icons.save, size: 28),
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
              suffixIcon: Icon(Icons.qr_code),
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
            _textField(_operatorController, '操作人员', required: true),
          ],
        );
      },
    );
  }

  Widget ultrasoftText(String message) {
    return Text(
      message,
      style: const TextStyle(color: AppPallete.errorColor, fontSize: 16),
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
        labelStyle: TextStyle(color: Colors.grey[700]),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blueAccent, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[100],
        suffixIcon: suffixIcon,
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
      value: ctrl.text,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[700]),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blueAccent, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[100],
      ),
      items:
          opts.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: (v) => setState(() => ctrl.text = v!),
    );
  }
}
