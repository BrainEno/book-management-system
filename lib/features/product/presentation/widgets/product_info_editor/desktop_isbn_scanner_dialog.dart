import 'dart:io';

import 'package:bookstore_management_system/features/product/presentation/widgets/product_info_editor/desktop_isbn_scanner_macos_dialog.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_info_editor/desktop_isbn_scanner_windows_dialog.dart';
import 'package:flutter/material.dart';

class DesktopIsbnScannerDialog extends StatelessWidget {
  const DesktopIsbnScannerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isMacOS) {
      return const MacOsDesktopIsbnScannerDialog();
    }
    if (Platform.isWindows) {
      return const WindowsDesktopIsbnScannerDialog();
    }
    return const Dialog(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text('当前平台暂不支持桌面摄像头扫码'),
      ),
    );
  }
}
