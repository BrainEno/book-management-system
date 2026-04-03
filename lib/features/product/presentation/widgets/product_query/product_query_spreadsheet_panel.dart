import 'dart:math' as math;

import 'package:bookstore_management_system/core/theme/app_pallete.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_table_source.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ProductQuerySpreadsheetPanel extends StatefulWidget {
  const ProductQuerySpreadsheetPanel({
    super.key,
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
  State<ProductQuerySpreadsheetPanel> createState() =>
      _ProductQuerySpreadsheetPanelState();
}

class _ProductQuerySpreadsheetPanelState
    extends State<ProductQuerySpreadsheetPanel> {
  static const Map<String, double> _defaultColumnWidths = {
    'title': 240,
    'productId': 148,
    'isbn': 182,
    'author': 128,
    'price': 96,
    'category': 110,
    'inventory': 86,
  };
  static const Map<String, double> _minimumColumnWidths = {
    'title': 180,
    'productId': 108,
    'isbn': 140,
    'author': 96,
    'price': 82,
    'category': 92,
    'inventory': 72,
  };
  static const Map<String, double> _maximumColumnWidths = {
    'title': 420,
    'productId': 260,
    'isbn': 320,
    'author': 240,
    'price': 150,
    'category': 220,
    'inventory': 140,
  };

  late final ScrollController _horizontalScrollController;
  late final ScrollController _verticalScrollController;
  late final Map<String, double> _columnWidths;

  @override
  void initState() {
    super.initState();
    _horizontalScrollController = ScrollController();
    _verticalScrollController = ScrollController();
    _columnWidths = Map<String, double>.from(_defaultColumnWidths);
  }

  @override
  void dispose() {
    _horizontalScrollController.dispose();
    _verticalScrollController.dispose();
    super.dispose();
  }

  double _resolveColumnWidth(String columnName) {
    return _columnWidths[columnName] ?? _defaultColumnWidths[columnName] ?? 120;
  }

  bool _handleColumnResizeUpdate(ColumnResizeUpdateDetails details) {
    final columnName = details.column.columnName;
    final minWidth = _minimumColumnWidths[columnName] ?? 72;
    final maxWidth = _maximumColumnWidths[columnName] ?? 420;
    final nextWidth = math.max(
      minWidth,
      math.min(details.width, maxWidth),
    );

    setState(() {
      _columnWidths[columnName] = nextWidth;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE5DED1)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Row(
              children: [
                Text(
                  '商品表格',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Text(
                  '可拖动表头边缘调列宽',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppPallete.lightGreyText,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: widget.isFetching && !widget.hasResults
                ? const Center(child: CircularProgressIndicator())
                : !widget.hasResults
                ? const _EmptyTableState()
                : ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(24),
                    ),
                    child: SfDataGrid(
                      source: widget.source,
                      controller: widget.controller,
                      selectionMode: SelectionMode.multiple,
                      navigationMode: GridNavigationMode.row,
                      showCheckboxColumn: true,
                      headerGridLinesVisibility: GridLinesVisibility.both,
                      gridLinesVisibility: GridLinesVisibility.both,
                      isScrollbarAlwaysShown: true,
                      horizontalScrollController: _horizontalScrollController,
                      verticalScrollController: _verticalScrollController,
                      allowColumnsResizing: true,
                      columnResizeMode: ColumnResizeMode.onResize,
                      columnWidthMode: ColumnWidthMode.none,
                      rowHeight: 44,
                      headerRowHeight: 42,
                      onCellTap: widget.onCellTap,
                      onSelectionChanged: widget.onSelectionChanged,
                      onColumnResizeUpdate: _handleColumnResizeUpdate,
                      columns: [
                        GridColumn(
                          columnName: 'title',
                          width: _resolveColumnWidth('title'),
                          label: GridHeaderLabel(label: '商品名'),
                        ),
                        GridColumn(
                          columnName: 'productId',
                          width: _resolveColumnWidth('productId'),
                          label: GridHeaderLabel(label: '商品编码'),
                        ),
                        GridColumn(
                          columnName: 'isbn',
                          width: _resolveColumnWidth('isbn'),
                          label: GridHeaderLabel(label: 'ISBN码'),
                        ),
                        GridColumn(
                          columnName: 'author',
                          width: _resolveColumnWidth('author'),
                          label: GridHeaderLabel(label: '作者'),
                        ),
                        GridColumn(
                          columnName: 'price',
                          width: _resolveColumnWidth('price'),
                          label: GridHeaderLabel(label: '售价'),
                        ),
                        GridColumn(
                          columnName: 'category',
                          width: _resolveColumnWidth('category'),
                          label: GridHeaderLabel(label: '种类'),
                        ),
                        GridColumn(
                          columnName: 'inventory',
                          width: _resolveColumnWidth('inventory'),
                          label: GridHeaderLabel(label: '库存'),
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

class GridHeaderLabel extends StatelessWidget {
  const GridHeaderLabel({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: const Color(0xFFF5EEE2),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
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
