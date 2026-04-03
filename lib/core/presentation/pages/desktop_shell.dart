import 'package:bookstore_management_system/app/navigation/app_window_destination.dart';
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

      _openDestination(windowManager, appWindowDestinations.first);
    });
  }

  @override
  Widget build(BuildContext context) {
    final windowManager = context.watch<AppWindowManager>();
    final activeWindow = windowManager.activeWindow;
    final activeIndex = _indexForPageKey(activeWindow?.popOutPageKey);
    final selectedIndex = activeIndex ?? _selectedIndex;

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
              _openDestination(windowManager, appWindowDestinations[index]);
            },
            labelType: NavigationRailLabelType.all,
            destinations: [
              for (final destination in appWindowDestinations)
                NavigationRailDestination(
                  icon: Icon(destination.icon),
                  label: Text(destination.label),
                ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    if (activeWindow != null)
                      Column(
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
                    else
                      const Center(child: Text('Select an item from the menu')),
                    if (windowManager.minimizedWindows.isNotEmpty)
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            boxShadow: const [
                              BoxShadow(blurRadius: 8, spreadRadius: -4),
                            ],
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(8),
                            ),
                          ),
                          child: Row(
                            children: windowManager.minimizedWindows.map((
                              window,
                            ) {
                              return InkWell(
                                onTap: () => windowManager
                                    .restoreMinimizedWindow(window.id),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  child: Text(window.title),
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
        ],
      ),
    );
  }
}

void _openDestination(
  AppWindowManager windowManager,
  AppWindowDestination destination,
) {
  windowManager.openOrFocusWindow(
    title: destination.title,
    content: destination.builder(const AppWindowPayload()),
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
  floatWindow(
    context: context,
    windowInfo: windowInfo,
    availableSize: Size(constraints.maxWidth, constraints.maxHeight),
  );
}

class _CustomTitleBar extends StatelessWidget {
  const _CustomTitleBar({required this.windowInfo, required this.onFloat});

  final WindowInfo windowInfo;
  final VoidCallback onFloat;

  @override
  Widget build(BuildContext context) {
    final windowManager = context.read<AppWindowManager>();

    return Container(
      height: 32,
      color: Colors.blue.shade100,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              windowInfo.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.open_in_new, size: 16),
            tooltip: 'Float Window',
            onPressed: () {
              onFloat();
              windowManager.floatActiveWindow();
            },
          ),
          IconButton(
            icon: const Icon(Icons.minimize, size: 16),
            tooltip: 'Minimize',
            onPressed: () => windowManager.minimizeActiveWindow(),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 16),
            tooltip: 'Close',
            onPressed: () => windowManager.closeActiveWindow(),
          ),
        ],
      ),
    );
  }
}
