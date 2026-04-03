import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_spreadsheet_panel.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_table_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  testWidgets('spreadsheet panel uses compact sizing and supports column resizing', (
    tester,
  ) async {
    final controller = DataGridController();
    addTearDown(controller.dispose);
    final product = ProductModel(
      productId: 'BOOK-001',
      id: 1,
      title: '测试商品',
      author: '测试作者',
      isbn: '9787300000001',
      price: 58,
      category: '文学',
      selfEncoding: 'SELF-001',
      operator: 'tester',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 960,
            height: 560,
            child: ProductQuerySpreadsheetPanel(
              source: ProductQueryTableSource(
                products: [product],
                activeProductId: product.id,
              ),
              controller: controller,
              isFetching: false,
              hasResults: true,
              onCellTap: (_) {},
              onSelectionChanged: (_, removedRows) {},
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final dataGrid = tester.widget<SfDataGrid>(find.byType(SfDataGrid));

    expect(dataGrid.allowColumnsResizing, isTrue);
    expect(dataGrid.rowHeight, 44);
    expect(dataGrid.headerRowHeight, 42);
    expect(dataGrid.columns.first.width, 240);
    expect(find.text('可拖动表头边缘调列宽'), findsOneWidget);
  });
}
