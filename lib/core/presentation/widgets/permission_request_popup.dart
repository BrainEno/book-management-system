import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionRequestPopup extends StatefulWidget {
  final Permission permission;
  final String permissionName;
  final VoidCallback onPermissionGranted;

  const PermissionRequestPopup({
    super.key,
    required this.permission,
    required this.permissionName,
    required this.onPermissionGranted,
  });

  @override
  State<PermissionRequestPopup> createState() => _PermissionRequestPopupState();
}

class _PermissionRequestPopupState extends State<PermissionRequestPopup> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Permission Required'),
      content: Text(
        'This app needs ${widget.permissionName} access to function properly. Please grant the permission.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // Close dialog
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            // Request permission
            final status = await widget.permission.request();
            if (status.isGranted) {
              widget.onPermissionGranted(); // Call callback if granted
              if (context.mounted) {
                Navigator.of(context).pop();
              } // Close dialog
            } else if (status.isPermanentlyDenied) {
              // Open app settings if permanently denied
              await openAppSettings();
            }
          },
          child: Text('Grant Permission'),
        ),
      ],
    );
  }
}
