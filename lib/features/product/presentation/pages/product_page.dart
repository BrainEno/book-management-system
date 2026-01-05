// pages/product_page.dart
import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_info_editor_view.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final List<ProductModel>? initialProducts;
  const ProductPage({super.key, this.initialProducts});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ProductInfoEditorView(
        product:
            initialProducts?.isNotEmpty == true ? initialProducts!.first : null,
      ),
    );
  }
}
