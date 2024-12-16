import 'dart:async';
import 'dart:convert';
import 'package:bitcoin_tracker/components/model/coinModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TopAssetsSection extends StatefulWidget {
  const TopAssetsSection({super.key});

  @override
  State<TopAssetsSection> createState() => _TopAssetsSectionState();
}

class _TopAssetsSectionState extends State<TopAssetsSection> {
  bool isRefreshing = true;
  List<CoinModel>? coinMarket;

  @override
  void initState() {
    super.initState();
    getCoinMarket();
  }

  Future<void> getCoinMarket() async {
    const url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true';

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
    return Expanded(
      child: RefreshIndicator(
        onRefresh:
            getCoinMarket, // Call the getCoinMarket function when swiped down
        color: Colors.green, // Set the refresh indicator color to green
        backgroundColor:
            Colors.black, // Set background color for the refresh indicator
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Assets',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Average Price',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: isRefreshing
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.green),
                      )
                    : coinMarket == null || coinMarket!.isEmpty
                        ? const Center(
                            child: Text(
                              'No data available. Please try again later.',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : ListView.builder(
                            itemCount: coinMarket!.length,
                            itemBuilder: (context, index) {
                              final coin = coinMarket![index];
                              return _buildAssetRow(
                                coin.image, // Pass the image URL
                                coin.symbol.toUpperCase(),
                                coin.name,
                                '\$${coin.currentPrice.toStringAsFixed(2)}',
                                coin.priceChange24H,
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAssetRow(String imageUrl, String symbol, String name,
      String price, double change) {
    final isPositive = change >= 0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(imageUrl),
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    symbol,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${change.toStringAsFixed(2)}%',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isPositive ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
