import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Provider.of<ThemeProvider>(context).isDarkTheme
                        ? Icons.nightlight_round // Moon icon for Dark Mode
                        : Icons.wb_sunny, // Sun icon for Light Mode
                    size: 30,
                    color: Provider.of<ThemeProvider>(context).isDarkTheme
                        ? Colors.yellow
                        : Colors.orange,
                  ),
                  const SizedBox(width: 10), // Space between icon and text
                  Text(
                    Provider.of<ThemeProvider>(context).isDarkTheme
                        ? "Dark Mode"
                        : "Light Mode", // Dynamically change the text
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              trailing: Switch(
                value: Provider.of<ThemeProvider>(context).isDarkTheme,
                onChanged: (value) {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
