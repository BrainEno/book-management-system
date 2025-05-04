// Define the NavItem class
import 'package:flutter/material.dart';

class NavItem {
  final int? index;
  final String title;
  final IconData? icon;
  final List<NavItem>? children;

  NavItem({this.index, required this.title, this.icon, this.children});
}
