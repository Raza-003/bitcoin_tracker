import 'package:flutter/material.dart';

class SwapCard extends StatelessWidget {
  final String? title;
  final String amount;
  final String currency;
  final String balance;
  final IconData icon;
  final bool isReadOnly;
  final TextEditingController? controller;
  final Function(String)? onAmountChanged;

  SwapCard({
    this.title,
    required this.amount,
    required this.currency,
    required this.balance,
    required this.icon,
    this.isReadOnly = false,
    this.controller,
    this.onAmountChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   title,
          //   style: TextStyle(color: Colors.white70, fontSize: 16),
          // ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white24,
                    child: Icon(icon, color: Colors.white),
                  ),
                  SizedBox(width: 8),
                  Text(
                    currency,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              if (isReadOnly)
                Text(
                  amount,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              else
                Container(
                  width: 100,
                  child: TextField(
                    controller: controller,
                    onChanged: onAmountChanged,
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '0.00',
                      hintStyle: TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Balance: $balance',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
