import 'package:permission_handler/permission_handler.dart';

// Function to request camera and storage permissions
Future<void> requestPermissions() async {
  // Request camera permission
  final cameraStatus = await Permission.camera.request();
  if (cameraStatus.isDenied) {
    // If the user denies the permission, show a message or open app settings
    throw Exception('Camera permission is required to capture images.');
  }

  // Request storage permission
  final storageStatus = await Permission.storage.request();
  if (storageStatus.isDenied) {
    // If the user denies the permission, show a message or open app settings
    throw Exception('Storage permission is required to access images.');
  }

  // Optional: Request manage external storage permission (for Android 11+)
  if (await Permission.manageExternalStorage.isDenied) {
    await Permission.manageExternalStorage.request();
  }
}
