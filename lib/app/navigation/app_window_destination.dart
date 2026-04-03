import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:bookstore_management_system/features/product/presentation/pages/product_page.dart';
import 'package:bookstore_management_system/inventory/presentation/pages/inventory_page.dart';
import 'package:flutter/material.dart';

class AppWindowPayload {
  const AppWindowPayload({this.initialProducts});

  final List<ProductModel>? initialProducts;
}

typedef AppWindowPageBuilder = Widget Function(AppWindowPayload payload);

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
    pageKey: 'product',
    title: '商品资料',
    label: '商品资料',
    icon: Icons.shopping_bag_outlined,
    builder: (payload) => ProductPage(initialProducts: payload.initialProducts),
  ),
  AppWindowDestination(
    pageKey: 'inventory',
    title: '库存',
    label: '库存',
    icon: Icons.inventory_2_outlined,
    builder: (_) => const InventoryPage(),
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
