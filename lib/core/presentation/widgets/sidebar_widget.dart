import 'package:bookstore_management_system/core/presentation/models/nav_item.dart';
import 'package:bookstore_management_system/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class SidebarWidget extends StatefulWidget {
  final Function(int) onItemSelected;
  const SidebarWidget({super.key, required this.onItemSelected});

  @override
  State<SidebarWidget> createState() => _SidebarWidgetState();
}

class _SidebarWidgetState extends State<SidebarWidget> {
  int? _selectedIndex;

  // Structured navigation items
  final List<NavItem> navItems = [
    NavItem(index: 0, title: '回到首页', icon: Icons.home),
    NavItem(
      title: '基础数据',
      icon: Icons.work,
      children: [
        NavItem(index: 1, title: '客户资料'),
        NavItem(index: 2, title: '供应商资料'),
        NavItem(index: 3, title: '出版社资料'),
        NavItem(index: 4, title: '部门资料'),
        NavItem(index: 5, title: '人员资料'),
        NavItem(index: 6, title: '商品分类'),
        NavItem(index: 7, title: '统计分类'),
        NavItem(index: 8, title: '*商品资料'),
        NavItem(index: 9, title: '销售属性'),
        NavItem(index: 10, title: '商品属性'),
        NavItem(index: 11, title: '商品资料附加信息'),
        NavItem(index: 12, title: '公司信息'),
        NavItem(index: 13, title: '购销方式'),
        NavItem(index: 14, title: '会员资料'),
        NavItem(index: 15, title: '会员卡类型'),
        NavItem(index: 16, title: '会员折扣'),
        NavItem(index: 17, title: '会员卡充值'),
        NavItem(index: 18, title: '会员生日自动提醒'),
      ],
    ),
    NavItem(
      title: '订收管理',
      icon: Icons.shop,
      children: [
        NavItem(index: 19, title: '收货单'),
        NavItem(index: 20, title: '退货单'),
        NavItem(index: 21, title: '供应商预付款'),
        NavItem(index: 22, title: '供应商结算单'),
      ],
    ),
    NavItem(
      title: '销售管理',
      icon: Icons.shop,
      children: [
        NavItem(index: 23, title: '销售单'),
        NavItem(index: 24, title: '退货单'),
      ],
    ),
    NavItem(index: 25, title: '统计分析', icon: Icons.bar_chart),
    NavItem(index: 26, title: '权限管理', icon: Icons.group),
    NavItem(index: 27, title: '系统管理', icon: Icons.settings),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      alignment: Alignment.center,
      width: 250,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          Text(
            'HL System',
            style: theme.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const Divider(),
          ...navItems.map((item) {
            if (item.children != null) {
              return ExpansionTile(
                leading:
                    item.icon != null
                        ? Icon(item.icon, color: theme.iconTheme.color)
                        : null,
                title: Text(item.title, style: theme.textTheme.bodyLarge),
                trailing: Icon(
                  Icons.expand_more, // Custom collapse/expand icon
                  color: theme.iconTheme.color,
                ),
                children:
                    item.children!
                        .map(
                          (child) => _buildSubNavItem(
                            child.index!,
                            child.title,
                            icon: child.icon,
                          ),
                        )
                        .toList(),
              );
            } else {
              return _buildNavItem(item.index!, item.title, icon: item.icon);
            }
          }),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String title, {IconData? icon}) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final isSelected = _selectedIndex == index;

    return ListTile(
      leading:
          icon != null
              ? Icon(
                icon,
                color:
                    isSelected
                        ? theme.colorScheme.primary
                        : (isDarkMode ? Colors.white70 : AppPallete.lightBlack),
              )
              : null,
      title: Text(
        title,
        style: TextStyle(
          color:
              isSelected
                  ? theme.colorScheme.primary
                  : (isDarkMode ? Colors.white70 : AppPallete.lightBlack),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 16,
        ),
      ),
      onTap: () {
        setState(() => _selectedIndex = index);
        widget.onItemSelected(index);
      },
      selected: isSelected,
      selectedTileColor: theme.colorScheme.primary.withAlpha(26),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      dense: true,
    );
  }

  Widget _buildSubNavItem(int index, String title, {IconData? icon}) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final isSelected = _selectedIndex == index;

    return ListTile(
      leading:
          icon != null
              ? Icon(
                icon,
                color:
                    isSelected
                        ? theme.colorScheme.primary
                        : (isDarkMode ? Colors.white70 : AppPallete.lightBlack),
              )
              : null,
      title: Text(
        title,
        style: TextStyle(
          color:
              isSelected
                  ? theme.colorScheme.primary
                  : (isDarkMode ? Colors.white70 : AppPallete.lightBlack),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 14,
        ),
      ),
      onTap: () {
        setState(() => _selectedIndex = index);
        widget.onItemSelected(index);
      },
      selected: isSelected,
      selectedTileColor: theme.colorScheme.primary.withAlpha(26),
      contentPadding: const EdgeInsets.only(left: 48, right: 16),
      dense: true,
    );
  }
}
