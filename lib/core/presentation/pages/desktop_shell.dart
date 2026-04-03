import 'package:bookstore_management_system/app/navigation/app_window_destination.dart';
import 'package:bookstore_management_system/core/theme/app_pallete.dart';
import 'package:bookstore_management_system/core/window/app_window_manager.dart';
import 'package:bookstore_management_system/core/window/window_info.dart';
import 'package:bookstore_management_system/core/window/window_pop_out_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DesktopShell extends StatefulWidget {
  const DesktopShell({super.key});

  @override
  State<DesktopShell> createState() => _DesktopShellState();
}

class _DesktopShellState extends State<DesktopShell> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final windowManager = context.read<AppWindowManager>();
      if (windowManager.activeWindow != null || appWindowDestinations.isEmpty) {
        return;
      }

      _openDestination(context, windowManager, appWindowDestinations.first);
    });
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
                    return Stack(
                      children: [
                        Container(
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
                            child: activeWindow != null
                                ? Column(
                                    children: [
                                      _CustomTitleBar(
                                        windowInfo: activeWindow,
                                        onFloat: () => _floatWindow(
                                          context,
                                          activeWindow,
                                          constraints,
                                        ),
                                      ),
                                      Expanded(child: activeWindow.content),
                                    ],
                                  )
                                : const _EmptyShellState(),
                          ),
                        ),
                        if (windowManager.minimizedWindows.isNotEmpty)
                          Positioned(
                            left: 18,
                            bottom: 18,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: AppPallete.paperElevated,
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppPallete.cardShadow,
                                    blurRadius: 16,
                                    offset: Offset(0, 10),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: AppPallete.paperBorder,
                                ),
                              ),
                              child: Row(
                                children: windowManager.minimizedWindows.map((
                                  window,
                                ) {
                                  return InkWell(
                                    onTap: () => windowManager
                                        .restoreMinimizedWindow(window.id),
                                    borderRadius: BorderRadius.circular(14),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      child: Text(
                                        window.title,
                                        style: const TextStyle(
                                          color: AppPallete.ink,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
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
}

void _openDestination(
  BuildContext context,
  AppWindowManager windowManager,
  AppWindowDestination destination,
) {
  windowManager.openOrFocusWindow(
    title: destination.title,
    content: destination.builder(context, const AppWindowPayload()),
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

void _floatWindow(
  BuildContext context,
  WindowInfo windowInfo,
  BoxConstraints constraints,
) {
  floatWindow(context: context, windowInfo: windowInfo);
}

class _CustomTitleBar extends StatelessWidget {
  const _CustomTitleBar({required this.windowInfo, required this.onFloat});

  final WindowInfo windowInfo;
  final VoidCallback onFloat;

  @override
  Widget build(BuildContext context) {
    final windowManager = context.read<AppWindowManager>();

    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: const BoxDecoration(
        color: Color(0xFFF8F1E7),
        border: Border(bottom: BorderSide(color: AppPallete.paperBorder)),
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
            tooltip: 'Float Window',
            onPressed: () {
              onFloat();
              windowManager.floatActiveWindow();
            },
          ),
          IconButton(
            icon: const Icon(Icons.minimize, size: 16),
            color: AppPallete.ink,
            tooltip: 'Minimize',
            onPressed: () => windowManager.minimizeActiveWindow(),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 16),
            color: AppPallete.ink,
            tooltip: 'Close',
            onPressed: () => windowManager.closeActiveWindow(),
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
              '主控台会作为默认首开页，商品资料和库存模块可以从左侧导航随时切换。',
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
