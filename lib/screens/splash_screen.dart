import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo with animation
            Image.asset(
              'assets/logo.png',
              height: 150,
            ).animate().fade(duration: 800.ms).scale(
                delay: 200.ms, duration: 600.ms, curve: Curves.easeOutBack),
            const SizedBox(height: 30),
            // App name with animation
            Text(
              'Document Scanner',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ).animate().fadeIn(delay: 400.ms, duration: 600.ms).slideY(
                begin: 0.3, end: 0, duration: 600.ms, curve: Curves.easeOut),
            const SizedBox(height: 40),
            // Circular progress indicator with animation
            CircularProgressIndicator(
              color: Theme.of(context).colorScheme.secondary,
            ).animate().fadeIn(delay: 800.ms),
          ],
        ),
      ),
    );
  }
}
