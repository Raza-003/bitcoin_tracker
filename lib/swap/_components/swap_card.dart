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
  final bool isDarkMode; // New parameter to handle dark mode

  SwapCard({
    this.title,
    required this.amount,
    required this.currency,
    required this.balance,
    required this.icon,
    this.isReadOnly = false,
    this.controller,
    this.onAmountChanged,
    required this.isDarkMode, // Required parameter
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.black54 : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black26 : Colors.grey[300]!,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Text(
              title!,
              style: TextStyle(
                color: isDarkMode ? Colors.white70 : Colors.black87,
                fontSize: 16,
              ),
            ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor:
                        isDarkMode ? Colors.white24 : Colors.grey[200],
                    child: Icon(
                      icon,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    currency,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              if (isReadOnly)
                Text(
                  amount,
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
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
                    style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '0.00',
                      hintStyle: TextStyle(
                        color: isDarkMode ? Colors.white54 : Colors.black45,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Balance: $balance',
            style: TextStyle(
              color: isDarkMode ? Colors.white70 : Colors.black54,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
