import 'package:bookstore_management_system/core/theme/theme_toggle_button.dart';
import 'package:bookstore_management_system/features/book/presentation/widgets/sidebar_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Define placeholder views for each sidebar item
  final List<Widget> _views = [
    Center(child: Text("首页视图", style: TextStyle(fontSize: 24))),
    Center(child: Text("销售单视图", style: TextStyle(fontSize: 24))),
    Center(child: Text("退货单视图", style: TextStyle(fontSize: 24))),
    Center(child: Text("图书信息视图", style: TextStyle(fontSize: 24))),
    Center(child: Text("供应商视图", style: TextStyle(fontSize: 24))),
    Center(child: Text("订收管理视图", style: TextStyle(fontSize: 24))),
    Center(child: Text("统计分析视图", style: TextStyle(fontSize: 24))),
    Center(child: Text("权限管理视图", style: TextStyle(fontSize: 24))),
    Center(child: Text("系统管理视图", style: TextStyle(fontSize: 24))),
  ];

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SidebarWidget(onItemSelected: _onItemSelected),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 700),
                          Text(
                            "湖蓝图书管理系统",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(
                                    context,
                                  ).textTheme.headlineMedium?.color,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          ThemeToggleButton(),
                          IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {},
                            tooltip: "搜索",
                          ),
                          IconButton(
                            icon: Icon(Icons.notifications),
                            onPressed: () {},
                            tooltip: "通知",
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: _views[_selectedIndex],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
