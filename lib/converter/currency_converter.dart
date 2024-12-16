import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({super.key});

  @override
  State<CurrencyConverter> createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  List<String> currencyList = [];
  String selectedCurrency = 'bitcoin';
  double amount = 0.0;
  double convertedAmount = 0.0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCurrencies();
  }

  Future<void> fetchCurrencies() async {
    final url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        setState(() {
          currencyList =
              jsonResponse.map((coin) => coin['id'] as String).toList();
          isLoading = false;
        });
      } else {
        print("Failed to load currencies");
      }
    } catch (e) {
      print("Error fetching currencies: $e");
    }
  }

  Future<void> convertCurrency() async {
    final url =
        'https://api.coingecko.com/api/v3/simple/price?ids=$selectedCurrency&vs_currencies=usd';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final price = jsonResponse[selectedCurrency]['usd'] as double;
        setState(() {
          convertedAmount = amount * price;
        });
      } else {
        print("Failed to convert currency");
      }
    } catch (e) {
      print("Error converting currency: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Currency Converter',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 0, 255, 166)))
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Amount:',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          amount = double.tryParse(value) ?? 0.0;
                        });
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[800],
                        hintText: 'Enter Amount',
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      )),
                  const SizedBox(height: 20),
                  const Text(
                    'Select Cryptocurrency:',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  DropdownButton<String>(
                    value: selectedCurrency,
                    onChanged: (value) {
                      setState(() {
                        selectedCurrency = value!;
                      });
                    },
                    items: currencyList.map((currency) {
                      return DropdownMenuItem<String>(
                        value: currency,
                        child: Text(
                          currency,
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                    dropdownColor: Colors.black,
                    style: const TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.white,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: convertCurrency,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 0, 255, 166),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                    child: const Text(
                      'Convert',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Converted Amount: \$${convertedAmount.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
    );
  }
}
