import 'package:flutter/material.dart';
import '../models/document_model.dart';

class DocumentProvider with ChangeNotifier {
  List<Document> _documents = [];

  List<Document> get documents => _documents;

  // Add a document to the list
  void addDocument(Document document) {
    _documents.add(document);
    notifyListeners();
  }

  // Remove a document from the list
  void removeDocument(Document document) {
    _documents.remove(document);
    notifyListeners();
  }

  // Optionally, you can add a function to retrieve documents from storage or network
}
