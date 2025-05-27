import 'package:bookstore_management_system/core/common/logger/app_logger.dart';
import 'package:bookstore_management_system/core/theme/theme.dart';
import 'package:bookstore_management_system/core/theme/theme_bloc.dart';
import 'package:bookstore_management_system/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookstore_management_system/features/auth/presentation/pages/login_page.dart';
import 'package:bookstore_management_system/features/book/presentation/blocs/book_bloc.dart';
import 'package:bookstore_management_system/features/book/presentation/pages/home_page.dart';
import 'package:bookstore_management_system/core/init_dependencies.dart';
import 'package:bookstore_management_system/features/book/presentation/screens/mobile_home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:showcaseview/showcaseview.dart';
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
        print("Camera permission granted");
      }
    } else if (cameraStatus.isDenied) {
      if (kDebugMode) {
        print("Camera permission denied");
      }
    } else if (cameraStatus.isPermanentlyDenied) {
      if (kDebugMode) {
        print("Camera permission permanently denied");
      }
      // Optionally, open app settings if permanently denied
      // openAppSettings();
    }

    // Request Photo Library Permission
    // On Android, for SDK 33+, use Permission.photos. For older SDKs, it might fall under Permission.storage.
    // permission_handler usually handles this, but be mindful of Android specifics if issues arise.
    PermissionStatus photoStatus;
    if (Platform.isAndroid) {
      // Example for Android 13+ specific photo picker permission
      // For broader compatibility or if targeting older Android versions,
      // you might need to request Permission.storage or handle API level checks.
      // However, Permission.photos is generally the modern approach.
      photoStatus = await Permission.photos.request();
    } else {
      // iOS
      photoStatus = await Permission.photos.request();
    }

    if (photoStatus.isGranted) {
      if (kDebugMode) {
        print("Photo library permission granted");
      }
    } else if (photoStatus.isDenied) {
      if (kDebugMode) {
        print("Photo library permission denied");
      }
    } else if (photoStatus.isPermanentlyDenied) {
      if (kDebugMode) {
        print("Photo library permission permanently denied");
      }
      // Optionally, open app settings
      openAppSettings();
    }

    if (Platform.isAndroid) {
      // This requires Android SDK 33+
      var nearbyStatus = await Permission.nearbyWifiDevices.request();
      if (nearbyStatus.isGranted) {
        AppLogger.logger.i("Nearby WiFi devices permission granted");
      } else {
        AppLogger.logger.i("Nearby WiFi devices permission denied");
      }
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  // Request permissions after dependencies are initialized
  await _requestPermissions(); // Call the permission request function

  // Only initialize windowManager on desktop platforms
  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = WindowOptions(
      size: Size(1920, 1080),
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
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<ThemeBloc>()),
        BlocProvider(create: (context) => sl<AuthBloc>()),
        BlocProvider(create: (context) => sl<BookBloc>()),
      ],
      child: ShowCaseWidget(builder: (context) => const MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  bool get isMobilePlatform =>
      defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS;

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
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
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
