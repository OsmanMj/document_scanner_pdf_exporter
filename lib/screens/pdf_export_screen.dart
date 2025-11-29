import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:document_scanner_app/utils/pdf_utils.dart';
import 'package:document_scanner_app/utils/file_utils.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PdfExportScreen extends StatefulWidget {
  final String text;

  const PdfExportScreen({super.key, required this.text});

  @override
  _PdfExportScreenState createState() => _PdfExportScreenState();
}

class _PdfExportScreenState extends State<PdfExportScreen> {
  bool _isTextCopied = false;
  String _buttonText = "Copy Text";
  Color? _buttonColor; // Default to theme

  Future<void> _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: widget.text));
    setState(() {
      _isTextCopied = true;
      _buttonText = "Copied!";
      _buttonColor = Colors.green;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isTextCopied = false;
          _buttonText = "Copy Text";
          _buttonColor = null; // Reset to theme
        });
      }
    });
  }

  Future<void> _savePdf() async {
    try {
      final pdfUtils = PdfUtils();
      final pdfBytes = await pdfUtils.generatePdf(widget.text);

      // Get file path
      String filePath = await FileUtils.getFilePath();

      final file = File(filePath);
      await file.writeAsBytes(pdfBytes);

      if (mounted) {
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
      }
    } catch (e) {
      if (mounted) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Export as PDF"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Your extracted text is ready to be saved as a PDF.",
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ).animate().fadeIn(duration: 600.ms),
            const SizedBox(height: 20),

            // Expanded widget prevents overflow by taking available space
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  border: Border.all(
                    color: Theme.of(context).dividerColor.withOpacity(0.2),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(16),
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
                    widget.text,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack),
            ),
            const SizedBox(height: 20),

            ElevatedButton.icon(
              icon: const Icon(Icons.copy),
              label: Text(_buttonText),
              onPressed: _copyToClipboard,
              style: _buttonColor != null
                  ? ElevatedButton.styleFrom(backgroundColor: _buttonColor)
                  : null,
            ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
            const SizedBox(height: 16),

            ElevatedButton.icon(
              icon: const Icon(Icons.save_alt),
              label: const Text("Save as PDF"),
              onPressed: _savePdf,
            ).animate().fadeIn(delay: 400.ms, duration: 400.ms),
          ],
        ),
      ),
    );
  }
}
