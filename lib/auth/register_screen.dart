import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_tracker/auth/_components/textfiled.dart';
import 'package:bitcoin_tracker/auth/login_screen.dart';
import 'package:bitcoin_tracker/home/home_screen_main.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  bool _isLoading = false;

  // Custom error message mapping
  String getCustomErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'invalid-email':
        return 'The email address is invalid.';
      case 'email-already-in-use':
        return 'This email address is already in use. Please use a different email.';
      case 'weak-password':
        return 'The password is too weak. Please use a stronger password.';
      case 'operation-not-allowed':
        return 'Email/password registration is disabled. Please contact support.';
      case 'network-request-failed':
        return 'Network error. Please check your connection and try again.';
      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }

  // Register method using Firebase Authentication
  Future<void> _register() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Firebase register
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Navigate to Home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } on FirebaseAuthException catch (e) {
      // Show custom error message
      String errorMessage = getCustomErrorMessage(e.code);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      // Show generic error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'An unexpected error occurred. Please try again.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'images/crypto_3d.png',
                  height: 250,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 30),
                Text(
                  'Register',
                  style: TextStyle(
                    fontFamily: 'PixelFont',
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // Username TextField
                CustomTextField(
                  controller: _usernameController,
                  hintText: 'Username',
                ),
                const SizedBox(height: 20),

                // Email TextField
                CustomTextField(
                  controller: _emailController,
                  hintText: 'Email',
                ),
                const SizedBox(height: 20),

                // Password TextField
                CustomTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  isPassword: true,
                ),
                const SizedBox(height: 30),

                // Register Button
                GestureDetector(
                  onTap: _isLoading ? null : _register,
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    alignment: Alignment.center,
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 20),

                // Login Option
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
