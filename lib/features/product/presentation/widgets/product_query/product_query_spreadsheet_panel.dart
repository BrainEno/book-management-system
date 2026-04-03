import 'package:bookstore_management_system/core/theme/app_pallete.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_table_source.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ProductQuerySpreadsheetPanel extends StatelessWidget {
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
            child: isFetching && !hasResults
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
                          label: GridHeaderLabel(label: '商品名'),
                        ),
                        GridColumn(
                          columnName: 'productId',
                          width: 150,
                          label: GridHeaderLabel(label: '商品编码'),
                        ),
                        GridColumn(
                          columnName: 'isbn',
                          width: 180,
                          label: GridHeaderLabel(label: 'ISBN码'),
                        ),
                        GridColumn(
                          columnName: 'author',
                          width: 140,
                          label: GridHeaderLabel(label: '作者'),
                        ),
                        GridColumn(
                          columnName: 'price',
                          width: 110,
                          label: GridHeaderLabel(label: '售价'),
                        ),
                        GridColumn(
                          columnName: 'category',
                          width: 130,
                          label: GridHeaderLabel(label: '种类'),
                        ),
                        GridColumn(
                          columnName: 'inventory',
                          width: 96,
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
