import 'package:bitcoin_tracker/auth/login_screen.dart';
import 'package:bitcoin_tracker/home/home_screen_main.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Page View Section
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                // Slide 1
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 3D Crypto Illustration
                    Image.asset(
                      'images/crypto_3d.png', // Replace with your asset path
                      height: 350,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 20),

                    // Title Text
                    Text(
                      'Crypto',
                      style: TextStyle(
                        fontFamily:
                            'PixelFont', // Replace with a pixelated font
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),

                    // Subtitle Text
                    Text(
                      'Empower your financial journey with\nseamless and secure cryptocurrency trading.',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                // Slide 2
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Placeholder for additional slides
                    Image.asset(
                      'images/crypto_3d.png', // Replace with your asset path
                      height: 350,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 20),

                    Text(
                      'Analytics',
                      style: TextStyle(
                        fontFamily: 'PixelFont',
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),

                    Text(
                      'Track your cryptocurrency trends\nand make informed decisions.',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Page Indicator
          SmoothPageIndicator(
            controller: _pageController,
            count: 2, // Update this count based on the number of slides
            effect: const ExpandingDotsEffect(
              dotHeight: 8,
              dotWidth: 8,
              dotColor: Colors.grey,
              activeDotColor: Colors.white,
            ),
          ),

          // Button Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: GestureDetector(
              onTap: () {
                // Navigate to the next screen
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
