import 'package:flutter/material.dart';

class PaymentMethodCard extends StatelessWidget {
  final Function(String) onPaymentMethodSelected;

  PaymentMethodCard({required this.onPaymentMethodSelected});

  void _showPaymentMethodBottomSheet(BuildContext context) {
    final paymentMethods = [
      "Alchemy Pay",
      "Credit Card",
      "PayPal",
      "Bank Transfer"
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor:
          Colors.black.withOpacity(0.7), // Darker background for bottom sheet
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
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.white70),
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
          color: Colors.transparent, // Minimal transparent background
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Subtle shadow effect
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.green
                .withOpacity(0.2), // Slight green tint for the theme
            child: Icon(Icons.payment, color: Colors.white),
          ),
          title: Text(
            'Select Payment Method',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16, // Slightly larger font for clarity
            ),
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.white70),
        ),
      ),
    );
  }
}
