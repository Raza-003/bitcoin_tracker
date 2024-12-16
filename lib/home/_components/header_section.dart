import 'dart:async';
import 'dart:convert';
import 'package:bitcoin_tracker/components/model/coinModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HeaderSection extends StatefulWidget {
  const HeaderSection({super.key});

  @override
  _HeaderSectionState createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  String? _userName;
  bool isRefreshing = true;
  List<CoinModel>? coinMarket;
  double? btcPrice; // Store Bitcoin price
  double? cap; // Store Bitcoin price

  @override
  void initState() {
    super.initState();
    getCoinMarket();
    // Fetch the logged-in user's name
    _userName = FirebaseAuth.instance.currentUser?.displayName ?? 'User';
  }

  Future<void> getCoinMarket() async {
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

      setState(() {
        isRefreshing = false;
      });

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        setState(() {
          coinMarket =
              jsonResponse.map((data) => CoinModel.fromJson(data)).toList();

          // Get the BTC price
          btcPrice = coinMarket?[0].currentPrice;
          cap = coinMarket?[0].marketCapChangePercentage24H;
        });
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      setState(() {
        isRefreshing = false;
      });
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('images/usre.jpg'),
              ),
              const SizedBox(width: 10),
              Text(
                'Hey, ${_userName ?? 'Demo User'}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Spacer(),
              const Icon(
                Icons.notifications,
                color: Colors.white,
                size: 30,
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
                        : '...', // Display BTC price
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  cap != null ? '\$${cap}' : '...',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
