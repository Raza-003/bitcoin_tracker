import 'dart:convert';
import 'package:bitcoin_tracker/auth/login_screen.dart';
import 'package:bitcoin_tracker/components/model/coinModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HeaderSection extends StatefulWidget {
  const HeaderSection({Key? key}) : super(key: key);

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  String? _userName; // User's name extracted from email
  bool isRefreshing = true; // Indicates data fetching status
  List<CoinModel>? coinMarket; // List to store market data
  double? btcPrice; // Store Bitcoin price
  double? cap; // Store Bitcoin market cap change percentage

  @override
  void initState() {
    super.initState();
    _initializeUserName();
    _fetchCoinMarketData();
  }

  /// Extracts the user's name from their email.
  void _initializeUserName() {
    final email = FirebaseAuth.instance.currentUser?.email;
    _userName = email != null ? email.split('@').first : 'User';
  }

  /// Fetches Bitcoin market data from the API.
  Future<void> _fetchCoinMarketData() async {
    const url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin&sparkline=true';

    setState(() {
      isRefreshing = true;
    });

    try {
      final response = await http.get(Uri.parse(url), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      });

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        final List<CoinModel> fetchedData =
            jsonResponse.map((data) => CoinModel.fromJson(data)).toList();

        setState(() {
          coinMarket = fetchedData;
          btcPrice = coinMarket?.first.currentPrice;
          cap = coinMarket?.first.marketCapChangePercentage24H;
        });
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      setState(() {
        isRefreshing = false;
      });
    }
  }

  /// Displays a bottom sheet for logout confirmation.
  void _showLogoutBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: Colors.black,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Are you sure you want to log out?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      if (mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Log Out',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Theme.of(context);
    final isDarkMode = themeProvider.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('images/usre.jpg'),
              ),
              const SizedBox(width: 10),
              Text(
                'Hey, ${_userName ?? 'Demo User'}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: _showLogoutBottomSheet,
                icon: Icon(
                  Icons.logout,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    btcPrice != null
                        ? '\$${btcPrice!.toStringAsFixed(2)}'
                        : '...',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  const Text(
                    'Bitcoin Price',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 255, 166),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  cap != null ? '${cap!.toString()}%' : '...',
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
