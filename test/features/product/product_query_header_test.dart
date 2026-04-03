import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_header.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('search field expands across the available header width', (
    tester,
  ) async {
    final searchController = TextEditingController();
    addTearDown(searchController.dispose);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 1280,
            child: ProductQueryHeader(
              searchController: searchController,
              queryMode: ProductQueryMode.title,
              totalCount: 12,
              visibleCount: 8,
              selectedCount: 0,
              isBusy: false,
              exportButtonLabel: '导出全部（8）',
              onQueryModeChanged: (_) {},
              onCreatePressed: () {},
              onRefreshPressed: () {},
              onExportPressed: () {},
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final searchField = find.byKey(const ValueKey('product-query-search-field'));

    expect(searchField, findsOneWidget);
    expect(find.byKey(const ValueKey('product-query-mode-field')), findsOneWidget);
    expect(tester.getSize(searchField).width, greaterThan(700));
  });
}
