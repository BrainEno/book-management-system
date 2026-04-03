import 'package:bookstore_management_system/core/window/app_window_manager.dart';
import 'package:bookstore_management_system/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:bookstore_management_system/features/product/presentation/pages/product_page.dart';
import 'package:bookstore_management_system/inventory/presentation/pages/inventory_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppWindowPayload {
  const AppWindowPayload({this.initialProducts});

  final List<ProductModel>? initialProducts;
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

AppWindowDestination? findAppWindowDestination(String pageKey) {
  for (final destination in appWindowDestinations) {
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

  context.read<AppWindowManager>().openOrFocusWindow(
    title: destination.title,
    content: destination.builder(context, payload),
    popOutPageKey: destination.pageKey,
  );
}
