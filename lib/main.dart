import 'dart:convert';

import 'package:bookstore_management_system/core/common/logger/app_logger.dart';
import 'package:bookstore_management_system/core/presentation/pages/desktop_shell.dart';
import 'package:bookstore_management_system/core/theme/theme.dart';
import 'package:bookstore_management_system/core/theme/theme_bloc.dart';
import 'package:bookstore_management_system/core/window/app_window_manager.dart';
import 'package:bookstore_management_system/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookstore_management_system/features/auth/presentation/pages/login_page.dart';
import 'package:bookstore_management_system/features/product/presentation/blocs/product_bloc.dart';
import 'package:bookstore_management_system/core/init_dependencies.dart';
import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:bookstore_management_system/features/product/presentation/pages/product_page.dart';
import 'package:bookstore_management_system/features/product/presentation/screens/mobile_home_screen.dart';
import 'package:bookstore_management_system/inventory/presentation/pages/inventory_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart'
    show ChangeNotifierProvider, MultiProvider;
import 'package:window_manager/window_manager.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

bool isSubWindowInstance = false;

Future<void> _requestPermissions() async {
  if (Platform.isIOS || Platform.isAndroid) {
    PermissionStatus cameraStatus = await Permission.camera.request();
    if (cameraStatus.isGranted) {
      if (kDebugMode) AppLogger.logger.i("Camera permission granted");
    }

    PermissionStatus photoStatus = await Permission.photos.request();
    if (photoStatus.isGranted) {
      if (kDebugMode) AppLogger.logger.i("Photo library permission granted");
    }

    if (Platform.isAndroid || Platform.isIOS) {
      var nearbyStatus = await Permission.nearbyWifiDevices.request();
      if (nearbyStatus.isGranted) {
        AppLogger.logger.i("Nearby WiFi devices permission granted");
      }
    }
  }
}

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await _requestPermissions();
  final bool isMultiWindow = args.isNotEmpty && args.first == 'multi_window';
  isSubWindowInstance = isMultiWindow;

  await initDependencies(isMultiWindow: isMultiWindow);

  if (isMultiWindow) {
    // Decode the arguments properly
    final arguments = Map<String, dynamic>.from(jsonDecode(args[2]));

    final String pageKey = arguments['page'] ?? '';
    final String? initialStateJson = arguments['state'];

    List<ProductModel>? initialProducts;
    if (initialStateJson != null) {
      final state = jsonDecode(initialStateJson);
      if (state['products'] != null) {
        initialProducts =
            (state['products'] as List)
                .map((p) => ProductModel.fromJson(p))
                .toList();
      }
    }

    Widget pageToShow;
    switch (pageKey) {
      case 'product':
        pageToShow = ProductPage(initialProducts: initialProducts);
        break;
      case 'inventory':
        pageToShow = const InventoryPage();
        break;
      default:
        pageToShow = Center(child: Text("Error: Unknown page key '$pageKey'"));
    }

    _runSubWindowApp(pageToShow);
    return;
  }

  // Main window logic
  if (!kIsWeb && (Platform.isWindows || Platform.isMacOS || Platform.isLinux)) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      size: Size(1280, 720),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppWindowManager()),
        BlocProvider(create: (_) => sl<ThemeBloc>()),
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => sl<ProductBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

void _runSubWindowApp(Widget page) {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppWindowManager()),
        BlocProvider(create: (_) => sl<ThemeBloc>()),
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => sl<ProductBloc>()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: state.themeMode,
            theme: AppTheme.lightThemeMode,
            darkTheme: AppTheme.darkThemeMode,
            // 使用 Scaffold 确保有 Material 背景和正确的布局
            home: Scaffold(body: page),
          );
        },
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  bool get isMobilePlatform =>
      !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        if (isMobilePlatform) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: state.themeMode,
            theme: AppTheme.lightThemeMode,
            darkTheme: AppTheme.darkThemeMode,
            home: const MobileHomeScreen(),
          );
        } else {
          return MaterialApp.router(
            builder: FToastBuilder(),
            debugShowCheckedModeBanner: false,
            themeMode: state.themeMode,
            theme: AppTheme.lightThemeMode,
            darkTheme: AppTheme.darkThemeMode,
            routerConfig: _router,
          );
        }
      },
    );
  }
}

final _router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const DesktopShell()),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
  ],
  redirect: (BuildContext context, GoRouterState state) {
    final authBloc = context.read<AuthBloc>();
    final bool loggedIn = authBloc.state is AuthSuccess;
    final bool loggingIn = state.matchedLocation == '/login';

    if (!loggedIn && !loggingIn) return '/login';
    if (loggedIn && loggingIn) return '/';

    return null;
  },
);
