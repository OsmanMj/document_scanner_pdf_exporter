import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfProvider with ChangeNotifier {
  String? _pdfPath;

  String? get pdfPath => _pdfPath;

  Future<void> generatePdf(String text) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(
              text,
              style: pw.TextStyle(fontSize: 18),
            ),
          ); // Add text content to PDF
        },
      ),
    );

    final outputDir = await getApplicationDocumentsDirectory();
    final outputPath = "${outputDir.path}/document_scan.pdf";
    final file = File(outputPath);
    await file.writeAsBytes(await pdf.save());

    _pdfPath = outputPath; // Save the PDF path
    notifyListeners(); // Notify listeners that the PDF is ready
  }
}
