import 'dart:convert';
import 'package:bookstore_management_system/core/window/window_info.dart';
import 'package:bookstore_management_system/core/window/app_window_manager.dart';
import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:bookstore_management_system/features/product/presentation/blocs/product_bloc.dart';
import 'package:bookstore_management_system/inventory/presentation/pages/inventory_page.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:bookstore_management_system/features/product/presentation/pages/product_page.dart';

class DesktopShell extends StatefulWidget {
  const DesktopShell({super.key});

  @override
  State<DesktopShell> createState() => _DesktopShellState();
}

class _DesktopShellState extends State<DesktopShell> {
  int _selectedIndex = 0; // Local state for selected index

  @override
  void initState() {
    super.initState();
    // Open the default product window once after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final windowManager = context.read<AppWindowManager>();
      // Only open if there is no active window yet
      if (windowManager.activeWindow == null) {
        windowManager.openOrFocusWindow(
          title: '商品资料',
          content: const ProductPage(),
          popOutPageKey: 'product',
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final windowManager = context.watch<AppWindowManager>();
    final activeWindow = windowManager.activeWindow;

    // Update selectedIndex based on activeWindow
    if (activeWindow?.popOutPageKey == 'inventory') {
      _selectedIndex = 1;
    } else if (activeWindow?.popOutPageKey == 'product') {
      _selectedIndex = 0;
    }

    return Scaffold(
      body: Row(
        children: [
          // Left Navigation Rail
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
              if (index == 0) {
                windowManager.openOrFocusWindow(
                  title: '商品资料',
                  content: const ProductPage(),
                  popOutPageKey: 'product',
                );
              } else if (index == 1) {
                windowManager.openOrFocusWindow(
                  title: '库存',
                  content: const InventoryPage(),
                  popOutPageKey: 'inventory',
                );
              }
            },
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.shopping_bag_outlined),
                label: Text('商品资料'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.inventory_2_outlined),
                label: Text('库存'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // Main Content Area
          Expanded(
            child: LayoutBuilder(
              // We use LayoutBuilder to get the size for the float window
              builder: (context, constraints) {
                return Stack(
                  children: [
                    // The main docked view
                    if (activeWindow != null)
                      Column(
                        children: [
                          _CustomTitleBar(
                            windowInfo: activeWindow,
                            // Pass the available size to the float function
                            onFloat:
                                () => _floatWindow(
                                  context,
                                  activeWindow,
                                  constraints,
                                ),
                          ),
                          Expanded(child: activeWindow.content),
                        ],
                      )
                    else // Show a placeholder if no window is active
                      const Center(child: Text("Select an item from the menu")),

                    // Minimized windows bar at the bottom-left
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
                            children:
                                windowManager.minimizedWindows.map((w) {
                                  return InkWell(
                                    onTap:
                                        () => windowManager
                                            .restoreMinimizedWindow(w.id),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                        vertical: 4.0,
                                      ),
                                      child: Text(w.title),
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

// Helper function to create the new window
void _floatWindow(
  BuildContext context,
  WindowInfo windowInfo,
  BoxConstraints constraints,
) async {
  final productBloc = context.read<ProductBloc>();
  final currentState = productBloc.state;
  Map<String, dynamic> windowState = {};

  if (currentState is ProductsLoaded) {
    // Assuming ProductFetchSuccess has a list of products
    // And your Product entity has a toJson() method
    windowState = {
      'products':
          currentState.products
              .map((p) => (p as ProductModel).toJson())
              .toList(),
    };
  }
  // This is where we define the arguments for the new window
  final arguments = {
    'page': windowInfo.popOutPageKey,
    'title': windowInfo.title,
    'width': constraints.maxWidth, // Pass current width
    'height': constraints.maxHeight, // Pass current height
    'state': jsonEncode(windowState),
  };

  // Create the OS window
  final controller = await WindowController.create(
    WindowConfiguration(arguments: jsonEncode(arguments)),
  );
  await controller.show();
}

// A new private widget for the title bar of the docked view
class _CustomTitleBar extends StatelessWidget {
  final WindowInfo windowInfo;
  final VoidCallback onFloat;

  const _CustomTitleBar({required this.windowInfo, required this.onFloat});

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
              // 1. Call the onFloat callback which creates the OS window
              onFloat();
              // 2. Tell the state manager to close the internal version
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
