import 'package:bookstore_management_system/core/common/logger/app_logger.dart';
import 'package:bookstore_management_system/core/presentation/widgets/permission_request_popup.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void showPermissionPopup(BuildContext context, Permission permission) {
  if (context.mounted) {
    showDialog(
      context: context,
      builder:
          (context) => PermissionRequestPopup(
            permission: permission,
            permissionName: permission.toString(),
            onPermissionGranted: () {
              AppLogger.logger.i('permission ${permission.toString()} granted');
            },
          ),
    );
  }
}
