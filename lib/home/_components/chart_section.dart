import 'dart:convert';
import 'package:bitcoin_tracker/components/model/coinModel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChartSection extends StatefulWidget {
  const ChartSection({super.key});

  @override
  State<ChartSection> createState() => _ChartSectionState();
}

class _ChartSectionState extends State<ChartSection> {
  List<CoinModel> coinMarket = []; // Holds coin data from API
  List<FlSpot> chartData = []; // Chart data points
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDataAndPrepareChart();
  }

  /// Fetch Coin Market Data
  Future<void> _fetchDataAndPrepareChart() async {
    const url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true';

    try {
      setState(() => isLoading = true);
      final response = await http.get(Uri.parse(url), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      });

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);

        // Parse the coin data
        final List<CoinModel> fetchedCoins =
            jsonResponse.map((data) => CoinModel.fromJson(data)).toList();

        setState(() {
          coinMarket = fetchedCoins;

          // Use the first coin's sparkline data as an example
          if (coinMarket.isNotEmpty) {
            chartData = _mapSparklineToChartData(
              coinMarket.first.sparklineIn7D.price,
            );
          }
          isLoading = false;
        });
      } else {
        print("API Error: ${response.statusCode}");
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("Error: $e");
      setState(() => isLoading = false);
    }
  }

  /// Convert Sparkline Data to FlSpot Points
  List<FlSpot> _mapSparklineToChartData(List<double> sparkline) {
    return List.generate(
      sparkline.length,
      (index) => FlSpot(index.toDouble(), sparkline[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.only(top: 10, right: 12, left: 12),
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.green),
            )
          : LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: chartData,
                    isCurved: true,
                    color: Color.fromARGB(255, 0, 255, 166),
                    barWidth: 1.5,
                    belowBarData: BarAreaData(
                      show: true,
                      color: Color.fromARGB(255, 0, 255, 166).withOpacity(0.1),
                    ),
                    dotData: const FlDotData(show: false),
                  ),
                ],
              ),
            ),
    );
  }
}
