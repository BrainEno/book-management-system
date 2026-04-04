import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_utils.dart';
import 'package:flutter/material.dart';
import 'package:bookstore_management_system/core/theme/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ProductQueryTableSource extends DataGridSource {
  ProductQueryTableSource({
    required this.products,
    required this.activeProductId,
  }) {
    _rows = products.map(_buildRow).toList(growable: false);
  }

  final List<ProductModel> products;
  final int? activeProductId;

  final Map<DataGridRow, ProductModel> _productByRow =
      <DataGridRow, ProductModel>{};
  final Map<int, DataGridRow> _rowByProductId = <int, DataGridRow>{};
  late final List<DataGridRow> _rows;

  @override
  List<DataGridRow> get rows => _rows;

  ProductModel? productForRow(DataGridRow row) => _productByRow[row];

  ProductModel? productForRowIndex(int rowIndex) {
    final dataIndex = rowIndex - 1;
    if (dataIndex < 0 || dataIndex >= _rows.length) {
      return null;
    }
    return _productByRow[_rows[dataIndex]];
  }

  List<DataGridRow> rowsForProductIds(Set<int> productIds) {
    return [
      for (final product in products)
        if (productIds.contains(product.id) &&
            _rowByProductId[product.id] != null)
          _rowByProductId[product.id]!,
    ];
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final product = _productByRow[row]!;
    final isActive = product.id == activeProductId;
    final textStyle = TextStyle(
      color: const Color(0xFF2C3036),
      fontFamily: AppTheme.appFontFamily,
      fontFamilyFallback: AppTheme.appFontFamilyFallback,
      fontWeight: FontWeight.w500,
    );

    return DataGridRowAdapter(
      color: isActive ? const Color(0xFFFFF7EE) : Colors.white,
      cells: [
        _buildCell(product.title, textStyle, alignment: Alignment.centerLeft),
        _buildCell(
          product.productId,
          textStyle,
          alignment: Alignment.centerLeft,
        ),
        _buildCell(
          product.isbn ?? '',
          textStyle,
          alignment: Alignment.centerLeft,
        ),
        _buildCell(product.author, textStyle, alignment: Alignment.centerLeft),
        _buildCell(
          '¥${formatProductPrice(product.price)}',
          textStyle,
          alignment: Alignment.centerRight,
        ),
        _buildCell(
          product.category ?? '',
          textStyle,
          alignment: Alignment.centerLeft,
        ),
        _buildCell(formatInventory(product), textStyle),
      ],
    );
  }

  DataGridRow _buildRow(ProductModel product) {
    final row = DataGridRow(
      cells: [
        DataGridCell<String>(columnName: 'title', value: product.title),
        DataGridCell<String>(columnName: 'productId', value: product.productId),
        DataGridCell<String>(columnName: 'isbn', value: product.isbn ?? ''),
        DataGridCell<String>(columnName: 'author', value: product.author),
        DataGridCell<String>(
          columnName: 'price',
          value: formatProductPrice(product.price),
        ),
        DataGridCell<String>(
          columnName: 'category',
          value: product.category ?? '',
        ),
        DataGridCell<String>(
          columnName: 'inventory',
          value: formatInventory(product),
        ),
      ],
    );
    _productByRow[row] = product;
    _rowByProductId[product.id] = row;
    return row;
  }

  Widget _buildCell(
    String value,
    TextStyle textStyle, {
    Alignment alignment = Alignment.center,
  }) {
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Text(
        value.isEmpty ? '--' : value,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: textStyle,
      ),
    );
  }
}
