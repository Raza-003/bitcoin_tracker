import 'package:bitcoin_tracker/home/_components/chart_section.dart';
import 'package:bitcoin_tracker/home/_components/header_section.dart';
import 'package:bitcoin_tracker/home/_components/top_assets_section.dart';
import 'package:bitcoin_tracker/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get current theme to adapt styles
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDarkMode = themeNotifier.isDarkMode;

    return Scaffold(
      backgroundColor: isDarkMode
          ? Colors.black
          : Colors.white, // Adapt background color based on dark/light mode
      body: Column(
        children: [
          SizedBox(height: 30),
          HeaderSection(),
          ChartSection(),
          TopAssetsSection(),
        ],
      ),
    );
  }
}
