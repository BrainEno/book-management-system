import 'dart:async';

import 'package:bookstore_management_system/app/navigation/app_window_destination.dart';
import 'package:bookstore_management_system/core/common/logger/app_logger.dart';
import 'package:bookstore_management_system/core/theme/app_pallete.dart';
import 'package:bookstore_management_system/core/window/app_window_manager.dart';
import 'package:bookstore_management_system/core/window/current_app_window.dart';
import 'package:bookstore_management_system/core/window/main_window_presentation_controller.dart';
import 'package:bookstore_management_system/core/window/sub_window_docking_policy.dart';
import 'package:bookstore_management_system/core/window/window_layout_policy.dart';
import 'package:bookstore_management_system/core/window/sub_window_launch_data.dart';
import 'package:bookstore_management_system/core/window/window_info.dart';
import 'package:bookstore_management_system/core/window/window_pop_out_service.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

class DesktopShell extends StatefulWidget {
  const DesktopShell({
    super.key,
    this.windowPopOutService = const DesktopWindowPopOutService(),
  });

  final WindowPopOutService windowPopOutService;

  @override
  State<DesktopShell> createState() => _DesktopShellState();
}

class _DesktopShellState extends State<DesktopShell> with WindowListener {
  static const _workspacePadding = 12.0;
  static const _minWindowWidth = 540.0;
  static const _minWindowHeight = 320.0;

  final GlobalKey _workspaceKey = GlobalKey();
  final MainWindowPresentationController _mainWindowPresentationController =
      const MainWindowPresentationController(
        WindowManagerPresentationOperations(),
      );
  final WindowMethodChannel _subWindowEvents = const WindowMethodChannel(
    'bookstore_sub_window_events',
    mode: ChannelMode.unidirectional,
  );
  final _logger = AppLogger.logger;
  int _selectedIndex = 0;
  int _subWindowEventSequence = 0;

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    unawaited(_subWindowEvents.setMethodCallHandler(_handleSubWindowEvent));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_mainWindowPresentationController.applyInitialPresentation());

      final windowManager = context.read<AppWindowManager>();
      if (windowManager.windows.isNotEmpty || appWindowDestinations.isEmpty) {
        return;
      }

      _openDestination(context, windowManager, appWindowDestinations.first);
    });
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    unawaited(_subWindowEvents.setMethodCallHandler(null));
    super.dispose();
  }

  void _logSubWindowEvent(
    String phase, {
    Map<String, Object?> data = const {},
  }) {
    final manager = context.read<AppWindowManager>();
    final sequence = ++_subWindowEventSequence;
    final tracked = manager.windows
        .map(
          (window) =>
              '${window.id}:${window.popOutPageKey}:${window.displayMode.name}:${window.floatingWindowId ?? '-'}',
        )
        .join(', ');
    final payload = <String, Object?>{
      'seq': sequence,
      'phase': phase,
      'tracked': tracked,
      ...data,
    };
    _logger.i(
      'Desktop shell sub-window event: ${payload.entries.map((entry) => '${entry.key}=${entry.value}').join(', ')}',
    );
  }

  @override
  void onWindowUnmaximize() {
    unawaited(_mainWindowPresentationController.restoreToCenteredWindowed());
  }

  @override
  Widget build(BuildContext context) {
    final windowManager = context.watch<AppWindowManager>();
    final activeWindow = windowManager.activeWindow;
    final activeIndex = _indexForPageKey(activeWindow?.popOutPageKey);
    final selectedIndex = activeIndex ?? _selectedIndex;

    return Scaffold(
      backgroundColor: AppPallete.paper,
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppPallete.paper,
              AppPallete.paperElevated,
              const Color(0xFFF2E6D7),
            ],
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 124,
              padding: const EdgeInsets.fromLTRB(14, 18, 14, 18),
              decoration: const BoxDecoration(
                color: Color(0xFFF8F1E7),
                border: Border(
                  right: BorderSide(color: AppPallete.paperBorder),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.82),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: AppPallete.paperBorder),
                    ),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.local_library_outlined,
                          color: AppPallete.forestDeep,
                        ),
                        SizedBox(height: 10),
                        Text(
                          '溪川书店',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppPallete.ink,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Expanded(
                    child: NavigationRail(
                      backgroundColor: Colors.transparent,
                      selectedIndex: selectedIndex,
                      onDestinationSelected: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                        _openDestination(
                          context,
                          windowManager,
                          appWindowDestinations[index],
                        );
                      },
                      labelType: NavigationRailLabelType.all,
                      minWidth: 92,
                      selectedLabelTextStyle: const TextStyle(
                        color: AppPallete.forestDeep,
                        fontWeight: FontWeight.w700,
                      ),
                      unselectedLabelTextStyle: const TextStyle(
                        color: AppPallete.mutedInk,
                      ),
                      useIndicator: true,
                      indicatorColor: AppPallete.copperSoft,
                      destinations: [
                        for (final destination in appWindowDestinations)
                          NavigationRailDestination(
                            icon: Icon(destination.icon),
                            selectedIcon: Icon(
                              destination.icon,
                              color: AppPallete.forestDeep,
                            ),
                            label: Text(destination.label),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final embeddedWindows = windowManager.embeddedWindows
                        .map(
                          (window) => _fitWindowToWorkspace(
                            window,
                            constraints.biggest,
                          ),
                        )
                        .toList();

                    return Stack(
                      children: [
                        Container(
                          key: _workspaceKey,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.36),
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(
                              color: AppPallete.paperBorder.withValues(
                                alpha: 0.85,
                              ),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(28),
                            child: embeddedWindows.isEmpty
                                ? const _EmptyShellState()
                                : Stack(
                                    children: [
                                      for (final windowInfo in embeddedWindows)
                                        _EmbeddedWindowPanel(
                                          windowInfo: windowInfo,
                                          onFocus: () => context
                                              .read<AppWindowManager>()
                                              .focusWindow(windowInfo.id),
                                          onFloat: () =>
                                              _floatWindow(context, windowInfo),
                                          onMinimize: () => context
                                              .read<AppWindowManager>()
                                              .minimizeWindow(windowInfo.id),
                                          onClose: () => context
                                              .read<AppWindowManager>()
                                              .closeWindow(windowInfo.id),
                                        ),
                                    ],
                                  ),
                          ),
                        ),
                        if (windowManager.minimizedWindows.isNotEmpty)
                          Positioned(
                            left: 18,
                            bottom: 18,
                            right: 18,
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Wrap(
                                spacing: 12,
                                runSpacing: 12,
                                children: [
                                  for (final window
                                      in windowManager.minimizedWindows)
                                    _MinimizedWindowCard(
                                      windowInfo: window,
                                      onRestore: () => windowManager
                                          .restoreMinimizedWindow(window.id),
                                      onClose: () =>
                                          windowManager.closeWindow(window.id),
                                    ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  WindowInfo _fitWindowToWorkspace(WindowInfo windowInfo, Size workspaceSize) {
    final fittedBounds = resolveEmbeddedWindowBounds(
      requestedBounds: windowInfo.bounds,
      workspaceSize: workspaceSize,
      minWindowWidth: _minWindowWidth,
      minWindowHeight: _minWindowHeight,
      workspacePadding: _workspacePadding,
    );
    return fittedBounds == windowInfo.bounds
        ? windowInfo
        : windowInfo.copyWith(bounds: fittedBounds);
  }

  Future<void> _floatWindow(BuildContext context, WindowInfo windowInfo) async {
    final renderBox =
        _workspaceKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) {
      return;
    }

    final workspaceOrigin = renderBox.localToGlobal(Offset.zero);
    final globalBounds = Rect.fromLTWH(
      workspaceOrigin.dx + windowInfo.bounds.left,
      workspaceOrigin.dy + windowInfo.bounds.top,
      windowInfo.bounds.width,
      windowInfo.bounds.height,
    );

    try {
      final launchData = createLaunchDataForWindow(
        context: context,
        windowInfo: windowInfo,
        globalBounds: globalBounds,
      );
      final floatingWindowId = await widget.windowPopOutService.openSubWindow(
        launchData,
      );
      if (!context.mounted) {
        return;
      }

      context.read<AppWindowManager>().markWindowFloating(
        windowInfo.id,
        floatingWindowId: floatingWindowId,
      );
    } catch (error) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('打开浮动窗口失败：$error')));
    }
  }

  Future<dynamic> _handleSubWindowEvent(MethodCall call) async {
    final arguments = call.arguments;
    if (arguments is! Map) {
      return null;
    }

    final payload = Map<String, dynamic>.from(arguments);
    final windowId = payload['windowId'] as String?;
    if (windowId == null || windowId.isEmpty) {
      return null;
    }

    final windowManager = context.read<AppWindowManager>();
    _logSubWindowEvent(
      'received',
      data: {'method': call.method, 'windowId': windowId, 'payload': payload},
    );

    switch (call.method) {
      case 'dock-window':
        final dockedWindow = windowManager.windowById(windowId);
        final floatingWindowId = dockedWindow?.floatingWindowId;
        final minimized = payload['minimized'] == true;
        final dockReason = payload['reason']?.toString();
        _logSubWindowEvent(
          'dock.begin',
          data: {
            'windowId': windowId,
            'floatingChild': floatingWindowId,
            'minimized': minimized,
            'reason': dockReason,
          },
        );
        if (floatingWindowId != null && floatingWindowId.isNotEmpty) {
          final childDisposition = resolveFloatingChildDisposition(
            minimized: minimized,
            reason: dockReason,
          );
          if (childDisposition == FloatingChildDisposition.close) {
            widget.windowPopOutService.trackClosingWindow(floatingWindowId);
            unawaited(
              _closeFloatingWindowSafely(
                floatingWindowId,
                delay: resolveSubWindowHideDelay(dockReason),
              ),
            );
          } else {
            unawaited(
              _hideFloatingWindowSafely(
                floatingWindowId,
                delay: resolveSubWindowHideDelay(dockReason),
              ),
            );
          }
        }
        final rawBounds = payload['bounds'];
        final globalBounds = rawBounds is Map
            ? SubWindowBounds.fromJson(
                Map<String, dynamic>.from(rawBounds),
              ).toRect()
            : null;
        final localBounds = resolveDockedWindowBounds(
          storedHostBounds: dockedWindow?.bounds ?? Rect.zero,
          reportedSubWindowBounds: globalBounds == null
              ? null
              : _globalRectToWorkspace(globalBounds),
          minimized: minimized,
          reason: dockReason,
        );
        windowManager.dockWindow(
          windowId,
          bounds: localBounds,
          minimized: minimized,
        );
        _logSubWindowEvent(
          'dock.end',
          data: {
            'windowId': windowId,
            'minimized': minimized,
            'reason': dockReason,
            'bounds': localBounds,
          },
        );
        break;
      case 'close-window':
        final closingWindow = windowManager.windowById(windowId);
        _logSubWindowEvent(
          'close.begin',
          data: {
            'windowId': windowId,
            'floatingChild': closingWindow?.floatingWindowId,
          },
        );
        final floatingWindowId = closingWindow?.floatingWindowId;
        if (floatingWindowId != null && floatingWindowId.isNotEmpty) {
          widget.windowPopOutService.trackClosingWindow(floatingWindowId);
        }
        if (shouldHostCloseFloatingChildFromCloseRequest()) {
          if (floatingWindowId != null && floatingWindowId.isNotEmpty) {
            unawaited(_closeFloatingWindowSafely(floatingWindowId));
          }
        }
        windowManager.closeWindow(windowId);
        _logSubWindowEvent('close.end', data: {'windowId': windowId});
        break;
    }

    return null;
  }

  Rect _globalRectToWorkspace(Rect globalRect) {
    final renderBox =
        _workspaceKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) {
      return globalRect;
    }

    final workspaceOrigin = renderBox.localToGlobal(Offset.zero);
    return Rect.fromLTWH(
      globalRect.left - workspaceOrigin.dx,
      globalRect.top - workspaceOrigin.dy,
      globalRect.width,
      globalRect.height,
    );
  }

  Future<void> _hideFloatingWindowSafely(
    String floatingWindowId, {
    Duration delay = Duration.zero,
  }) async {
    try {
      if (delay > Duration.zero) {
        await Future<void>.delayed(delay);
      }
      await widget.windowPopOutService.hideSubWindow(floatingWindowId);
    } catch (_) {
      // Best effort.
    }
  }

  Future<void> _closeFloatingWindowSafely(
    String floatingWindowId, {
    Duration delay = Duration.zero,
  }) async {
    try {
      if (delay > Duration.zero) {
        await Future<void>.delayed(delay);
      }
      await widget.windowPopOutService.closeSubWindow(floatingWindowId);
    } catch (_) {
      // Best effort.
    }
  }
}

void _openDestination(
  BuildContext context,
  AppWindowManager windowManager,
  AppWindowDestination destination,
) {
  windowManager.openWindow(
    title: destination.title,
    popOutPageKey: destination.pageKey,
  );
}

int? _indexForPageKey(String? pageKey) {
  if (pageKey == null) {
    return null;
  }

  for (var index = 0; index < appWindowDestinations.length; index++) {
    if (appWindowDestinations[index].pageKey == pageKey) {
      return index;
    }
  }

  return null;
}

class _EmbeddedWindowPanel extends StatelessWidget {
  const _EmbeddedWindowPanel({
    required this.windowInfo,
    required this.onFocus,
    required this.onFloat,
    required this.onMinimize,
    required this.onClose,
  });

  final WindowInfo windowInfo;
  final VoidCallback onFocus;
  final VoidCallback onFloat;
  final VoidCallback onMinimize;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final destination =
        findAppWindowDestination(windowInfo.popOutPageKey) ??
        findFloatingWindowDestination(windowInfo.popOutPageKey);

    return Positioned(
      left: windowInfo.bounds.left,
      top: windowInfo.bounds.top,
      width: windowInfo.bounds.width,
      height: windowInfo.bounds.height,
      child: GestureDetector(
        onTap: onFocus,
        child: Material(
          elevation: 10,
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppPallete.paperBorder),
              boxShadow: const [
                BoxShadow(
                  color: AppPallete.cardShadow,
                  blurRadius: 18,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Column(
                children: [
                  Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF8F1E7),
                      border: Border(
                        bottom: BorderSide(color: AppPallete.paperBorder),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 9,
                          height: 9,
                          decoration: const BoxDecoration(
                            color: AppPallete.copper,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            windowInfo.title,
                            style: const TextStyle(
                              color: AppPallete.ink,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.open_in_new, size: 16),
                          color: AppPallete.ink,
                          tooltip: '浮动',
                          onPressed: onFloat,
                        ),
                        IconButton(
                          icon: const Icon(Icons.minimize, size: 16),
                          color: AppPallete.ink,
                          tooltip: '最小化',
                          onPressed: onMinimize,
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, size: 16),
                          color: AppPallete.ink,
                          tooltip: '关闭',
                          onPressed: onClose,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: destination == null
                        ? Center(
                            child: Text("无法解析页面 ${windowInfo.popOutPageKey}"),
                          )
                        : Provider<CurrentAppWindow>.value(
                            value: CurrentAppWindow(windowId: windowInfo.id),
                            child: destination.builder(
                              context,
                              windowInfo.payload,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MinimizedWindowCard extends StatelessWidget {
  const _MinimizedWindowCard({
    required this.windowInfo,
    required this.onRestore,
    required this.onClose,
  });

  final WindowInfo windowInfo;
  final VoidCallback onRestore;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.fromLTRB(14, 12, 10, 10),
      decoration: BoxDecoration(
        color: AppPallete.paperElevated,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppPallete.paperBorder),
        boxShadow: const [
          BoxShadow(
            color: AppPallete.cardShadow,
            blurRadius: 16,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: AppPallete.copper,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  windowInfo.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppPallete.ink,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '已最小化',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppPallete.mutedInk,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onRestore,
                  icon: const Icon(Icons.open_in_full, size: 16),
                  label: const Text('放大'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: onClose,
                tooltip: '关闭',
                icon: const Icon(Icons.close, size: 18),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white.withValues(alpha: 0.9),
                  foregroundColor: AppPallete.ink,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmptyShellState extends StatelessWidget {
  const _EmptyShellState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                color: AppPallete.copperSoft,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.dashboard_customize_outlined,
                size: 38,
                color: AppPallete.forestDeep,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              '选择一个业务模块开始工作',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppPallete.ink,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '主控台默认首开，后续打开的页面会以内嵌子窗口形式保留在工作区中，也支持浮动与最小化。',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppPallete.mutedInk),
            ),
          ],
        ),
      ),
    );
  }
}
