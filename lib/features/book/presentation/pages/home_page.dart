import 'package:bookstore_management_system/core/theme/theme_toggle_button.dart';
import 'package:bookstore_management_system/core/presentation/widgets/home_view.dart';
import 'package:bookstore_management_system/core/presentation/widgets/sidebar_widget.dart';
import 'package:bookstore_management_system/features/book/presentation/widgets/product_info_editor_view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Define views corresponding to sidebar indices
  final List<Widget> _views = [
    HomeView(), // Index 0: 回到首页
    Center(child: Text("客户资料视图", style: TextStyle(fontSize: 24))), // Index 1
    Center(child: Text("供应商资料视图", style: TextStyle(fontSize: 24))), // Index 2
    Center(child: Text("出版社资料视图", style: TextStyle(fontSize: 24))), // Index 3
    Center(child: Text("部门资料视图", style: TextStyle(fontSize: 24))), // Index 4
    Center(child: Text("人员资料视图", style: TextStyle(fontSize: 24))), // Index 5
    Center(child: Text("商品分类视图", style: TextStyle(fontSize: 24))), // Index 6
    Center(child: Text("统计分类视图", style: TextStyle(fontSize: 24))), // Index 7
    ProductInfoEditorView(), // Index 8
    Center(child: Text("销售属性视图", style: TextStyle(fontSize: 24))), // Index 9
    Center(child: Text("商品属性视图", style: TextStyle(fontSize: 24))), // Index 10
    Center(
      child: Text("商品资料附加信息视图", style: TextStyle(fontSize: 24)),
    ), // Index 11
    Center(child: Text("公司信息视图", style: TextStyle(fontSize: 24))), // Index 12
    Center(child: Text("购销方式视图", style: TextStyle(fontSize: 24))), // Index 13
    Center(child: Text("会员资料视图", style: TextStyle(fontSize: 24))), // Index 14
    Center(child: Text("会员卡类型视图", style: TextStyle(fontSize: 24))), // Index 15
    Center(child: Text("会员折扣视图", style: TextStyle(fontSize: 24))), // Index 16
    Center(child: Text("会员卡充值视图", style: TextStyle(fontSize: 24))), // Index 17
    Center(
      child: Text("会员生日自动提醒视图", style: TextStyle(fontSize: 24)),
    ), // Index 18
    Center(child: Text("收货单视图", style: TextStyle(fontSize: 24))), // Index 19
    Center(child: Text("退货单视图", style: TextStyle(fontSize: 24))), // Index 20
    Center(child: Text("供应商预付款视图", style: TextStyle(fontSize: 24))), // Index 21
    Center(child: Text("供应商结算单视图", style: TextStyle(fontSize: 24))), // Index 22
    Center(child: Text("销售单视图", style: TextStyle(fontSize: 24))), // Index 23
    Center(child: Text("退货单视图", style: TextStyle(fontSize: 24))), // Index 24
    Center(child: Text("统计分析视图", style: TextStyle(fontSize: 24))), // Index 25
    Center(child: Text("权限管理视图", style: TextStyle(fontSize: 24))), // Index 26
    Center(child: Text("系统管理视图", style: TextStyle(fontSize: 24))), // Index 27
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
                          SizedBox(width: 30),
                          Text(
                            "图书管理系统",
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
                            color: Colors.black.withAlpha(25),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IndexedStack(
                        index: _selectedIndex,
                        children: _views,
                      ),
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
