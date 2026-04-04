import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_detail_panel.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_workspace_support.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

ProductModel _buildProduct() {
  return ProductModel(
    id: 1,
    productId: 'book-001',
    title: '等待戈多',
    author: '贝克特',
    isbn: '9787540475277',
    price: 36,
    publisher: '上海译文出版社',
    category: '戏剧',
    selfEncoding: '9787540475277',
    publicationYear: 2021,
    purchaseSaleMode: '购销',
    packaging: '平装',
    statisticalClass: '文学',
    operator: 'admin',
    createdAt: DateTime(2026, 4, 1, 8, 30),
    updatedAt: DateTime(2026, 4, 2, 18, 45),
  );
}

EditableText _editableTextFor(WidgetTester tester, Key key) {
  return tester.widget<EditableText>(
    find.descendant(of: find.byKey(key), matching: find.byType(EditableText)),
  );
}

void main() {
  testWidgets(
    'detail panel keeps metric cards on one row and renders metadata as editable fields',
    (tester) async {
      final product = _buildProduct();
      final titleController = TextEditingController(text: product.title);
      final productIdController = TextEditingController(
        text: product.productId,
      );
      final isbnController = TextEditingController(text: product.isbn);
      final authorController = TextEditingController(text: product.author);
      final priceController = TextEditingController(
        text: product.price.toString(),
      );
      final publicationYearController = TextEditingController(
        text: product.publicationYear.toString(),
      );
      final purchaseSaleModeController = TextEditingController(
        text: product.purchaseSaleMode ?? '',
      );
      final packagingController = TextEditingController(
        text: product.packaging ?? '',
      );
      final statisticalClassController = TextEditingController(
        text: product.statisticalClass ?? '',
      );
      final publisherController = TextEditingController(
        text: product.publisher ?? '',
      );
      final categoryController = TextEditingController(
        text: product.category ?? '',
      );
      final selfEncodingController = TextEditingController(
        text: product.selfEncoding,
      );

      addTearDown(titleController.dispose);
      addTearDown(productIdController.dispose);
      addTearDown(isbnController.dispose);
      addTearDown(authorController.dispose);
      addTearDown(priceController.dispose);
      addTearDown(publicationYearController.dispose);
      addTearDown(purchaseSaleModeController.dispose);
      addTearDown(packagingController.dispose);
      addTearDown(statisticalClassController.dispose);
      addTearDown(publisherController.dispose);
      addTearDown(categoryController.dispose);
      addTearDown(selfEncodingController.dispose);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 720,
              child: ProductQueryDetailPanel(
                formKey: GlobalKey<FormState>(),
                product: product,
                titleController: titleController,
                productIdController: productIdController,
                isbnController: isbnController,
                authorController: authorController,
                priceController: priceController,
                publicationYearController: publicationYearController,
                purchaseSaleModeController: purchaseSaleModeController,
                packagingController: packagingController,
                statisticalClassController: statisticalClassController,
                publisherController: publisherController,
                categoryController: categoryController,
                selfEncodingController: selfEncodingController,
                categoryOptions: const ['戏剧'],
                publisherOptions: const ['上海译文出版社'],
                isAdminModeEnabled: false,
                adminModeTimeoutLabel: '5分钟',
                isSaving: false,
                onSave: () {},
                onRequestAdminMode: () {},
                onOpenFullEditor: () {},
                formatDate: formatProductQueryDateTime,
              ),
            ),
          ),
        ),
      );

      expect(find.text('2026-04-01'), findsOneWidget);
      expect(find.text('2026-04-02'), findsOneWidget);
      expect(find.textContaining('08:30'), findsNothing);
      expect(find.textContaining('18:45'), findsNothing);

      final metricCardKeys = [
        const ValueKey('product-query-metric-isbn'),
        const ValueKey('product-query-metric-operator'),
        const ValueKey('product-query-metric-created-at'),
        const ValueKey('product-query-metric-updated-at'),
      ];
      final metricOffsets = [
        for (final key in metricCardKeys) tester.getTopLeft(find.byKey(key)),
      ];
      final topValues = metricOffsets.map((offset) => offset.dy).toSet();
      expect(topValues.length, 1);

      expect(
        find.byKey(const ValueKey('product-query-publication-year-field')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey('product-query-purchase-sale-mode-field')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey('product-query-packaging-field')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey('product-query-statistical-class-field')),
        findsOneWidget,
      );

      expect(
        _editableTextFor(
          tester,
          const ValueKey('product-query-isbn-field'),
        ).readOnly,
        isTrue,
      );
      expect(
        _editableTextFor(
          tester,
          const ValueKey('product-query-price-field'),
        ).readOnly,
        isTrue,
      );
    },
  );
}
