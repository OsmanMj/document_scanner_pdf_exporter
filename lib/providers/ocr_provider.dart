import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class OcrProvider with ChangeNotifier {
  String _extractedText = "";
  bool _isProcessing = false;

  String get extractedText => _extractedText;
  bool get isProcessing => _isProcessing;

  Future<void> processImageForText(InputImage inputImage) async {
    _isProcessing = true;
    notifyListeners();

    final textRecognizer = GoogleMlKit.vision.textRecognizer();
    try {
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);
      _extractedText = recognizedText.text;
    } catch (e) {
      _extractedText = "Error: Failed to recognize text";
    } finally {
      _isProcessing = false;
      textRecognizer.close();
      notifyListeners();
    }
  }
}
