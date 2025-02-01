class Document {
  // Fields for the document model
  final String imagePath; // Path to the image file
  final String extractedText; // Text extracted from the image
  final DateTime date; // The date the document was scanned
  final String title; // Optional title for the document

  // Constructor to initialize the document model
  Document({
    required this.imagePath,
    required this.extractedText,
    required this.date,
    required this.title,
  });

  // Convert a Document object to a Map (for storing it in a database or shared preferences)
  Map<String, dynamic> toMap() {
    return {
      'imagePath': imagePath,
      'extractedText': extractedText,
      'date': date.toIso8601String(),
      'title': title,
    };
  }

  // Convert a Map to a Document object (for retrieving it from a database or shared preferences)
  factory Document.fromMap(Map<String, dynamic> map) {
    return Document(
      imagePath: map['imagePath'],
      extractedText: map['extractedText'],
      date: DateTime.parse(map['date']),
      title: map['title'],
    );
  }
}
