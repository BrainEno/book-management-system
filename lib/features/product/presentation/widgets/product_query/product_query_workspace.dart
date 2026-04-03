import 'package:bookstore_management_system/features/product/data/mappers/product_entity_mapper.dart';
import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:bookstore_management_system/features/product/presentation/blocs/product_bloc.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_info_editor/product_info_editor_form_state.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_info_editor_view.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_detail_form_controller.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_detail_panel.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_export_service.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_header.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_spreadsheet_panel.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_table_source.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_utils.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_workspace_support.dart';
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
  final _detailFormController = ProductQueryDetailFormController();

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
        preferredSelectionId: widget.initialProducts?.isNotEmpty == true
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
    _detailFormController.dispose();
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
    nextSelection ??= visibleProducts.isNotEmpty ? visibleProducts.first : null;

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

    final price = _detailFormController.parsePrice();
    if (price == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('售价格式不正确')));
      return;
    }

    final updatedProduct = _detailFormController.buildUpdatedProduct(
      selectedProduct,
    );

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

  @override
  Widget build(BuildContext context) {
    final visibleProducts = _visibleProductsFor(_products);
    final selectedProduct = _selectedProduct;
    final theme = Theme.of(context);
    final publisherOptions = mergeProductQueryOptions(
      productPublisherOptions,
      _products.map((product) => product.publisher),
    );
    final categoryOptions = mergeProductQueryOptions(
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
                              publisherController:
                                  _detailFormController.publisherController,
                              categoryController:
                                  _detailFormController.categoryController,
                              selfEncodingController:
                                  _detailFormController.selfEncodingController,
                              categoryOptions: categoryOptions,
                              publisherOptions: publisherOptions,
                              isSaving: _isSaving,
                              onSave: _saveSelectedProduct,
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
                            flex: 10,
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
                              publisherController:
                                  _detailFormController.publisherController,
                              categoryController:
                                  _detailFormController.categoryController,
                              selfEncodingController:
                                  _detailFormController.selfEncodingController,
                              categoryOptions: categoryOptions,
                              publisherOptions: publisherOptions,
                              isSaving: _isSaving,
                              onSave: _saveSelectedProduct,
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
