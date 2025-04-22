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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      width: 200,
      color:
          isDarkMode ? AppPallete.darkBackground : AppPallete.lightBackground,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 20),
        children: [
          _buildNavItem(0, "回到首页", Icons.home),
          ExpansionTile(
            leading: Icon(
              Icons.shop,
              color: isDarkMode ? Colors.white70 : AppPallete.lightBlack,
            ),
            title: Text(
              "销售管理",
              style: TextStyle(
                color: isDarkMode ? Colors.white70 : AppPallete.lightBlack,
              ),
            ),
            children: [_buildSubNavItem(1, "销售单"), _buildSubNavItem(2, "退货单")],
          ),
          ExpansionTile(
            leading: Icon(
              Icons.work,
              color: isDarkMode ? Colors.white70 : AppPallete.lightBlack,
            ),
            title: Text(
              "基础数据",
              style: TextStyle(
                color: isDarkMode ? Colors.white70 : AppPallete.lightBlack,
              ),
            ),
            children: [_buildSubNavItem(3, "图书信息"), _buildSubNavItem(4, "供应商")],
          ),
          _buildNavItem(5, "订收管理", Icons.person),
          _buildNavItem(6, "统计分析", Icons.bar_chart),
          _buildNavItem(7, "权限管理", Icons.group),
          _buildNavItem(8, "系统管理", Icons.settings),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String title, IconData icon) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final isSelected = _selectedIndex == index;

    return ListTile(
      leading: Icon(
        icon,
        color:
            isSelected
                ? theme.colorScheme.primary
                : (isDarkMode ? Colors.white70 : AppPallete.lightBlack),
      ),
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
      selectedTileColor: theme.colorScheme.primary.withOpacity(0.1),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      dense: true,
    );
  }

  Widget _buildSubNavItem(int index, String title) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final isSelected = _selectedIndex == index;

    return ListTile(
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
      selectedTileColor: theme.colorScheme.primary.withOpacity(0.1),
      contentPadding: EdgeInsets.only(left: 48, right: 16),
      dense: true,
    );
  }
}
