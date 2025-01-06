// ignore_for_file: unused_import

import 'package:bitcoin_tracker/auth/login_screen.dart';
import 'package:bitcoin_tracker/auth/register_screen.dart';
import 'package:bitcoin_tracker/auth/splash_screen.dart';
import 'package:bitcoin_tracker/components/io.dart';
import 'package:bitcoin_tracker/home/home_screen_main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart'; // Import provider for state management
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await Hive.openBox('settings');
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(), // Initialize the theme provider
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bitcoin Tracker',
      theme: themeNotifier.currentTheme, // Apply the current theme
      home: SplashScreen(),
    );
  }
}

class ThemeNotifier extends ChangeNotifier {
  final String key = 'isDarkMode';
  late Box settingsBox;
  bool _isDarkMode;

  ThemeNotifier()
      : _isDarkMode =
            Hive.box('settings').get('isDarkMode', defaultValue: false);

  bool get isDarkMode => _isDarkMode;

  ThemeData get currentTheme => _isDarkMode
      ? ThemeData.dark(useMaterial3: true)
      : ThemeData.light(useMaterial3: true);

  void toggleTheme(bool value) {
    _isDarkMode = value;
    Hive.box('settings').put(key, _isDarkMode); // Save preference to Hive
    notifyListeners();
  }
}
