import 'package:bitcoin_tracker/home/_components/chart_section.dart';
import 'package:bitcoin_tracker/home/_components/header_section.dart';
import 'package:bitcoin_tracker/home/_components/top_assets_section.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          HeaderSection(),
          ChartSection(),
          TopAssetsSection(),
        ],
      ),
    );
  }
}
