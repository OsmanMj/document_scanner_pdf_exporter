import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileManager {
  // Get the application's document directory
  Future<Directory> getApplicationDirectory() async {
    return await getApplicationDocumentsDirectory();
  }

  // Save a file to the app's document directory
  Future<File> saveFile(String fileName, List<int> bytes) async {
    final directory = await getApplicationDirectory();
    final filePath = '${directory.path}/$fileName';
    final file = File(filePath);
    return file.writeAsBytes(bytes);
  }

  // Get the path of a file
  Future<String> getFilePath(String fileName) async {
    final directory = await getApplicationDirectory();
    return '${directory.path}/$fileName';
  }

  // Delete a file
  Future<void> deleteFile(String fileName) async {
    final file = File(await getFilePath(fileName));
    if (await file.exists()) {
      await file.delete();
    }
  }
}
