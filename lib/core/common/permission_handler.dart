import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  // Check if a permission is granted
  Future<bool> isPermissionGranted(Permission permission) async {
    return await permission.status.isGranted;
  }

  // Request a permission
  Future<PermissionStatus> requestPermission(Permission permission) async {
    return await permission.request();
  }
}
