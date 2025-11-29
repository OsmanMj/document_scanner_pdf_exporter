import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For Clipboard functionality
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
  Color? _buttonColor; // Default button color (null means use theme)
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

    if (mounted) {
      setState(() {
        _isCopied = false;
        _buttonText = "Copy Text"; // Reset button text to original
        _buttonColor = null; // Reset button color to theme default
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Extracted Text"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _isProcessing
            ? Center(
                child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Show/Delete Image Button
                  ElevatedButton.icon(
                    icon: Icon(_isImageVisible ? Icons.delete : Icons.image),
                    label: Text(_isImageVisible ? "Hide Image" : "Show Image"),
                    onPressed: () {
                      setState(() {
                        _isImageVisible = !_isImageVisible; // Toggle visibility
                      });
                    },
                    style: _isImageVisible
                        ? ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                          )
                        : null,
                  ).animate().fadeIn(duration: 400.ms),
                  const SizedBox(height: 20),

                  // Conditionally show the image if button is pressed
                  if (_isImageVisible)
                    Container(
                      height: 300,
                      margin: const EdgeInsets.only(bottom: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.file(
                          widget.imageFile,
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                        .animate()
                        .scale(duration: 400.ms, curve: Curves.easeOutBack),

                  // Display extracted text
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardTheme.color,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color:
                              Theme.of(context).dividerColor.withOpacity(0.1),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: Text(
                          _extractedText,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
                  ),
                  const SizedBox(height: 20),

                  // Copy Text Button
                  ElevatedButton.icon(
                    icon: const Icon(Icons.copy),
                    label: Text(_buttonText), // Dynamically change button text
                    onPressed: _copyToClipboard,
                    style: _buttonColor != null
                        ? ElevatedButton.styleFrom(
                            backgroundColor: _buttonColor)
                        : null,
                  ).animate().fadeIn(delay: 400.ms, duration: 400.ms),

                  const SizedBox(height: 20),

                  // Export as PDF button
                  ElevatedButton.icon(
                    icon: const Icon(Icons.picture_as_pdf),
                    label: const Text("Export as PDF"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PdfExportScreen(
                            text: _extractedText,
                          ),
                        ),
                      );
                    },
                  ).animate().fadeIn(delay: 600.ms, duration: 400.ms),
                ],
              ),
      ),
    );
  }
}
