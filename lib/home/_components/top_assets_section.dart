import 'package:flutter/material.dart';

class TopAssetsSection extends StatelessWidget {
  const TopAssetsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Top Assets',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Asset List
            Expanded(
              child: ListView(
                children: [
                  _buildAssetRow('BTC', 'Bitcoin', '15,320.00 USD', '+15%'),
                  _buildAssetRow(
                      'DOGE', 'Dogecoin', '0.10478466 USD', '+5.33%'),
                  _buildAssetRow('ETH', 'Ethereum', '2,674.43 USD', '-0.35%'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssetRow(
      String symbol, String name, String price, String change) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            child: Text(symbol),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(price, style: TextStyle(color: Colors.grey)),
            ],
          ),
          Spacer(),
          Text(
            change,
            style: TextStyle(
              color: change.startsWith('+') ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
