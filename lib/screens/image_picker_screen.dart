import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Instruction text
            Text(
              'Please select or capture an image for text recognition.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.6),
                  ),
              textAlign: TextAlign.center,
            ).animate().fadeIn(duration: 600.ms),
            const SizedBox(height: 40),

            // Show the selected image or a loading indicator
            _selectedImage == null
                ? CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ) // Show loading while picking image
                : ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.file(
                      _selectedImage!,
                      fit: BoxFit.cover,
                      height: 400,
                      width: double.infinity,
                    ),
                  )
                    .animate()
                    .scale(duration: 400.ms, curve: Curves.easeOutBack),
            const SizedBox(height: 40),

            // Retry or capture another image button
            if (_selectedImage != null)
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
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
          ],
        ),
      ),
    );
  }
}
