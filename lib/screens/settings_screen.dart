import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: SwitchListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                secondary: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.yellow.withOpacity(0.2)
                        : Colors.orange.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isDark ? Icons.nightlight_round : Icons.wb_sunny,
                    color: isDark ? Colors.yellow : Colors.orange,
                  ),
                ),
                title: Text(
                  "Dark Mode",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                subtitle: Text(
                  isDark ? "Switch to Light Mode" : "Switch to Dark Mode",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                value: isDark,
                onChanged: (value) {
                  themeProvider.toggleTheme();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
