import 'dart:io';
import 'package:image/image.dart' as img;

class ImageUtils {
  // Resize an image to the specified width and height
  Future<File> resizeImage(File imageFile, int width, int height) async {
    try {
      // Read image from file
      final image = img.decodeImage(await imageFile.readAsBytes());

      if (image == null) {
        throw Exception('Failed to decode the image.');
      }

      // Resize image
      final resizedImage = img.copyResize(image, width: width, height: height);

      // Write resized image back to the file
      final resizedFile =
          await imageFile.writeAsBytes(img.encodeJpg(resizedImage));
      return resizedFile;
    } catch (e) {
      rethrow;
    }
  }

  // Crop an image to a rectangular region
  Future<File> cropImage(File imageFile,
      {required int x,
      required int y,
      required int width,
      required int height}) async {
    try {
      // Read image from file
      final image = img.decodeImage(await imageFile.readAsBytes());

      if (image == null) {
        throw Exception('Failed to decode the image.');
      }

      // Crop image using named parameters
      final croppedImage =
          img.copyCrop(image, x: x, y: y, width: width, height: height);

      // Write cropped image back to the file
      final croppedFile =
          await imageFile.writeAsBytes(img.encodeJpg(croppedImage));
      return croppedFile;
    } catch (e) {
      rethrow;
    }
  }
}
