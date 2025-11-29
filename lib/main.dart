import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'providers/theme_provider.dart';
import 'providers/image_provider.dart';
import 'providers/ocr_provider.dart';
import 'providers/pdf_provider.dart';
import 'providers/document_provider.dart'; // Import the new provider

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ImageProviderClass()),
        ChangeNotifierProvider(create: (_) => OcrProvider()),
        ChangeNotifierProvider(create: (_) => PdfProvider()),
        ChangeNotifierProvider(
            create: (_) => DocumentProvider()), // Add DocumentProvider here
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Document Scanner',
          theme: themeProvider.currentTheme,
          home: const SplashScreen(),
        );
      },
    );
  }
}
