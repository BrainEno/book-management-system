import 'package:bookstore_management_system/core/window/app_window_manager.dart';
import 'package:bookstore_management_system/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_info_editor_view.dart';
import 'package:bookstore_management_system/features/product/presentation/pages/product_page.dart';
import 'package:bookstore_management_system/inventory/presentation/pages/inventory_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppWindowPayload {
  const AppWindowPayload({
    this.initialProducts,
    this.initialProduct,
    this.productEditorDraft,
    this.currentOperatorUsername,
  });

  final List<ProductModel>? initialProducts;
  final ProductModel? initialProduct;
  final Map<String, String>? productEditorDraft;
  final String? currentOperatorUsername;

  bool get isEmpty =>
      (initialProducts == null || initialProducts!.isEmpty) &&
      initialProduct == null &&
      (productEditorDraft == null || productEditorDraft!.isEmpty) &&
      currentOperatorUsername == null;

  Map<String, dynamic> toJson() => {
    if (initialProducts != null)
      'products': initialProducts!.map((product) => product.toJson()).toList(),
    if (initialProduct != null) 'product': initialProduct!.toJson(),
    if (productEditorDraft != null) 'productEditorDraft': productEditorDraft,
    if (currentOperatorUsername != null)
      'currentOperatorUsername': currentOperatorUsername,
  };

  factory AppWindowPayload.fromJson(Map<String, dynamic> json) {
    final rawProducts = json['products'];
    final rawProduct = json['product'];
    final rawDraft = json['productEditorDraft'];
    final rawOperatorUsername = json['currentOperatorUsername'];

    return AppWindowPayload(
      initialProducts: rawProducts is List
          ? rawProducts
                .whereType<Map>()
                .map(
                  (product) =>
                      ProductModel.fromJson(Map<String, dynamic>.from(product)),
                )
                .toList()
          : null,
      initialProduct: rawProduct is Map
          ? ProductModel.fromJson(Map<String, dynamic>.from(rawProduct))
          : null,
      productEditorDraft: rawDraft is Map<String, String>
          ? rawDraft
          : rawDraft is Map
          ? rawDraft.map(
              (key, value) => MapEntry(key.toString(), value?.toString() ?? ''),
            )
          : null,
      currentOperatorUsername: rawOperatorUsername?.toString(),
    );
  }

  AppWindowPayload copyWith({
    List<ProductModel>? initialProducts,
    ProductModel? initialProduct,
    Map<String, String>? productEditorDraft,
    String? currentOperatorUsername,
    bool clearInitialProducts = false,
    bool clearInitialProduct = false,
    bool clearProductEditorDraft = false,
    bool clearCurrentOperatorUsername = false,
  }) {
    return AppWindowPayload(
      initialProducts: clearInitialProducts
          ? null
          : (initialProducts ?? this.initialProducts),
      initialProduct: clearInitialProduct
          ? null
          : (initialProduct ?? this.initialProduct),
      productEditorDraft: clearProductEditorDraft
          ? null
          : (productEditorDraft ?? this.productEditorDraft),
      currentOperatorUsername: clearCurrentOperatorUsername
          ? null
          : (currentOperatorUsername ?? this.currentOperatorUsername),
    );
  }
}

typedef AppWindowPageBuilder =
    Widget Function(BuildContext context, AppWindowPayload payload);

class AppWindowDestination {
  const AppWindowDestination({
    required this.pageKey,
    required this.title,
    required this.label,
    required this.icon,
    required this.builder,
  });

  final String pageKey;
  final String title;
  final String label;
  final IconData icon;
  final AppWindowPageBuilder builder;
}

final List<AppWindowDestination> appWindowDestinations = [
  AppWindowDestination(
    pageKey: 'dashboard',
    title: '主控台',
    label: '主控台',
    icon: Icons.dashboard_customize_outlined,
    builder: (context, _) => DashboardPage(
      onOpenPage: (pageKey) => openAppWindowByPageKey(context, pageKey),
    ),
  ),
  AppWindowDestination(
    pageKey: 'product',
    title: '商品资料',
    label: '商品资料',
    icon: Icons.shopping_bag_outlined,
    builder: (_, payload) =>
        ProductPage(initialProducts: payload.initialProducts),
  ),
  AppWindowDestination(
    pageKey: 'inventory',
    title: '库存',
    label: '库存',
    icon: Icons.inventory_2_outlined,
    builder: (_, _) => const InventoryPage(),
  ),
];

final List<AppWindowDestination> floatingWindowDestinations = [
  AppWindowDestination(
    pageKey: 'product-editor',
    title: '商品编辑',
    label: '商品编辑',
    icon: Icons.edit_outlined,
    builder: (_, payload) =>
        ProductInfoEditorView(
          product: payload.initialProduct,
          initialDraft: payload.productEditorDraft,
          initialOperatorUsername: payload.currentOperatorUsername,
        ),
  ),
];

AppWindowDestination? findAppWindowDestination(String pageKey) {
  for (final destination in appWindowDestinations) {
    if (destination.pageKey == pageKey) {
      return destination;
    }
  }

  return null;
}

AppWindowDestination? findFloatingWindowDestination(String pageKey) {
  for (final destination in floatingWindowDestinations) {
    if (destination.pageKey == pageKey) {
      return destination;
    }
  }

  return null;
}

void openAppWindowByPageKey(
  BuildContext context,
  String pageKey, {
  AppWindowPayload payload = const AppWindowPayload(),
}) {
  final destination = findAppWindowDestination(pageKey);
  if (destination == null) {
    return;
  }

  context.read<AppWindowManager>().openWindow(
    title: destination.title,
    popOutPageKey: destination.pageKey,
    payload: payload,
  );
}
