import 'package:flutter/material.dart';

class PaymentMethodCard extends StatelessWidget {
  final Function(String) onPaymentMethodSelected;
  final bool isDarkMode; // New parameter to handle dark mode

  PaymentMethodCard({
    required this.onPaymentMethodSelected,
    required this.isDarkMode,
  });

  void _showPaymentMethodBottomSheet(BuildContext context) {
    final paymentMethods = [
      "Alchemy Pay",
      "Credit Card",
      "PayPal",
      "Bank Transfer"
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: isDarkMode
          ? Colors.black.withOpacity(0.9)
          : Colors.grey[100], // Dynamic background color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: paymentMethods.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                paymentMethods[index],
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: isDarkMode ? Colors.white70 : Colors.grey[600],
              ),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                onPaymentMethodSelected(paymentMethods[index]);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showPaymentMethodBottomSheet(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode
              ? Colors.black54
              : Colors.white, // Dynamic background color
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: isDarkMode
                  ? Colors.black.withOpacity(0.3)
                  : Colors.grey.withOpacity(0.3), // Subtle shadow effect
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: isDarkMode
                ? Colors.green.withOpacity(0.2)
                : Colors.green.withOpacity(0.1), // Slight tint for theme
            child: Icon(
              Icons.payment,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
          title: Text(
            'Select Payment Method',
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: isDarkMode ? Colors.white70 : Colors.grey[600],
          ),
        ),
      ),
    );
  }
}
