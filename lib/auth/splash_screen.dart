import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bitcoin_tracker/auth/get_started_screen.dart';
import 'package:bitcoin_tracker/home/home_screen_main.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Timer to navigate based on login status
    Timer(Duration(seconds: 4), () {
      // Check if the user is logged in
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // If user is logged in, go to HomeScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      } else {
        // If user is not logged in, go to GetStartedScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => GetStartedScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color.fromARGB(255, 0, 124, 101), // Deep green
              Color(0xFF00100F), // Dark green/black
            ],
            center: Alignment.center,
            radius: 1.5, // Adjust radius for effect
            focal: Alignment.center,
            focalRadius: 0.1, // Highlight focus in the center
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated Lottie
              Lottie.asset(
                "images/new.json",
                height: 250,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
