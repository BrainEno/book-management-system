import 'dart:async';
import 'dart:io';

import 'package:bookstore_management_system/app/bootstrap/app_runtime.dart';
import 'package:bookstore_management_system/core/common/logger/app_logger.dart';
import 'package:bookstore_management_system/core/di/service_locator.dart';
import 'package:bookstore_management_system/core/theme/theme.dart';
import 'package:bookstore_management_system/core/theme/theme_bloc.dart';
import 'package:bookstore_management_system/core/presentation/pages/desktop_shell.dart';
import 'package:bookstore_management_system/core/window/app_window_manager.dart';
import 'package:bookstore_management_system/core/window/sub_window_lifecycle_policy.dart';
import 'package:bookstore_management_system/core/window/window_pop_out_service.dart';
import 'package:bookstore_management_system/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookstore_management_system/features/auth/presentation/pages/login_page.dart';
import 'package:bookstore_management_system/features/product/presentation/screens/mobile_home_screen.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

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
          home: _SubWindowLifecycleHost(page: page),
        );
      },
    );
  }
}

class _SubWindowLifecycleHost extends StatefulWidget {
  const _SubWindowLifecycleHost({required this.page});

  final Widget page;

  @override
  State<_SubWindowLifecycleHost> createState() =>
      _SubWindowLifecycleHostState();
}

class _SubWindowLifecycleHostState extends State<_SubWindowLifecycleHost>
    with WindowListener {
  static const _maximizeDockArmDelay = Duration(milliseconds: 1500);

  final AppRuntime _runtime = sl<AppRuntime>();
  final WindowPopOutService _windowPopOutService =
      const DesktopWindowPopOutService();
  final WindowMethodChannel _channel = const WindowMethodChannel(
    'bookstore_sub_window_events',
    mode: ChannelMode.unidirectional,
  );
  final _logger = AppLogger.logger;

  bool _registeredWindowListener = false;
  bool _registeredCloseHandler = false;
  bool _handlingWindowTransition = false;
  bool _maximizeDockArmed = false;
  int _lifecycleEventSequence = 0;
  Timer? _maximizeDockArmTimer;

  @override
  void initState() {
    super.initState();
    _registerWindowListener();
    _maximizeDockArmTimer = Timer(_maximizeDockArmDelay, () {
      _maximizeDockArmed = true;
      _logger.i(
        'Sub-window lifecycle armed for maximize docking: host=${_runtime.hostWindowId}, window=${_runtime.windowId}',
      );
    });
  }

  AppWindowManager? get _localWindowManager {
    if (!mounted) {
      return null;
    }
    try {
      return Provider.of<AppWindowManager>(context, listen: false);
    } catch (_) {
      return null;
    }
  }

  String _trackedWindowSummary() {
    final manager = _localWindowManager;
    if (manager == null) {
      return 'unavailable';
    }

    return manager.windows
        .map(
          (window) =>
              '${window.id}:${window.popOutPageKey}:${window.displayMode.name}:${window.floatingWindowId ?? '-'}',
        )
        .join(', ');
  }

  void _logLifecycleEvent(
    String event, {
    Map<String, Object?> data = const {},
  }) {
    final sequence = ++_lifecycleEventSequence;
    final payload = <String, Object?>{
      'seq': sequence,
      'event': event,
      'host': _runtime.hostWindowId,
      'window': _runtime.windowId,
      'transitioning': _handlingWindowTransition,
      'armed': _maximizeDockArmed,
      'tracked': _trackedWindowSummary(),
      ...data,
    };
    final message = payload.entries
        .map((entry) => '${entry.key}=${entry.value}')
        .join(', ');
    _logger.i('Sub-window lifecycle event: $message');
  }

  @override
  void dispose() {
    _logLifecycleEvent('dispose.begin');
    _maximizeDockArmTimer?.cancel();
    if (_registeredWindowListener) {
      windowManager.removeListener(this);
      unawaited(windowManager.setPreventClose(false));
    }
    if (_registeredCloseHandler) {
      unawaited(_unregisterWindowControllerHandler());
    }
    _logLifecycleEvent('dispose.end');
    super.dispose();
  }

  Future<void> _registerWindowListener() async {
    if (!_runtime.isSubWindow || _runtime.hostWindowId == null) {
      return;
    }

    try {
      _logLifecycleEvent('register.begin');
      await windowManager.ensureInitialized();
      await windowManager.setPreventClose(true);
      windowManager.addListener(this);
      _registeredWindowListener = true;
      await _registerWindowControllerHandler();
      _logLifecycleEvent(
        'register.success',
        data: {
          'preventClose': true,
          'sharedHandlerRegistered': shouldRegisterSharedSubWindowEventHandler(
            isSubWindow: _runtime.isSubWindow,
          ),
        },
      );
    } catch (error, stackTrace) {
      _registeredWindowListener = false;
      _logger.e(
        'Failed to register sub-window lifecycle listeners.',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> _registerWindowControllerHandler() async {
    try {
      final controller = await WindowController.fromCurrentEngine();
      await controller.setWindowMethodHandler((call) async {
        _logLifecycleEvent(
          'controller.method.received',
          data: {'method': call.method, 'arguments': call.arguments},
        );
        switch (call.method) {
          case 'window_close':
            await _closeLocalFloatingChildren(reason: 'remote-close');
            await _closeCurrentWindow(reason: 'remote-close');
            return null;
          default:
            throw MissingPluginException(
              'Unsupported sub-window controller method: ${call.method}',
            );
        }
      });
      _registeredCloseHandler = true;
    } catch (error, stackTrace) {
      _registeredCloseHandler = false;
      _logger.w(
        'Failed to register sub-window controller handler.',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> _unregisterWindowControllerHandler() async {
    try {
      _logLifecycleEvent('controller.method.unregister.begin');
      final controller = await WindowController.fromCurrentEngine();
      await controller.setWindowMethodHandler(null);
      _logLifecycleEvent('controller.method.unregister.end');
    } catch (_) {
      // Best effort.
    }
  }

  Future<void> _closeLocalFloatingChildren({required String reason}) async {
    final manager = _localWindowManager;
    if (manager == null) {
      return;
    }

    final trackedChildren = manager.floatingWindows
        .where((window) => window.floatingWindowId?.isNotEmpty == true)
        .toList();

    _logLifecycleEvent(
      'child.cleanup.begin',
      data: {
        'reason': reason,
        'children': trackedChildren
            .map((window) => '${window.id}:${window.floatingWindowId}')
            .join('|'),
      },
    );

    for (final child in trackedChildren) {
      final floatingWindowId = child.floatingWindowId;
      if (floatingWindowId != null && floatingWindowId.isNotEmpty) {
        await _closeTrackedChildWindow(
          floatingWindowId,
          reason: 'parent-$reason',
        );
      }
      manager.closeWindow(child.id);
    }

    _logLifecycleEvent(
      'child.cleanup.end',
      data: {'reason': reason, 'remaining': manager.windows.length},
    );
  }

  Future<void> _closeTrackedChildWindow(
    String floatingWindowId, {
    required String reason,
    Duration delay = Duration.zero,
  }) async {
    try {
      _logLifecycleEvent(
        'child.close.begin',
        data: {'child': floatingWindowId, 'reason': reason, 'delay': delay},
      );
      if (delay > Duration.zero) {
        await Future<void>.delayed(delay);
      }
      await _windowPopOutService.closeSubWindow(floatingWindowId);
      _logLifecycleEvent(
        'child.close.end',
        data: {'child': floatingWindowId, 'reason': reason},
      );
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to close tracked child sub-window.',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  void onWindowClose() {
    _logLifecycleEvent('native.onWindowClose');
    unawaited(_handleCloseRequest());
  }

  @override
  void onWindowMinimize() {
    _logLifecycleEvent('native.onWindowMinimize');
    unawaited(_notifyParent(minimized: true, reason: 'minimize'));
  }

  @override
  void onWindowMaximize() {
    _logLifecycleEvent('native.onWindowMaximize');
    if (!shouldDockSubWindowOnMaximize(
      maximizeDockArmed: _maximizeDockArmed,
      handlingWindowTransition: _handlingWindowTransition,
    )) {
      _logLifecycleEvent('native.onWindowMaximize.ignored');
      return;
    }
    unawaited(_notifyParent(reason: 'maximize'));
  }

  @override
  void onWindowRestore() {
    _logLifecycleEvent('native.onWindowRestore');
  }

  @override
  void onWindowFocus() {
    _logLifecycleEvent('native.onWindowFocus');
  }

  @override
  void onWindowBlur() {
    _logLifecycleEvent('native.onWindowBlur');
  }

  Future<void> _notifyParent({
    bool minimized = false,
    bool closeOnly = false,
    String? reason,
  }) async {
    if (_handlingWindowTransition || _runtime.hostWindowId == null) {
      _logLifecycleEvent(
        'notify-parent.skipped',
        data: {
          'reason': reason,
          'closeOnly': closeOnly,
          'minimized': minimized,
        },
      );
      return;
    }
    _handlingWindowTransition = true;

    try {
      _logLifecycleEvent(
        'notify-parent.begin',
        data: {
          'reason': reason,
          'closeOnly': closeOnly,
          'minimized': minimized,
        },
      );
      await _closeLocalFloatingChildren(
        reason: closeOnly
            ? 'close'
            : (reason ?? (minimized ? 'minimize' : 'dock')),
      );
      if (closeOnly) {
        await _channel.invokeMethod('close-window', {
          'windowId': _runtime.hostWindowId,
        });
      } else {
        await _channel.invokeMethod('dock-window', {
          'windowId': _runtime.hostWindowId,
          'minimized': minimized,
          'reason': reason,
        });
      }
      _logLifecycleEvent(
        'notify-parent.end',
        data: {
          'reason': reason,
          'closeOnly': closeOnly,
          'minimized': minimized,
        },
      );
    } catch (error, stackTrace) {
      _handlingWindowTransition = false;
      _logger.e(
        'Failed to notify host window from sub-window lifecycle event',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> _handleCloseRequest() async {
    if (_handlingWindowTransition) {
      _logLifecycleEvent('close-request.skipped');
      return;
    }
    _handlingWindowTransition = true;

    try {
      _logLifecycleEvent('close-request.begin');
      await _closeLocalFloatingChildren(reason: 'close');
      if (_runtime.hostWindowId != null) {
        await _channel.invokeMethod('close-window', {
          'windowId': _runtime.hostWindowId,
        });
      }
      _logLifecycleEvent('close-request.parent-notified');
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to notify host window about sub-window close request',
        error: error,
        stackTrace: stackTrace,
      );
    } finally {
      await _closeCurrentWindow(reason: 'native-close');
    }
  }

  Future<void> _closeCurrentWindow({required String reason}) async {
    try {
      _logLifecycleEvent(
        'current-window.close.begin',
        data: {'reason': reason},
      );
      final terminationMethod = resolveSubWindowTerminationMethod(
        fromNativeCloseRequest: reason == 'native-close',
      );
      if (_registeredWindowListener) {
        windowManager.removeListener(this);
        _registeredWindowListener = false;
      }
      if (_registeredCloseHandler) {
        await _unregisterWindowControllerHandler();
        _registeredCloseHandler = false;
      }
      await windowManager.setPreventClose(false);
      await Future<void>.delayed(Duration.zero);
      switch (terminationMethod) {
        case SubWindowTerminationMethod.close:
          await windowManager.close();
          break;
        case SubWindowTerminationMethod.destroy:
          await windowManager.destroy();
          break;
      }
      _logLifecycleEvent('current-window.close.end', data: {'reason': reason});
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to close current sub-window after close request',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: widget.page);
  }
}
