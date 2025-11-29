import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslationService {
  static const String _baseUrl = 'https://libretranslate.com/translate';
  static const String _detectUrl = 'https://libretranslate.com/detect';

  // Detect the source language of the text
  static Future<String> detectLanguage(String text) async {
    final response = await http.post(
      Uri.parse(_detectUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'q': text,
      }),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data[0]
          ['language']; // Returns the detected language code (e.g., 'en')
    } else {
      throw Exception('Failed to detect language: ${response.body}');
    }
  }

  // Translate text to a target language
  static Future<String> translateText(
      String text, String targetLanguage) async {
    if (text.isEmpty) {
      return 'No text to translate';
    }

    try {
      // Detect the source language
      final String sourceLanguage = await detectLanguage(text);

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'q': text,
          'source': sourceLanguage, // Use the detected source language
          'target': targetLanguage,
          'format': 'text',
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['translatedText'];
      } else {
        throw Exception('Failed to translate text: ${response.body}');
      }
    } catch (e) {
      // If language detection fails, default to English
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'q': text,
          'source': 'en', // Default to English
          'target': targetLanguage,
          'format': 'text',
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['translatedText'];
      } else {
        throw Exception('Failed to translate text: ${response.body}');
      }
    }
  }
}
