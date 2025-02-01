import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'text_recognition_screen.dart';

class ImagePickerScreen extends StatefulWidget {
  final String source; // "gallery" or "camera"

  const ImagePickerScreen({super.key, required this.source});

  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source:
          widget.source == "gallery" ? ImageSource.gallery : ImageSource.camera,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });

      // Navigate to Text Recognition Screen after picking the image
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              TextRecognitionScreen(imageFile: _selectedImage!),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _pickImage(); // Automatically trigger image selection on screen load
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Select Image",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Instruction text
            const Text(
              'Please select or capture an image for text recognition.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 80),

            // Show the selected image or a loading indicator
            _selectedImage == null
                ? const CircularProgressIndicator(
                    color: Colors.blueAccent,
                  ) // Show loading while picking image
                : ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      _selectedImage!,
                      fit: BoxFit.contain, // Ensures the whole image is visible
                      height: 380,
                      width: double.infinity,
                    ),
                  ),
            const SizedBox(height: 40),

            // Retry or capture another image button
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text("Pick Another Image"),
              onPressed: () {
                setState(() {
                  _selectedImage = null; // Reset selected image
                });
                _pickImage(); // Re-trigger image picking
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
