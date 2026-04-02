import 'package:bookstore_management_system/core/theme/app_pallete.dart';
import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:bookstore_management_system/features/product/domain/entities/product.dart';
import 'package:bookstore_management_system/features/product/presentation/blocs/product_bloc.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_info_editor/product_info_editor_form_state.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_info_editor_view.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_export_service.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_table_source.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ProductQueryWorkspace extends StatefulWidget {
  const ProductQueryWorkspace({super.key, this.initialProducts});

  final List<ProductModel>? initialProducts;

  @override
  State<ProductQueryWorkspace> createState() => _ProductQueryWorkspaceState();
}

class _ProductQueryWorkspaceState extends State<ProductQueryWorkspace> {
  final _detailFormKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();
  final _dataGridController = DataGridController();
  final _exportService = const ProductQueryExportService();

  final _titleController = TextEditingController();
  final _productIdController = TextEditingController();
  final _isbnController = TextEditingController();
  final _authorController = TextEditingController();
  final _priceController = TextEditingController();
  final _publisherController = TextEditingController();
  final _categoryController = TextEditingController();
  final _selfEncodingController = TextEditingController();

  List<ProductModel> _products = const [];
  ProductModel? _selectedProduct;
  ProductQueryMode _queryMode = ProductQueryMode.title;
  Set<int> _selectedProductIds = <int>{};

  bool _isFetching = false;
  bool _isSaving = false;
  bool _isExporting = false;
  int? _selectionAfterRefreshId;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_handleQueryInputsChanged);

    if (widget.initialProducts != null && widget.initialProducts!.isNotEmpty) {
      _applyProducts(widget.initialProducts!);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshProducts(
        preferredSelectionId:
            widget.initialProducts?.isNotEmpty == true
                ? widget.initialProducts!.first.id
                : null,
      );
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_handleQueryInputsChanged);
    _searchController.dispose();
    _dataGridController.dispose();
    _titleController.dispose();
    _productIdController.dispose();
    _isbnController.dispose();
    _authorController.dispose();
    _priceController.dispose();
    _publisherController.dispose();
    _categoryController.dispose();
    _selfEncodingController.dispose();
    super.dispose();
  }

  void _handleQueryInputsChanged() {
    _syncSelectionWithVisibleProducts();
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
    if (nextSelection == null || !visibleIds.contains(nextSelection.id)) {
      nextSelection = visibleProducts.isNotEmpty ? visibleProducts.first : null;
    }

    setState(() {
      _selectedProductIds = nextSelectedIds;
      _selectedProduct = nextSelection;
    });
    _populateDetailEditors(nextSelection);
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
    nextSelection ??= visibleProducts.isNotEmpty ? visibleProducts.first : null;

    setState(() {
      _products = List<ProductModel>.from(products);
      _selectedProduct = nextSelection;
      _selectedProductIds = _selectedProductIds.intersection(visibleIds);
      _isFetching = false;
      _isSaving = false;
      _selectionAfterRefreshId = nextSelection?.id;
    });

    _populateDetailEditors(nextSelection);
  }

  ProductModel? _findById(List<ProductModel> products, int id) {
    for (final product in products) {
      if (product.id == id) {
        return product;
      }
    }
    return null;
  }

  void _populateDetailEditors(ProductModel? product) {
    if (product == null) {
      _titleController.clear();
      _productIdController.clear();
      _isbnController.clear();
      _authorController.clear();
      _priceController.clear();
      _publisherController.clear();
      _categoryController.clear();
      _selfEncodingController.clear();
      return;
    }

    _titleController.text = product.title;
    _productIdController.text = product.productId;
    _isbnController.text = product.isbn;
    _authorController.text = product.author;
    _priceController.text = _formatPrice(product.price);
    _publisherController.text = product.publisher;
    _categoryController.text = product.category;
    _selfEncodingController.text = product.selfEncoding;
  }

  Future<void> _openFullEditor({ProductModel? product}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ProductInfoEditorView(product: product),
      ),
    );

    if (!mounted) {
      return;
    }

    _refreshProducts(preferredSelectionId: product?.id);
  }

  void _selectProduct(ProductModel product) {
    if (_selectedProduct?.id == product.id) {
      return;
    }

    setState(() {
      _selectedProduct = product;
      _selectionAfterRefreshId = product.id;
    });
    _populateDetailEditors(product);
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

    final price = double.tryParse(_priceController.text.trim());
    if (price == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('售价格式不正确')));
      return;
    }

    final updatedProduct = selectedProduct.copyWith(
      title: _titleController.text.trim(),
      productId: _productIdController.text.trim(),
      isbn: _isbnController.text.trim(),
      author: _authorController.text.trim(),
      price: price,
      publisher: _publisherController.text.trim(),
      category: _categoryController.text.trim(),
      selfEncoding: _selfEncodingController.text.trim(),
      updatedAt: DateTime.now(),
    );

    setState(() {
      _isSaving = true;
      _selectionAfterRefreshId = updatedProduct.id;
      _selectedProduct = updatedProduct;
    });
    context.read<ProductBloc>().add(UpdateBookEvent(updatedProduct));
  }

  String _formatPrice(double value) {
    return formatProductPrice(value);
  }

  String _formatDate(DateTime? value) {
    if (value == null) {
      return '--';
    }

    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '${value.year}-$month-$day $hour:$minute';
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

  List<String> _mergeOptions(List<String> defaults, Iterable<String> extras) {
    final merged = <String>[...defaults];
    final seen = <String>{...defaults};
    final extraValues = <String>[];
    for (final extra in extras) {
      final normalized = extra.trim();
      if (normalized.isNotEmpty && !seen.contains(normalized)) {
        extraValues.add(normalized);
        seen.add(normalized);
      }
    }
    extraValues.sort((a, b) => a.compareTo(b));
    merged.addAll(extraValues);
    return merged;
  }

  ProductModel _toProductModel(Product product) {
    if (product is ProductModel) {
      return product;
    }

    return ProductModel(
      productId: product.productId,
      id: product.id,
      title: product.title,
      author: product.author,
      isbn: product.isbn,
      price: product.price,
      category: product.category,
      publisher: product.publisher,
      selfEncoding: product.selfEncoding,
      internalPricing: product.internalPricing ?? 0,
      purchasePrice: product.purchasePrice ?? 0,
      publicationYear: product.publicationYear ?? 2025,
      retailDiscount: product.retailDiscount ?? 100,
      wholesaleDiscount: product.wholesaleDiscount ?? 100,
      wholesalePrice: product.wholesalePrice ?? 0,
      memberDiscount: product.memberDiscount ?? 100,
      purchaseSaleMode: product.purchaseSaleMode ?? '不区分',
      bookmark: product.bookmark ?? '不区分',
      packaging: product.packaging ?? '不区分',
      properity: product.properity ?? '不区分',
      statisticalClass: product.statisticalClass ?? '不区分',
      operator: product.operator,
      createdAt: product.createdAt,
      updatedAt: product.updatedAt,
    );
  }

  @override
  Widget build(BuildContext context) {
    final visibleProducts = _visibleProductsFor(_products);
    final selectedProduct = _selectedProduct;
    final theme = Theme.of(context);
    final publisherOptions = _mergeOptions(
      productPublisherOptions,
      _products.map((product) => product.publisher),
    );
    final categoryOptions = _mergeOptions(
      productCategoryOptions,
      _products.map((product) => product.category),
    );
    final isCompactLayout = MediaQuery.sizeOf(context).width < 1280;
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
      listener: (context, state) {
        if (state is ProductsLoaded) {
          _applyProducts(state.products.map(_toProductModel).toList());
        } else if (state is ProductUpdated) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('商品信息已更新')));
          _refreshProducts();
        } else if (state is ProductAdded) {
          _refreshProducts(preferredSelectionId: state.product.id);
        } else if (state is ProductDeleted) {
          _refreshProducts();
        } else if (state is ProductError) {
          setState(() {
            _isFetching = false;
            _isSaving = false;
            _isExporting = false;
          });
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
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
              _QueryHeader(
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
                onExportPressed:
                    visibleProducts.isEmpty || _isExporting
                        ? null
                        : () => _exportProducts(visibleProducts),
              ),
              const SizedBox(height: 20),
              Expanded(
                child:
                    isCompactLayout
                        ? Column(
                          children: [
                            Expanded(
                              flex: 8,
                              child: _SpreadsheetPanel(
                                source: tableSource,
                                controller: _dataGridController,
                                isFetching: _isFetching,
                                hasResults: visibleProducts.isNotEmpty,
                                onCellTap:
                                    (details) =>
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
                              child: _DetailPanel(
                                formKey: _detailFormKey,
                                product: selectedProduct,
                                titleController: _titleController,
                                productIdController: _productIdController,
                                isbnController: _isbnController,
                                authorController: _authorController,
                                priceController: _priceController,
                                publisherController: _publisherController,
                                categoryController: _categoryController,
                                selfEncodingController: _selfEncodingController,
                                categoryOptions: categoryOptions,
                                publisherOptions: publisherOptions,
                                isSaving: _isSaving,
                                onSave: _saveSelectedProduct,
                                onOpenFullEditor:
                                    selectedProduct == null
                                        ? null
                                        : () => _openFullEditor(
                                          product: selectedProduct,
                                        ),
                                formatDate: _formatDate,
                              ),
                            ),
                          ],
                        )
                        : Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              flex: 10,
                              child: _SpreadsheetPanel(
                                source: tableSource,
                                controller: _dataGridController,
                                isFetching: _isFetching,
                                hasResults: visibleProducts.isNotEmpty,
                                onCellTap:
                                    (details) =>
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
                              flex: 6,
                              child: _DetailPanel(
                                formKey: _detailFormKey,
                                product: selectedProduct,
                                titleController: _titleController,
                                productIdController: _productIdController,
                                isbnController: _isbnController,
                                authorController: _authorController,
                                priceController: _priceController,
                                publisherController: _publisherController,
                                categoryController: _categoryController,
                                selfEncodingController: _selfEncodingController,
                                categoryOptions: categoryOptions,
                                publisherOptions: publisherOptions,
                                isSaving: _isSaving,
                                onSave: _saveSelectedProduct,
                                onOpenFullEditor:
                                    selectedProduct == null
                                        ? null
                                        : () => _openFullEditor(
                                          product: selectedProduct,
                                        ),
                                formatDate: _formatDate,
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

class _QueryHeader extends StatelessWidget {
  const _QueryHeader({
    required this.searchController,
    required this.queryMode,
    required this.totalCount,
    required this.visibleCount,
    required this.selectedCount,
    required this.isBusy,
    required this.exportButtonLabel,
    required this.onQueryModeChanged,
    required this.onCreatePressed,
    required this.onRefreshPressed,
    required this.onExportPressed,
  });

  final TextEditingController searchController;
  final ProductQueryMode queryMode;
  final int totalCount;
  final int visibleCount;
  final int selectedCount;
  final bool isBusy;
  final String exportButtonLabel;
  final ValueChanged<ProductQueryMode?> onQueryModeChanged;
  final VoidCallback onCreatePressed;
  final VoidCallback onRefreshPressed;
  final VoidCallback? onExportPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE2D7C8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '商品查询',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '上方切换查询方式，下方使用表格浏览、勾选并导出商品资料。',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppPallete.lightGreyText,
                    ),
                  ),
                ],
              ),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  FilledButton.icon(
                    onPressed: onCreatePressed,
                    icon: const Icon(Icons.add),
                    label: const Text('新增商品'),
                  ),
                  OutlinedButton.icon(
                    onPressed: onRefreshPressed,
                    icon: const Icon(Icons.refresh),
                    label: const Text('刷新'),
                  ),
                  FilledButton.tonalIcon(
                    onPressed: onExportPressed,
                    icon:
                        isBusy && onExportPressed != null
                            ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                            : const Icon(Icons.download_rounded),
                    label: Text(exportButtonLabel),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              SizedBox(
                width: 220,
                child: DropdownButtonFormField<ProductQueryMode>(
                  initialValue: queryMode,
                  decoration: InputDecoration(
                    labelText: '查询方式',
                    filled: true,
                    fillColor: const Color(0xFFF8F3EA),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: [
                    for (final mode in ProductQueryMode.values)
                      DropdownMenuItem<ProductQueryMode>(
                        value: mode,
                        child: Text(mode.label),
                      ),
                  ],
                  onChanged: onQueryModeChanged,
                ),
              ),
              SizedBox(
                width: 420,
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: queryMode.hintText,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon:
                        searchController.text.isEmpty
                            ? null
                            : IconButton(
                              tooltip: '清空搜索',
                              onPressed: searchController.clear,
                              icon: const Icon(Icons.close),
                            ),
                    filled: true,
                    fillColor: const Color(0xFFF8F3EA),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _CountBadge(
                label: '已录入商品',
                value: totalCount.toString(),
                color: const Color(0xFF2E5B4E),
              ),
              _CountBadge(
                label: '当前结果',
                value: visibleCount.toString(),
                color: const Color(0xFF9B6A34),
              ),
              _CountBadge(
                label: '已勾选',
                value: selectedCount.toString(),
                color: const Color(0xFF5C6270),
              ),
              _CountBadge(
                label: '默认导出',
                value:
                    selectedCount > 0
                        ? '选中结果'
                        : searchController.text.trim().isEmpty
                        ? '全部商品'
                        : '查询结果',
                color: const Color(0xFF7B5E83),
              ),
            ],
          ),
          if (isBusy) ...[
            const SizedBox(height: 14),
            const LinearProgressIndicator(minHeight: 4),
          ],
        ],
      ),
    );
  }
}

class _CountBadge extends StatelessWidget {
  const _CountBadge({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(
              text: '$label  ',
              style: TextStyle(color: color.withValues(alpha: 0.9)),
            ),
            TextSpan(
              text: value,
              style: TextStyle(fontWeight: FontWeight.w700, color: color),
            ),
          ],
        ),
      ),
    );
  }
}

class _SpreadsheetPanel extends StatelessWidget {
  const _SpreadsheetPanel({
    required this.source,
    required this.controller,
    required this.isFetching,
    required this.hasResults,
    required this.onCellTap,
    required this.onSelectionChanged,
  });

  final ProductQueryTableSource source;
  final DataGridController controller;
  final bool isFetching;
  final bool hasResults;
  final void Function(DataGridCellTapDetails details) onCellTap;
  final void Function(List<DataGridRow>, List<DataGridRow>) onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE5DED1)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
            child: Row(
              children: [
                Text(
                  '商品表格',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Text(
                  '点击行可编辑，勾选后可一键导出',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppPallete.lightGreyText,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child:
                isFetching && !hasResults
                    ? const Center(child: CircularProgressIndicator())
                    : !hasResults
                    ? const _EmptyTableState()
                    : ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(24),
                      ),
                      child: SfDataGrid(
                        source: source,
                        controller: controller,
                        selectionMode: SelectionMode.multiple,
                        navigationMode: GridNavigationMode.row,
                        showCheckboxColumn: true,
                        headerGridLinesVisibility: GridLinesVisibility.both,
                        gridLinesVisibility: GridLinesVisibility.both,
                        columnWidthMode: ColumnWidthMode.none,
                        rowHeight: 54,
                        headerRowHeight: 52,
                        onCellTap: onCellTap,
                        onSelectionChanged: onSelectionChanged,
                        columns: [
                          GridColumn(
                            columnName: 'title',
                            width: 240,
                            label: _GridHeaderLabel(label: '商品名'),
                          ),
                          GridColumn(
                            columnName: 'productId',
                            width: 150,
                            label: _GridHeaderLabel(label: '商品编码'),
                          ),
                          GridColumn(
                            columnName: 'isbn',
                            width: 180,
                            label: _GridHeaderLabel(label: 'ISBN码'),
                          ),
                          GridColumn(
                            columnName: 'author',
                            width: 140,
                            label: _GridHeaderLabel(label: '作者'),
                          ),
                          GridColumn(
                            columnName: 'price',
                            width: 110,
                            label: _GridHeaderLabel(label: '售价'),
                          ),
                          GridColumn(
                            columnName: 'category',
                            width: 130,
                            label: _GridHeaderLabel(label: '种类'),
                          ),
                          GridColumn(
                            columnName: 'inventory',
                            width: 96,
                            label: _GridHeaderLabel(label: '库存'),
                          ),
                        ],
                      ),
                    ),
          ),
        ],
      ),
    );
  }
}

class _GridHeaderLabel extends StatelessWidget {
  const _GridHeaderLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      color: const Color(0xFFF5EEE2),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _DetailPanel extends StatelessWidget {
  const _DetailPanel({
    required this.formKey,
    required this.product,
    required this.titleController,
    required this.productIdController,
    required this.isbnController,
    required this.authorController,
    required this.priceController,
    required this.publisherController,
    required this.categoryController,
    required this.selfEncodingController,
    required this.categoryOptions,
    required this.publisherOptions,
    required this.isSaving,
    required this.onSave,
    required this.onOpenFullEditor,
    required this.formatDate,
  });

  final GlobalKey<FormState> formKey;
  final ProductModel? product;
  final TextEditingController titleController;
  final TextEditingController productIdController;
  final TextEditingController isbnController;
  final TextEditingController authorController;
  final TextEditingController priceController;
  final TextEditingController publisherController;
  final TextEditingController categoryController;
  final TextEditingController selfEncodingController;
  final List<String> categoryOptions;
  final List<String> publisherOptions;
  final bool isSaving;
  final VoidCallback onSave;
  final VoidCallback? onOpenFullEditor;
  final String Function(DateTime?) formatDate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedProduct = product;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.96),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE5DED1)),
      ),
      child:
          selectedProduct == null
              ? const _EmptyDetailState()
              : SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  selectedProduct.title,
                                  style: theme.textTheme.headlineSmall
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: 8),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    _BadgeLabel(
                                      label:
                                          '商品编码 ${selectedProduct.productId}',
                                    ),
                                    _BadgeLabel(
                                      label: '类别 ${selectedProduct.category}',
                                    ),
                                    _BadgeLabel(
                                      label:
                                          '库存 ${formatInventory(selectedProduct)}',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          FilledButton.icon(
                            onPressed: onOpenFullEditor,
                            icon: const Icon(Icons.open_in_new),
                            label: const Text('完整编辑'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          _MetricCard(
                            label: '售价',
                            value:
                                '¥${formatProductPrice(selectedProduct.price)}',
                            color: const Color(0xFF2E5B4E),
                          ),
                          _MetricCard(
                            label: '自编码',
                            value:
                                selectedProduct.selfEncoding.isEmpty
                                    ? '--'
                                    : selectedProduct.selfEncoding,
                            color: const Color(0xFF8A5A2B),
                          ),
                          _MetricCard(
                            label: '更新时间',
                            value: formatDate(selectedProduct.updatedAt),
                            color: const Color(0xFF5C6270),
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),
                      Text(
                        '关键资料编辑',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '表格里看到的是基础字段，右侧可以快速修改常用资料；导出时会带上完整商品信息。',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppPallete.lightGreyText,
                        ),
                      ),
                      const SizedBox(height: 18),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final wide = constraints.maxWidth >= 560;
                          final fieldWidth =
                              wide
                                  ? (constraints.maxWidth - 12) / 2
                                  : constraints.maxWidth;

                          return Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              SizedBox(
                                width: fieldWidth,
                                child: _QuickEditTextField(
                                  controller: titleController,
                                  label: '书名',
                                  validator: _requiredValidator('书名'),
                                ),
                              ),
                              SizedBox(
                                width: fieldWidth,
                                child: _QuickEditTextField(
                                  controller: authorController,
                                  label: '作者',
                                  validator: _requiredValidator('作者'),
                                ),
                              ),
                              SizedBox(
                                width: fieldWidth,
                                child: _QuickEditTextField(
                                  controller: productIdController,
                                  label: '商品编码',
                                  validator: _requiredValidator('商品编码'),
                                ),
                              ),
                              SizedBox(
                                width: fieldWidth,
                                child: _QuickEditTextField(
                                  controller: isbnController,
                                  label: 'ISBN',
                                  validator: _requiredValidator('ISBN'),
                                ),
                              ),
                              SizedBox(
                                width: fieldWidth,
                                child: _QuickEditDropdownField(
                                  controller: publisherController,
                                  label: '出版社',
                                  options: publisherOptions,
                                ),
                              ),
                              SizedBox(
                                width: fieldWidth,
                                child: _QuickEditDropdownField(
                                  controller: categoryController,
                                  label: '商品类别',
                                  options: categoryOptions,
                                ),
                              ),
                              SizedBox(
                                width: fieldWidth,
                                child: _QuickEditTextField(
                                  controller: selfEncodingController,
                                  label: '自编码',
                                ),
                              ),
                              SizedBox(
                                width: fieldWidth,
                                child: _QuickEditTextField(
                                  controller: priceController,
                                  label: '售价',
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                        decimal: true,
                                      ),
                                  validator: _requiredValidator('售价'),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7F2EA),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Wrap(
                          spacing: 18,
                          runSpacing: 14,
                          children: [
                            _MetaText(
                              label: '内部 ID',
                              value: '${selectedProduct.id}',
                            ),
                            _MetaText(
                              label: '出版年',
                              value: '${selectedProduct.publicationYear}',
                            ),
                            _MetaText(
                              label: '购销方式',
                              value: selectedProduct.purchaseSaleMode,
                            ),
                            _MetaText(
                              label: '包装',
                              value: selectedProduct.packaging,
                            ),
                            _MetaText(
                              label: '统计分类',
                              value: selectedProduct.statisticalClass,
                            ),
                            _MetaText(
                              label: '创建时间',
                              value: formatDate(selectedProduct.createdAt),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton.icon(
                              onPressed: isSaving ? null : onSave,
                              icon:
                                  isSaving
                                      ? const SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                      : const Icon(Icons.save_outlined),
                              label: Text(isSaving ? '保存中...' : '保存关键修改'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
    );
  }

  String? Function(String?) _requiredValidator(String label) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return '$label不能为空';
      }
      return null;
    };
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 120),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _BadgeLabel extends StatelessWidget {
  const _BadgeLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF3ECE0),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _QuickEditTextField extends StatelessWidget {
  const _QuickEditTextField({
    required this.controller,
    required this.label,
    this.keyboardType,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFFF8F3EA),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _QuickEditDropdownField extends StatelessWidget {
  const _QuickEditDropdownField({
    required this.controller,
    required this.label,
    required this.options,
  });

  final TextEditingController controller;
  final String label;
  final List<String> options;

  @override
  Widget build(BuildContext context) {
    final selectedValue =
        controller.text.isEmpty || !options.contains(controller.text)
            ? (options.isEmpty ? null : options.first)
            : controller.text;

    return DropdownButtonFormField<String>(
      key: ValueKey('$label:${controller.text}'),
      initialValue: selectedValue,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFFF8F3EA),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
      items: [
        for (final option in options)
          DropdownMenuItem<String>(value: option, child: Text(option)),
      ],
      onChanged: (value) {
        if (value == null) {
          return;
        }
        controller.text = value;
      },
    );
  }
}

class _MetaText extends StatelessWidget {
  const _MetaText({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(
              text: '$label\n',
              style: TextStyle(color: AppPallete.lightGreyText),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyTableState extends StatelessWidget {
  const _EmptyTableState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.table_rows_outlined,
              size: 48,
              color: Color(0xFFB9A690),
            ),
            const SizedBox(height: 12),
            Text(
              '没有找到匹配的商品',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              '可以切换查询方式，或者尝试缩短关键词后重新搜索。',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppPallete.lightGreyText),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyDetailState extends StatelessWidget {
  const _EmptyDetailState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.touch_app_outlined,
              size: 52,
              color: Color(0xFFB9A690),
            ),
            const SizedBox(height: 14),
            Text(
              '从表格中选择一条商品记录',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              '点击行可快速编辑关键信息，勾选多条后可按当前查询结果导出。',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppPallete.lightGreyText),
            ),
          ],
        ),
      ),
    );
  }
}
