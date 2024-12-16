// ignore_for_file: unused_import

import 'package:bitcoin_tracker/auth/login_screen.dart';
import 'package:bitcoin_tracker/auth/register_screen.dart';
import 'package:bitcoin_tracker/auth/splash_screen.dart';
import 'package:bitcoin_tracker/components/io.dart';
import 'package:bitcoin_tracker/home/home_screen_main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      // home: SplashScreen(),
      // home: RegisterScreen(),
      home: Home(),
      // home: IO(),
    );
  }
}
