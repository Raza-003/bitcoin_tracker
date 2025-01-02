import 'package:bitcoin_tracker/swap/_components/payment_method.dart';
import 'package:bitcoin_tracker/swap/_components/swap_card.dart';
import 'package:flutter/material.dart';

class SwapPage extends StatefulWidget {
  @override
  _SwapPageState createState() => _SwapPageState();
}

class _SwapPageState extends State<SwapPage> {
  double btcBalance = 1200; // User's initial BTC balance
  double dogeBalance = 0; // User's initial DOGE balance
  double btcToDogeRate = 4.55; // Exchange rate: 1 BTC = 4.55 DOGE
  double dogeAmount = 0.0; // Equivalent DOGE amount calculated dynamically

  final TextEditingController btcController = TextEditingController();

  String selectedPaymentMethod = 'Select Payment Method'; // Default text

  void calculateSwap() {
    setState(() {
      final enteredBTC = double.tryParse(btcController.text) ?? 0.0;
      dogeAmount = enteredBTC * btcToDogeRate;
    });
  }

  void confirmPaymentMethod() {
    if (selectedPaymentMethod == 'Select Payment Method') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a payment method!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Payment method confirmed: $selectedPaymentMethod")),
      );
    }
  }

  void swap() {
    setState(() {
      final enteredBTC = double.tryParse(btcController.text) ?? 0.0;

      if (enteredBTC > 0 && enteredBTC <= btcBalance) {
        // Deduct from BTC balance
        btcBalance -= enteredBTC;

        // Add to DOGE balance
        dogeBalance += dogeAmount;

        // Clear the input field and reset DOGE amount
        btcController.clear();
        dogeAmount = 0.0;

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Swap successful!")),
        );
      } else if (enteredBTC == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please enter an amount to swap!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Insufficient BTC balance!")),
        );
      }
    });
  }

  void selectPaymentMethod(String method) {
    setState(() {
      selectedPaymentMethod = method;
    });
  }

  @override
  void dispose() {
    btcController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Swap',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SwapCard(
                currency: 'Bitcoin',
                balance: btcBalance.toStringAsFixed(2),
                icon: Icons.currency_bitcoin,
                onAmountChanged: (value) {
                  calculateSwap();
                },
                controller: btcController,
                amount:
                    '\$${(dogeAmount * 300 / btcToDogeRate).toStringAsFixed(2)}',
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  setState(() {
                    calculateSwap();
                  });
                },
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: Color.fromARGB(255, 0, 255, 166),
                  child: Icon(Icons.swap_horiz, color: Colors.black, size: 32),
                ),
              ),
              SizedBox(height: 10),
              SwapCard(
                currency: 'Dogecoin',
                balance: dogeBalance.toStringAsFixed(2),
                icon: Icons.pets, // Placeholder for Dogecoin icon
                isReadOnly: true,
                amount:
                    '${dogeAmount.toStringAsFixed(2)} DOGE', // Display DOGE amount
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 0, 255, 166),
                    foregroundColor: Colors.black,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: swap, // Perform the swap
                  child: Text('Confirm Swap'),
                ),
              ),
              SizedBox(height: 26),
              PaymentMethodCard(
                onPaymentMethodSelected: selectPaymentMethod,
              ),
              SizedBox(height: 10),
              Text(
                'Payment Method: $selectedPaymentMethod',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: confirmPaymentMethod, // Confirm payment method
                  child: Text('Confirm Payment'),
                ),
              ),
              // SizedBox(height: 10),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}
