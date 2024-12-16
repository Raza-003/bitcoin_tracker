import 'package:flutter/material.dart';

class ChartSection extends StatelessWidget {
  const ChartSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Time Filters
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('1m', style: TextStyle(color: Colors.grey)),
              Text('5m', style: TextStyle(color: Colors.grey)),
              Text('15m', style: TextStyle(color: Colors.grey)),
              Text('30m', style: TextStyle(color: Colors.grey)),
              Text('1h', style: TextStyle(color: Colors.green)),
              Text('4h', style: TextStyle(color: Colors.grey)),
              Text('D', style: TextStyle(color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 10),

          // Graph Placeholder (Replace with an actual chart library)
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ],
      ),
    );
  }
}
