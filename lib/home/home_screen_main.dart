import 'package:bitcoin_tracker/home/_components/bottom_navbar.dart';
import 'package:bitcoin_tracker/home/_components/home_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentTab = 0;

  final List<Widget> _pages = [
    HomeScreen(), // HomeScreen is now at index 1 (Stats Page)
    Center(child: Text('Home Page', style: TextStyle(color: Colors.white))),
    Center(child: Text('Swap Page', style: TextStyle(color: Colors.white))),
    Center(child: Text('Wallet Page', style: TextStyle(color: Colors.white))),
    Center(child: Text('Profile Page', style: TextStyle(color: Colors.white))),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _pages[_currentTab], // Display the page for the current tab
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomNavBar(
              onTabSelected: _onTabSelected, // Update tab selection
            ),
          ),
        ],
      ),
    );
  }
}
