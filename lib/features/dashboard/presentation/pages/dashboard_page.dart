import 'dart:async';

import 'package:bookstore_management_system/core/theme/theme_bloc.dart';
import 'package:bookstore_management_system/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookstore_management_system/features/dashboard/presentation/widgets/dashboard_view.dart';
import 'package:bookstore_management_system/features/product/domain/entities/product.dart';
import 'package:bookstore_management_system/features/product/presentation/blocs/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key, required this.onOpenPage});

  final ValueChanged<String> onOpenPage;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Timer _clockTimer;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _clockTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _now = DateTime.now();
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      final bloc = context.read<ProductBloc>();
      if (bloc.state is! ProductsLoaded) {
        bloc.add(GetAllBooksEvent());
      }
    });
  }

  @override
  void dispose() {
    _clockTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.select((AuthBloc bloc) => bloc.state);
    final productState = context.select((ProductBloc bloc) => bloc.state);
    final themeMode = context.select((ThemeBloc bloc) => bloc.state.themeMode);

    final currentUser = authState is AuthSuccess ? authState.user : null;
    final products = productState is ProductsLoaded
        ? productState.products
        : <Product>[];

    return DashboardView(
      now: _now,
      currentUser: currentUser,
      themeMode: themeMode,
      products: products,
      onCommandPressed: () =>
          _showPlannedFeature('全局搜索和命令面板会在后续统一接入商品、会员与销售单据检索。'),
      onToggleTheme: () => context.read<ThemeBloc>().add(ToggleTheme()),
      onOpenProduct: () => widget.onOpenPage('product'),
      onOpenInventory: () => widget.onOpenPage('inventory'),
      onOpenPage: widget.onOpenPage,
      onLogout: () {
        context.read<AuthBloc>().add(AuthLogoutRequested());
      },
      onShowPlannedFeature: _showPlannedFeature,
    );
  }

  void _showPlannedFeature(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }
}
