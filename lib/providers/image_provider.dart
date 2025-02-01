import 'dart:io';
import 'package:flutter/material.dart';

class ImageProviderClass with ChangeNotifier {
  File? _selectedImage;

  File? get selectedImage => _selectedImage;

  void setImage(File image) {
    _selectedImage = image;
    notifyListeners(); // Notify listeners when the image changes
  }

  void clearImage() {
    _selectedImage = null;
    notifyListeners();
  }
}
