import 'package:bitcoin_tracker/converter/currency_converter.dart';
import 'package:bitcoin_tracker/home/_components/bottom_navbar.dart';
import 'package:bitcoin_tracker/home/_components/home_screen.dart';
import 'package:bitcoin_tracker/settings/setting_page.dart';
import 'package:bitcoin_tracker/swap/swap_page.dart';
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
    CurrencyConverter(),
    SwapPage(),
    SettingsPage(),
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
