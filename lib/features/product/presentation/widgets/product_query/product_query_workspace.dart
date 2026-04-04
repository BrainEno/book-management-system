import 'package:bookstore_management_system/features/product/data/mappers/product_entity_mapper.dart';
import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:bookstore_management_system/core/domain/entities/app_user.dart';
import 'package:bookstore_management_system/core/di/service_locator.dart';
import 'package:bookstore_management_system/core/presentation/widgets/admin_support.dart';
import 'package:bookstore_management_system/features/auth/data/datasources/local/auth_local_data_source.dart';
import 'package:bookstore_management_system/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookstore_management_system/features/product/presentation/blocs/product_bloc.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_info_editor/product_info_editor_form_state.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_detail_form_controller.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_detail_panel.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_export_service.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_header.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_spreadsheet_panel.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_table_source.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_utils.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_workspace_support.dart';
import 'package:bookstore_management_system/app/navigation/app_window_destination.dart';
import 'package:bookstore_management_system/core/common/logger/app_logger.dart';
import 'package:bookstore_management_system/core/window/window_pop_out_service.dart';
import 'package:bookstore_management_system/core/window/app_window_manager.dart';
import 'package:bookstore_management_system/core/window/sub_window_launch_data.dart';
import 'package:bookstore_management_system/core/window/window_info.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ProductQueryWorkspace extends StatefulWidget {
  const ProductQueryWorkspace({
    super.key,
    this.initialProducts,
    this.windowPopOutService = const DesktopWindowPopOutService(),
    this.adminModeVerifier = ProductQueryWorkspace._defaultAdminModeVerifier,
    this.adminModeTimeout = const Duration(minutes: 5),
  });

  final List<ProductModel>? initialProducts;
  final WindowPopOutService windowPopOutService;
  final AdminModeVerifier adminModeVerifier;
  final Duration adminModeTimeout;

  static Future<AppUser> _defaultAdminModeVerifier({
    required String username,
    required String password,
  }) {
    return sl<AuthLocalDataSource>().verifyAdminCredentials(
      username: username,
      password: password,
    );
  }

  @override
  State<ProductQueryWorkspace> createState() => _ProductQueryWorkspaceState();
}

class _ProductQueryWorkspaceState extends State<ProductQueryWorkspace> {
  final _logger = AppLogger.logger;
  final _detailFormKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();
  final _dataGridController = DataGridController();
  final _exportService = const ProductQueryExportService();
  final _detailFormController = ProductQueryDetailFormController();
  final _editorChannel = const WindowMethodChannel(
    'bookstore_product_editor',
    mode: ChannelMode.unidirectional,
  );

  List<ProductModel> _products = const [];
  ProductModel? _selectedProduct;
  ProductQueryMode _queryMode = ProductQueryMode.title;
  Set<int> _selectedProductIds = <int>{};

  bool _isFetching = false;
  bool _isSaving = false;
  bool _isExporting = false;
  bool _isAdminModeEnabled = false;
  int? _selectionAfterRefreshId;
  AppUser? _adminModeUser;
  Timer? _adminModeTimer;
  ScaffoldMessengerState? _scaffoldMessenger;
  String _operatorUsername = '当前操作员';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_handleQueryInputsChanged);
    _detailFormController.isbnController.addListener(
      _handleSensitiveFieldEdited,
    );
    _detailFormController.priceController.addListener(
      _handleSensitiveFieldEdited,
    );
    unawaited(_editorChannel.setMethodCallHandler(_handleWindowMessage));

    if (widget.initialProducts != null && widget.initialProducts!.isNotEmpty) {
      _applyProducts(widget.initialProducts!);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshProducts(
        preferredSelectionId: widget.initialProducts?.isNotEmpty == true
            ? widget.initialProducts!.first.id
            : null,
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scaffoldMessenger ??= ScaffoldMessenger.maybeOf(context);
    final authState = context.read<AuthBloc>().state;
    _operatorUsername = authState is AuthSuccess
        ? authState.user.username
        : '当前操作员';
  }

  @override
  void dispose() {
    _scaffoldMessenger?.removeCurrentSnackBar(
      reason: SnackBarClosedReason.remove,
    );
    _scaffoldMessenger?.clearSnackBars();
    _searchController.removeListener(_handleQueryInputsChanged);
    _detailFormController.isbnController.removeListener(
      _handleSensitiveFieldEdited,
    );
    _detailFormController.priceController.removeListener(
      _handleSensitiveFieldEdited,
    );
    _adminModeTimer?.cancel();
    if (_isAdminModeEnabled) {
      _logAdminAudit('admin-mode.ended', reason: 'workspace-disposed');
    }
    _searchController.dispose();
    _dataGridController.dispose();
    _detailFormController.dispose();
    unawaited(_editorChannel.setMethodCallHandler(null));
    super.dispose();
  }

  void _handleQueryInputsChanged() {
    _syncSelectionWithVisibleProducts();
  }

  void _handleSensitiveFieldEdited() {
    if (!_isAdminModeEnabled) {
      return;
    }
    _restartAdminModeTimer();
  }

  String _currentOperatorUsername() {
    return _operatorUsername;
  }

  String get _adminModeTimeoutLabel =>
      AdminSupport.formatTimeoutLabel(widget.adminModeTimeout);

  void _logAdminAudit(
    String event, {
    ProductModel? product,
    String? reason,
    Map<String, Object?> extras = const {},
  }) {
    final selected = product ?? _selectedProduct;
    final fields = <String, Object?>{
      'event': event,
      'operator': _currentOperatorUsername(),
      'admin': _adminModeUser?.username,
      'productId': selected?.id,
      'businessId': selected?.productId,
      if (reason != null) 'reason': reason,
      ...extras,
    };
    final serialized = fields.entries
        .map((entry) => '${entry.key}=${entry.value ?? '-'}')
        .join(', ');
    _logger.i('Product query admin audit: $serialized');
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
    _disableAdminMode(reason: 'timeout', showSnackBar: true);
  }

  Future<void> _requestAdminMode() async {
    if (_isAdminModeEnabled) {
      _restartAdminModeTimer();
      return;
    }

    _logAdminAudit(
      'admin-mode.requested',
      reason: 'sensitive-field-edit',
      extras: {'timeout': _adminModeTimeoutLabel},
    );

    final shouldContinue = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(Icons.admin_panel_settings_outlined),
        title: const Text('需要管理员权限'),
        content: Text(
          '编辑 ISBN 和售价需要管理员权限。\n\n当前操作员：${_currentOperatorUsername()}\n\n是否进入管理员模式？',
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
      _logAdminAudit('admin-mode.request-cancelled');
      return;
    }

    final verifiedUser = await showDialog<AppUser>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AdminCredentialsDialog(
        verifier: widget.adminModeVerifier,
        modeDescription:
            '请输入管理员级别账户的名称和密码。验证通过后，本次商品查询页会进入管理员模式，允许编辑 ISBN 和售价。',
        usernameFieldKey: const ValueKey('product-query-admin-username'),
        passwordFieldKey: const ValueKey('product-query-admin-password'),
        auditLogPrefix: 'Product query admin audit',
      ),
    );

    if (!mounted || verifiedUser == null) {
      _logAdminAudit('admin-mode.verification-cancelled');
      return;
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

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('管理员模式已开启：${verifiedUser.username}')),
    );
  }

  void _disableAdminMode({String reason = 'manual', bool showSnackBar = true}) {
    if (!_isAdminModeEnabled) {
      return;
    }

    _adminModeTimer?.cancel();
    _logAdminAudit('admin-mode.ended', reason: reason);
    setState(() {
      _isAdminModeEnabled = false;
      _adminModeUser = null;
    });

    if (!showSnackBar || !mounted) {
      return;
    }

    final message = switch (reason) {
      'timeout' => '管理员模式已因长时间未操作自动退出',
      _ => '已退出管理员模式',
    };
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _handleQueryModeChanged(ProductQueryMode? mode) {
    if (mode == null || mode == _queryMode) {
      return;
    }

    setState(() {
      _queryMode = mode;
    });
    _syncSelectionWithVisibleProducts();
  }

  List<ProductModel> _visibleProductsFor(List<ProductModel> products) {
    return filterAndSortProducts(
      products,
      mode: _queryMode,
      query: _searchController.text,
    );
  }

  void _syncSelectionWithVisibleProducts() {
    final visibleProducts = _visibleProductsFor(_products);
    final visibleIds = visibleProducts.map((product) => product.id).toSet();
    final nextSelectedIds = _selectedProductIds.intersection(visibleIds);

    ProductModel? nextSelection = _selectedProduct;
    // Don't auto-select the first visible product. If current selection
    // is missing or not visible, clear selection (keep user-driven state null).
    if (nextSelection == null || !visibleIds.contains(nextSelection.id)) {
      nextSelection = null;
    }

    setState(() {
      _selectedProductIds = nextSelectedIds;
      _selectedProduct = nextSelection;
    });
    _detailFormController.populate(nextSelection);
  }

  void _refreshProducts({int? preferredSelectionId}) {
    _selectionAfterRefreshId = preferredSelectionId ?? _selectedProduct?.id;
    setState(() {
      _isFetching = true;
    });
    context.read<ProductBloc>().add(GetAllBooksEvent());
  }

  void _applyProducts(List<ProductModel> products) {
    final visibleProducts = _visibleProductsFor(products);
    final visibleIds = visibleProducts.map((product) => product.id).toSet();
    final selectionId = _selectionAfterRefreshId ?? _selectedProduct?.id;

    ProductModel? nextSelection;
    if (selectionId != null) {
      nextSelection = _findById(visibleProducts, selectionId);
    }
    // Do not default to the first item when no selectionId is provided.
    // Leave nextSelection null so the table has no active selection by default.

    setState(() {
      _products = List<ProductModel>.from(products);
      _selectedProduct = nextSelection;
      _selectedProductIds = _selectedProductIds.intersection(visibleIds);
      _isFetching = false;
      _isSaving = false;
      _selectionAfterRefreshId = nextSelection?.id;
    });

    _detailFormController.populate(nextSelection);
  }

  ProductModel? _findById(List<ProductModel> products, int id) {
    for (final product in products) {
      if (product.id == id) {
        return product;
      }
    }
    return null;
  }

  Future<void> _openFullEditor({ProductModel? product}) async {
    final authState = context.read<AuthBloc>().state;
    final currentOperatorUsername = authState is AuthSuccess
        ? authState.user.username
        : null;
    final manager = context.read<AppWindowManager>();
    final managedWindow = manager.openWindow(
      title: product == null ? '新建商品资料' : '编辑商品资料',
      popOutPageKey: 'product-editor',
      payload: AppWindowPayload(
        initialProduct: product,
        currentOperatorUsername: currentOperatorUsername,
      ),
      displayMode: AppWindowDisplayMode.floating,
    );

    final renderBox = context.findRenderObject() as RenderBox?;
    final workspaceSize = renderBox?.size ?? MediaQuery.sizeOf(context);
    final localFloatingBounds = resolveProductEditorFloatingBounds(
      workspaceSize,
    );
    final origin = renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;
    final globalBounds = Rect.fromLTWH(
      origin.dx + localFloatingBounds.left,
      origin.dy + localFloatingBounds.top,
      localFloatingBounds.width,
      localFloatingBounds.height,
    );

    final launchData = SubWindowLaunchData(
      page: 'product-editor',
      title: managedWindow.title,
      hostWindowId: managedWindow.id,
      state: managedWindow.payload.toJson(),
      bounds: SubWindowBounds.fromRect(globalBounds),
    );

    try {
      _logger.i(
        'Opening product editor from query workspace: product=${product?.id}, managedHost=${managedWindow.id}, trackedWindowsBefore=${manager.windows.length}',
      );
      final floatingWindowId = await widget.windowPopOutService.openSubWindow(
        launchData,
      );
      if (!mounted) {
        return;
      }
      manager.markWindowFloating(
        managedWindow.id,
        floatingWindowId: floatingWindowId,
      );
      _logger.i(
        'Product editor opened from query workspace: managedHost=${managedWindow.id}, child=$floatingWindowId',
      );
    } catch (error) {
      manager.closeWindow(managedWindow.id);
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('打开子窗口失败：$error')));
    }
  }

  void _selectProduct(ProductModel product) {
    if (_selectedProduct?.id == product.id) {
      return;
    }

    setState(() {
      _selectedProduct = product;
      _selectionAfterRefreshId = product.id;
    });
    _detailFormController.populate(product);
  }

  void _handleTableSelectionChanged(
    List<DataGridRow> addedRows,
    List<DataGridRow> removedRows,
    ProductQueryTableSource source,
  ) {
    final nextIds = Set<int>.from(_selectedProductIds);

    for (final row in addedRows) {
      final product = source.productForRow(row);
      if (product != null) {
        nextIds.add(product.id);
      }
    }

    for (final row in removedRows) {
      final product = source.productForRow(row);
      if (product != null) {
        nextIds.remove(product.id);
      }
    }

    setState(() {
      _selectedProductIds = nextIds;
    });
  }

  void _handleTableTap(
    DataGridCellTapDetails details,
    ProductQueryTableSource source,
  ) {
    final product = source.productForRowIndex(details.rowColumnIndex.rowIndex);
    if (product != null) {
      _selectProduct(product);
    }
  }

  Future<void> _exportProducts(List<ProductModel> visibleProducts) async {
    final exportProducts = resolveProductsForExport(
      visibleProducts: visibleProducts,
      selectedProductIds: _selectedProductIds,
    );

    if (exportProducts.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('当前没有可导出的商品资料')));
      return;
    }

    setState(() {
      _isExporting = true;
    });

    try {
      final path = await _exportService.exportProducts(
        exportProducts,
        queryMode: _queryMode,
        query: _searchController.text,
      );
      if (!mounted) {
        return;
      }

      if (path == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('已取消导出')));
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('已导出 ${exportProducts.length} 条商品资料到 $path')),
      );
    } catch (error) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('导出失败：$error')));
    } finally {
      if (mounted) {
        setState(() {
          _isExporting = false;
        });
      }
    }
  }

  void _saveSelectedProduct() {
    final selectedProduct = _selectedProduct;
    if (selectedProduct == null) {
      return;
    }

    if (!_detailFormKey.currentState!.validate()) {
      return;
    }

    if (_isAdminModeEnabled && _detailFormController.parsePrice() == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('售价格式不正确')));
      return;
    }

    final updatedProduct = _detailFormController.buildUpdatedProduct(
      selectedProduct,
      allowSensitiveFieldUpdates: _isAdminModeEnabled,
    );

    if (_isAdminModeEnabled) {
      final isbnChanged = updatedProduct.isbn != selectedProduct.isbn;
      final priceChanged = updatedProduct.price != selectedProduct.price;
      if (isbnChanged || priceChanged) {
        _logAdminAudit(
          'sensitive-fields.updated',
          product: updatedProduct,
          extras: {
            'isbnBefore': selectedProduct.isbn,
            'isbnAfter': updatedProduct.isbn,
            'priceBefore': selectedProduct.price,
            'priceAfter': updatedProduct.price,
          },
        );
      }
      _restartAdminModeTimer();
    }

    setState(() {
      _isSaving = true;
      _selectionAfterRefreshId = updatedProduct.id;
      _selectedProduct = updatedProduct;
    });
    context.read<ProductBloc>().add(UpdateBookEvent(updatedProduct));
  }

  String _exportButtonLabel(List<ProductModel> visibleProducts) {
    if (_selectedProductIds.isNotEmpty) {
      return '导出选中（${_selectedProductIds.length}）';
    }

    if (_searchController.text.trim().isNotEmpty) {
      return '导出查询结果（${visibleProducts.length}）';
    }

    return '导出全部（${visibleProducts.length}）';
  }

  void _handleProductState(ProductState state) {
    if (state is ProductsLoaded) {
      _applyProducts(state.products.map(ensureProductModel).toList());
      return;
    }

    if (state is ProductUpdated) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('商品信息已更新')));
      _refreshProducts();
      return;
    }

    if (state is ProductAdded) {
      _refreshProducts(preferredSelectionId: state.product.id);
      return;
    }

    if (state is ProductDeleted) {
      _refreshProducts();
      return;
    }

    if (state is ProductError) {
      setState(() {
        _isFetching = false;
        _isSaving = false;
        _isExporting = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(state.message)));
    }
  }

  Future<dynamic> _handleWindowMessage(MethodCall call) async {
    if (call.method != 'product-editor-saved') {
      return null;
    }

    int? preferredSelectionId;
    final arguments = call.arguments;
    if (arguments is Map) {
      final rawId = arguments['productId'];
      if (rawId is int) {
        preferredSelectionId = rawId;
      } else if (rawId is num) {
        preferredSelectionId = rawId.toInt();
      }
    }

    if (mounted) {
      _refreshProducts(preferredSelectionId: preferredSelectionId);
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final visibleProducts = _visibleProductsFor(_products);
    final selectedProduct = _selectedProduct;
    final theme = Theme.of(context);
    final publisherOptions = mergeProductQueryOptions(
      productPublisherOptions,
      _products.map((product) => product.publisher ?? '不区分'),
    );
    final categoryOptions = mergeProductQueryOptions(
      productCategoryOptions,
      _products.map((product) => product.category ?? '不区分'),
    );
    final isCompactLayout = MediaQuery.sizeOf(context).width < 1440;
    final tableSource = ProductQueryTableSource(
      products: visibleProducts,
      activeProductId: selectedProduct?.id,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      _dataGridController.selectedRows = tableSource.rowsForProductIds(
        _selectedProductIds,
      );
    });

    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) => _handleProductState(state),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [theme.colorScheme.surface, const Color(0xFFF4EFE6)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductQueryHeader(
                searchController: _searchController,
                queryMode: _queryMode,
                totalCount: _products.length,
                visibleCount: visibleProducts.length,
                selectedCount: _selectedProductIds.length,
                isBusy: _isFetching || _isSaving || _isExporting,
                exportButtonLabel: _exportButtonLabel(visibleProducts),
                onQueryModeChanged: _handleQueryModeChanged,
                onCreatePressed: () => _openFullEditor(),
                onRefreshPressed: () => _refreshProducts(),
                onExportPressed: visibleProducts.isEmpty || _isExporting
                    ? null
                    : () => _exportProducts(visibleProducts),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: isCompactLayout
                    ? Column(
                        children: [
                          Expanded(
                            flex: 8,
                            child: ProductQuerySpreadsheetPanel(
                              source: tableSource,
                              controller: _dataGridController,
                              isFetching: _isFetching,
                              hasResults: visibleProducts.isNotEmpty,
                              onCellTap: (details) =>
                                  _handleTableTap(details, tableSource),
                              onSelectionChanged: (addedRows, removedRows) {
                                _handleTableSelectionChanged(
                                  addedRows,
                                  removedRows,
                                  tableSource,
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 18),
                          Expanded(
                            flex: 6,
                            child: ProductQueryDetailPanel(
                              formKey: _detailFormKey,
                              product: selectedProduct,
                              titleController:
                                  _detailFormController.titleController,
                              productIdController:
                                  _detailFormController.productIdController,
                              isbnController:
                                  _detailFormController.isbnController,
                              authorController:
                                  _detailFormController.authorController,
                              priceController:
                                  _detailFormController.priceController,
                              publicationYearController: _detailFormController
                                  .publicationYearController,
                              purchaseSaleModeController: _detailFormController
                                  .purchaseSaleModeController,
                              packagingController:
                                  _detailFormController.packagingController,
                              statisticalClassController: _detailFormController
                                  .statisticalClassController,
                              publisherController:
                                  _detailFormController.publisherController,
                              categoryController:
                                  _detailFormController.categoryController,
                              selfEncodingController:
                                  _detailFormController.selfEncodingController,
                              categoryOptions: categoryOptions,
                              publisherOptions: publisherOptions,
                              isAdminModeEnabled: _isAdminModeEnabled,
                              adminModeTimeoutLabel: _adminModeTimeoutLabel,
                              isSaving: _isSaving,
                              onSave: _saveSelectedProduct,
                              onRequestAdminMode: _requestAdminMode,
                              onDisableAdminMode: _disableAdminMode,
                              adminModeUserLabel: _adminModeUser?.username,
                              onOpenFullEditor: selectedProduct == null
                                  ? null
                                  : () => _openFullEditor(
                                      product: selectedProduct,
                                    ),
                              formatDate: formatProductQueryDateTime,
                            ),
                          ),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 12,
                            child: ProductQuerySpreadsheetPanel(
                              source: tableSource,
                              controller: _dataGridController,
                              isFetching: _isFetching,
                              hasResults: visibleProducts.isNotEmpty,
                              onCellTap: (details) =>
                                  _handleTableTap(details, tableSource),
                              onSelectionChanged: (addedRows, removedRows) {
                                _handleTableSelectionChanged(
                                  addedRows,
                                  removedRows,
                                  tableSource,
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 18),
                          Expanded(
                            flex: 5,
                            child: ProductQueryDetailPanel(
                              formKey: _detailFormKey,
                              product: selectedProduct,
                              titleController:
                                  _detailFormController.titleController,
                              productIdController:
                                  _detailFormController.productIdController,
                              isbnController:
                                  _detailFormController.isbnController,
                              authorController:
                                  _detailFormController.authorController,
                              priceController:
                                  _detailFormController.priceController,
                              publicationYearController: _detailFormController
                                  .publicationYearController,
                              purchaseSaleModeController: _detailFormController
                                  .purchaseSaleModeController,
                              packagingController:
                                  _detailFormController.packagingController,
                              statisticalClassController: _detailFormController
                                  .statisticalClassController,
                              publisherController:
                                  _detailFormController.publisherController,
                              categoryController:
                                  _detailFormController.categoryController,
                              selfEncodingController:
                                  _detailFormController.selfEncodingController,
                              categoryOptions: categoryOptions,
                              publisherOptions: publisherOptions,
                              isAdminModeEnabled: _isAdminModeEnabled,
                              adminModeTimeoutLabel: _adminModeTimeoutLabel,
                              isSaving: _isSaving,
                              onSave: _saveSelectedProduct,
                              onRequestAdminMode: _requestAdminMode,
                              onDisableAdminMode: _disableAdminMode,
                              adminModeUserLabel: _adminModeUser?.username,
                              onOpenFullEditor: selectedProduct == null
                                  ? null
                                  : () => _openFullEditor(
                                      product: selectedProduct,
                                    ),
                              formatDate: formatProductQueryDateTime,
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
