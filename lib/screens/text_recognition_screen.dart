import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For Clipboard functionality
import 'package:google_ml_kit/google_ml_kit.dart';
import 'pdf_export_screen.dart';

class TextRecognitionScreen extends StatefulWidget {
  final File imageFile;

  const TextRecognitionScreen({super.key, required this.imageFile});

  @override
  _TextRecognitionScreenState createState() => _TextRecognitionScreenState();
}

class _TextRecognitionScreenState extends State<TextRecognitionScreen> {
  String _extractedText = "Extracting text...";
  bool _isProcessing = true;
  bool _isImageVisible = false; // Flag to control image visibility
  bool _isCopied = false; // Flag to manage copied state
  Color _buttonColor = Colors.blueAccent; // Default button color
  String _buttonText = "Copy Text"; // Default button text

  @override
  void initState() {
    super.initState();
    _processImage();
  }

  Future<void> _processImage() async {
    final textRecognizer = GoogleMlKit.vision.textRecognizer();
    final inputImage = InputImage.fromFile(widget.imageFile);

    try {
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);
      String extractedText = recognizedText.text;

      setState(() {
        _extractedText =
            extractedText.isNotEmpty ? extractedText : "No text found";
        _isProcessing = false;
      });
    } catch (e) {
      setState(() {
        _extractedText = "Error: Failed to recognize text";
        _isProcessing = false;
      });
    } finally {
      textRecognizer.close();
    }
  }

  // Copy the extracted text to clipboard and show temporary changes
  Future<void> _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: _extractedText));

    setState(() {
      _isCopied = true;
      _buttonText = "Copied!"; // Change button text to "Copied!"
      _buttonColor = Colors.green; // Change button color to green
    });

    // Reset the text and button color after 3 seconds
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isCopied = false;
      _buttonText = "Copy Text"; // Reset button text to original
      _buttonColor = Colors.blueAccent; // Reset button color
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Extracted Text"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isProcessing
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Show Image Button
                  ElevatedButton.icon(
                    icon: const Icon(Icons.image),
                    label: const Text("Show Image"),
                    onPressed: () {
                      setState(() {
                        _isImageVisible = !_isImageVisible; // Toggle visibility
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.blueAccent,
                      textStyle: const TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Conditionally show the image if button is pressed
                  _isImageVisible
                      ? Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              widget.imageFile,
                              fit: BoxFit.contain,
                              height: 300,
                              width: double.infinity,
                            ),
                          ),
                        )
                      : Container(), // Empty container when image is hidden

                  const SizedBox(height: 20),

                  // Display extracted text
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        _extractedText,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Copy Text Button
                  ElevatedButton.icon(
                    icon: const Icon(Icons.copy),
                    label: Text(_buttonText), // Dynamically change button text
                    onPressed: _copyToClipboard,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: _buttonColor, // Change color dynamically
                      textStyle: const TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Export as PDF button
                  ElevatedButton.icon(
                    icon: const Icon(Icons.picture_as_pdf),
                    label: const Text("Export as PDF"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PdfExportScreen(text: _extractedText),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.blueAccent,
                      textStyle: const TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
