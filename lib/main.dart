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
import 'dart:io'; // Added for platform checks
import 'package:permission_handler/permission_handler.dart'; // Import permission_handler

Future<void> _requestPermissions() async {
  // Only request on mobile platforms
  if (Platform.isIOS || Platform.isAndroid) {
    // Request Camera Permission
    PermissionStatus cameraStatus = await Permission.camera.request();

    if (cameraStatus.isGranted) {
      if (kDebugMode) {
        AppLogger.logger.i("Camera permission granted");
      }
    } else if (cameraStatus.isDenied) {
      if (kDebugMode) {
        AppLogger.logger.i("Camera permission denied");
      }
    } else if (cameraStatus.isPermanentlyDenied) {
      if (kDebugMode) {
        AppLogger.logger.i("Camera permission permanently denied");
      }
      // Optionally, open app settings if permanently denied
      openAppSettings();
    }

    PermissionStatus photoStatus = await Permission.photos.request();

    if (photoStatus.isGranted) {
      if (kDebugMode) {
        AppLogger.logger.i("Photo library permission granted");
      }
    } else if (photoStatus.isDenied) {
      if (kDebugMode) {
        AppLogger.logger.i("Photo library permission denied");
      }
    } else if (photoStatus.isPermanentlyDenied) {
      if (kDebugMode) {
        AppLogger.logger.i("Photo library permission permanently denied");
      }
      // Optionally, open app settings
      openAppSettings();
    }

    if (Platform.isAndroid || Platform.isIOS) {
      // This requires Android SDK 33+
      var nearbyStatus = await Permission.nearbyWifiDevices.request();

      if (nearbyStatus.isGranted) {
        AppLogger.logger.i("Nearby WiFi devices permission granted");
      } else {
        AppLogger.logger.i("Nearby WiFi devices permission denied");
      }

      if (nearbyStatus.isGranted) {
        if (kDebugMode) {
          AppLogger.logger.i("Nearby permission granted");
        }
      } else if (nearbyStatus.isDenied) {
        if (kDebugMode) {
          AppLogger.logger.i("Nearby permission denied");
        }
      } else if (nearbyStatus.isPermanentlyDenied) {
        if (kDebugMode) {
          AppLogger.logger.i("Nearby permission permanently denied");
        }
        // Optionally, open app settings if permanently denied
        openAppSettings();
      }
    }
  }
}

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  await _requestPermissions();

  if (args.isNotEmpty && args.first == 'multi_window') {
    //  Decode the arguments properly
    final arguments = Map<String, dynamic>.from(jsonDecode(args[2]));

    final String pageKey = arguments['page'] ?? '';
    // Get size arguments
    final double width = arguments['width'] ?? 800;
    final double height = arguments['height'] ?? 600;
    final String title = arguments['title'] ?? 'Floating Window';

    Widget pageToShow;

    // FIX: Make sure your case strings match the popOutPageKey exactly
    switch (pageKey) {
      case 'product':
        pageToShow = const ProductPage();
        break;
      case 'inventory':
        pageToShow = const InventoryPage();
        break;
      default:
        // This is what was likely being shown before
        pageToShow = Center(child: Text("Error: Unknown page key '$pageKey'"));
    }

    // NEW: Set the initial size and title of the new window
    // This requires a separate async function
    _configureAndRunSubWindow(pageToShow, title, width, height);
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
        // Other providers...
        BlocProvider(create: (_) => sl<ThemeBloc>()),
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => sl<ProductBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

// NEW: Helper function to manage sub-window creation
void _configureAndRunSubWindow(
  Widget page,
  String title,
  double width,
  double height,
) async {
  // We need to initialize windowManager for each sub-window as well to control it
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    size: Size(width, height), // Use the passed size
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    title: title,
    titleBarStyle: TitleBarStyle.normal,
  );

  // By default, windows are resizable. This ensures it.
  windowManager.setResizable(true);

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      home: Scaffold(body: page),
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
            home:
                MobileHomeScreen(), // Consider navigating based on auth state here too
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
  initialLocation:
      '/login', // Consider checking auth state for initial location
  routes: [
    GoRoute(path: '/', builder: (context, state) => const DesktopShell()),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
  ],
  redirect: (BuildContext context, GoRouterState state) {
    final authBloc = context.read<AuthBloc>();
    final bool loggedIn =
        authBloc.state is AuthSuccess; // Adjust based on your AuthState
    final bool loggingIn = state.matchedLocation == '/login';

    if (!loggedIn && !loggingIn) return '/login';
    if (loggedIn && loggingIn) return '/';

    return null;
  },
);
