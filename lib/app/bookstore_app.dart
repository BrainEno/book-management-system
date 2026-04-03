import 'dart:io';

import 'package:bookstore_management_system/core/theme/theme.dart';
import 'package:bookstore_management_system/core/theme/theme_bloc.dart';
import 'package:bookstore_management_system/core/presentation/pages/desktop_shell.dart';
import 'package:bookstore_management_system/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookstore_management_system/features/auth/presentation/pages/login_page.dart';
import 'package:bookstore_management_system/features/product/presentation/screens/mobile_home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BookstoreApp extends StatelessWidget {
  const BookstoreApp({super.key});

  bool get _isMobilePlatform {
    return !kIsWeb && (Platform.isAndroid || Platform.isIOS);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        if (_isMobilePlatform) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: state.themeMode,
            theme: AppTheme.lightThemeMode,
            darkTheme: AppTheme.darkThemeMode,
            home: const MobileHomeScreen(),
          );
        }

        return MaterialApp(
          builder: FToastBuilder(),
          debugShowCheckedModeBanner: false,
          themeMode: state.themeMode,
          theme: AppTheme.lightThemeMode,
          darkTheme: AppTheme.darkThemeMode,
          home: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              if (authState is AuthSuccess) {
                return const DesktopShell();
              }

              return const LoginPage();
            },
          ),
        );
      },
    );
  }
}

class BookstoreSubWindowApp extends StatelessWidget {
  const BookstoreSubWindowApp({super.key, required this.page});

  final Widget page;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: state.themeMode,
          theme: AppTheme.lightThemeMode,
          darkTheme: AppTheme.darkThemeMode,
          home: Scaffold(body: page),
        );
      },
    );
  }
}
