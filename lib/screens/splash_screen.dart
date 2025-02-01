import 'dart:async';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo with fade-in animation
            AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(seconds: 2),
              child: Image.asset(
                'assets/logo.png', // Ensure the logo image is in assets
                height: 120,
              ),
            ),
            const SizedBox(height: 20),
            // App name with animation
            AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(seconds: 2),
              child: const Text(
                'Document Scanner',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Circular progress indicator with animation
            AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(seconds: 2),
              child: const CircularProgressIndicator(
                color:
                    Colors.blue, // You can change the color of the progress bar
              ),
            ),
          ],
        ),
      ),
    );
  }
}
