import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:document_scanner_app/utils/pdf_utils.dart';
import 'package:document_scanner_app/utils/file_utils.dart'; // Import it
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class PdfExportScreen extends StatefulWidget {
  final String text;

  const PdfExportScreen({super.key, required this.text});

  @override
  _PdfExportScreenState createState() => _PdfExportScreenState();
}

class _PdfExportScreenState extends State<PdfExportScreen> {
  bool _isTextCopied = false;
  String _buttonText = "Copy Text";
  Color _buttonColor = Colors.blueAccent;

  Future<void> _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: widget.text));
    setState(() {
      _isTextCopied = true;
      _buttonText = "Copied!";
      _buttonColor = Colors.green;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isTextCopied = false;
        _buttonText = "Copy Text";
        _buttonColor = Colors.blueAccent;
      });
    });
  }

  Future<void> _requestPermission() async {
    if (await Permission.storage.request().isGranted) {
      return;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Storage permission is required to save PDF.")),
      );
    }
  }

  Future<void> _savePdf() async {
    try {
      final pdfUtils = PdfUtils();
      final pdfBytes = await pdfUtils.generatePdf(widget.text);

      // Get file path
      String filePath = await FileUtils.getFilePath();

      final file = File(filePath);
      await file.writeAsBytes(pdfBytes);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("PDF Saved"),
          content: Text("PDF saved at: $filePath"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Export as PDF"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Your extracted text is ready to be saved as a PDF.",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SingleChildScrollView(
                child: Text(
                  widget.text,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.copy),
              label: Text(_buttonText),
              onPressed: _copyToClipboard,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: _buttonColor,
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.save_alt),
              label: const Text("Save as PDF"),
              onPressed: _savePdf,
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
