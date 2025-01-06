import 'dart:convert';
import 'package:bitcoin_tracker/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({super.key});

  @override
  State<CurrencyConverter> createState() => _CurrencyConverterState();
}

// class _CurrencyConverterState extends State<CurrencyConverter> {
//   List<String> currencyList = [];
//   String selectedCurrency = 'bitcoin';
//   double amount = 0.0;
//   double convertedAmount = 0.0;
//   bool isLoading = true;
//   double conversionRate =
//       1.0; // Static conversion rate (USD to selected cryptocurrency)

//   @override
//   void initState() {
//     super.initState();
//     fetchCurrencies();
//   }

//   Future<void> fetchCurrencies() async {
//     const url = 'https://api.coincap.io/v2/assets';
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> jsonResponse = json.decode(response.body);
//         final List<dynamic> assets = jsonResponse['data'];
//         setState(() {
//           currencyList = assets.map((coin) => coin['id'] as String).toList();
//           isLoading = false;
//         });
//       } else {
//         showError("Failed to load currencies.");
//       }
//     } catch (e) {
//       showError("Error fetching currencies: $e");
//     }
//   }

//   Future<void> convertCurrency() async {
//     final url = 'https://api.coincap.io/v2/assets/$selectedCurrency';
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> jsonResponse = json.decode(response.body);
//         final price = double.parse(jsonResponse['data']['priceUsd']);

//         // Calculate the converted amount (USD to selected cryptocurrency)
//         setState(() {
//           convertedAmount = amount * price;
//           amount = 0.0; // Clear the entered amount after conversion
//           amountController.clear(); // Clear the TextField's text
//         });
//       } else {
//         showError("Failed to convert currency.");
//       }
//     } catch (e) {
//       showError("Error converting currency: $e");
//     }
//   }

//   void showError(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.redAccent,
//       ),
//     );
//   }

//   TextEditingController amountController = TextEditingController();

//   @override
//   void dispose() {
//     amountController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeNotifier>(context);
//     final isDarkMode = themeProvider.isDarkMode;

//     return Scaffold(
//       backgroundColor: isDarkMode ? Colors.black : Colors.white,
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           'Currency Converter',
//           style: TextStyle(
//             color: isDarkMode ? Colors.white : Colors.black,
//           ),
//         ),
//         backgroundColor:
//             isDarkMode ? Colors.black : const Color.fromARGB(255, 0, 255, 166),
//         elevation: 0,
//       ),
//       body: isLoading
//           ? const Center(
//               child: CircularProgressIndicator(
//                 color: Color.fromARGB(255, 0, 255, 166),
//               ),
//             )
//           : SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Crypto Amount:',
//                     style: TextStyle(
//                       color: isDarkMode ? Colors.white : Colors.black,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   TextField(
//                     controller: amountController,
//                     keyboardType: TextInputType.number,
//                     onChanged: (value) {
//                       setState(() {
//                         amount = double.tryParse(value) ?? 0.0;
//                       });
//                     },
//                     style: TextStyle(
//                       color: isDarkMode ? Colors.white : Colors.black,
//                     ),
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor:
//                           isDarkMode ? Colors.grey[800] : Colors.grey[200],
//                       hintText: 'Enter Amount',
//                       hintStyle: TextStyle(
//                         color: isDarkMode ? Colors.white54 : Colors.grey,
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Text(
//                     'Select Cryptocurrency:',
//                     style: TextStyle(
//                       color: isDarkMode ? Colors.white : Colors.black,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   DropdownButton<String>(
//                     value: selectedCurrency,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedCurrency = value!;
//                       });
//                     },
//                     items: currencyList.map((currency) {
//                       return DropdownMenuItem<String>(
//                         value: currency,
//                         child: Text(
//                           currency,
//                           style: TextStyle(
//                             color: isDarkMode ? Colors.white : Colors.black,
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                     dropdownColor:
//                         isDarkMode ? Colors.grey[800] : Colors.grey[200],
//                     style: TextStyle(
//                       color: isDarkMode ? Colors.white : Colors.black,
//                     ),
//                     iconEnabledColor: isDarkMode ? Colors.white : Colors.black,
//                   ),
//                   const SizedBox(height: 20),
//                   Center(
//                     child: ElevatedButton(
//                       onPressed: convertCurrency,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color.fromARGB(255, 0, 255, 166),
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 30,
//                           vertical: 12,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: const Text(
//                         'Convert',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Text(
//                     'Converted Amount:',
//                     style: TextStyle(
//                       color: isDarkMode ? Colors.white : Colors.black,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     '\$${convertedAmount.toStringAsFixed(2)}',
//                     style: TextStyle(
//                       color: isDarkMode ? Colors.greenAccent : Colors.green,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }

class _CurrencyConverterState extends State<CurrencyConverter> {
  List<String> currencyList = [];
  String selectedCurrency = 'bitcoin';
  double amount = 0.0;
  double convertedAmount = 0.0;
  bool isLoading = true;
  String selectedCurrencyType = 'USD'; // 'USD' or 'INR'
  double conversionRate = 1.0; // Dynamic conversion rate

  @override
  void initState() {
    super.initState();
    fetchCurrencies();
  }

  Future<void> fetchCurrencies() async {
    const url = 'https://api.coincap.io/v2/assets';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> assets = jsonResponse['data'];
        setState(() {
          currencyList = assets.map((coin) => coin['id'] as String).toList();
          isLoading = false;
        });
      } else {
        showError("Failed to load currencies.");
      }
    } catch (e) {
      showError("Error fetching currencies: $e");
    }
  }

  Future<void> fetchConversionRate() async {
    final url =
        'https://api.exchangerate-api.com/v4/latest/USD'; // A public API for conversion rates
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        setState(() {
          conversionRate = selectedCurrencyType == 'INR'
              ? jsonResponse['rates']['INR'] // USD to INR conversion
              : 1.0; // USD to USD (no conversion)
        });
      } else {
        showError("Failed to fetch conversion rates.");
      }
    } catch (e) {
      showError("Error fetching conversion rates: $e");
    }
  }

  Future<void> convertCurrency() async {
    await fetchConversionRate(); // Fetch conversion rate based on the selected currency type
    final url = 'https://api.coincap.io/v2/assets/$selectedCurrency';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final price = double.parse(jsonResponse['data']['priceUsd']);

        // Calculate the converted amount using dynamic conversion rate
        setState(() {
          convertedAmount = amount * price * conversionRate;
          amount = 0.0; // Clear the entered amount after conversion
          amountController.clear(); // Clear the TextField's text
        });
      } else {
        showError("Failed to convert currency.");
      }
    } catch (e) {
      showError("Error converting currency: $e");
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  TextEditingController amountController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeNotifier>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        centerTitle: true,automaticallyImplyLeading: false,
        title: Text(
          'Currency Converter',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor:
            isDarkMode ? Colors.black : const Color.fromARGB(255, 0, 255, 166),
        elevation: 0,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 0, 255, 166),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Crypto Amount:',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: amountController, // Set the controller here
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        amount = double.tryParse(value) ?? 0.0;
                      });
                    },
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor:
                          isDarkMode ? Colors.grey[800] : Colors.grey[200],
                      hintText: 'Enter Amount',
                      hintStyle: TextStyle(
                        color: isDarkMode ? Colors.white54 : Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Select Cryptocurrency:',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0), // Subtle padding
                          child: Text(
                            currency,
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight
                                  .w400, // Lighter font for minimal design
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    dropdownColor: isDarkMode ? Colors.grey[800] : Colors.white,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontSize: 16,
                      fontWeight:
                          FontWeight.w400, // Consistent light font weight
                    ),
                    iconEnabledColor: isDarkMode ? Colors.white : Colors.black,
                    iconSize: 20, // Smaller icon for a more minimalistic look
                    elevation: 2, // Subtle shadow for depth
                    underline:
                        SizedBox(), // No underline for cleaner appearance
                    hint: Text(
                      "Select Currency",
                      style: TextStyle(
                        color: isDarkMode ? Colors.white54 : Colors.black54,
                        fontSize: 16,
                        fontWeight:
                            FontWeight.w400, // Consistent light font weight
                      ),
                    ),
                    selectedItemBuilder: (context) {
                      return currencyList.map<Widget>((currency) {
                        return Center(
                          child: Text(
                            currency,
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight
                                  .w400, // Consistent styling for selected item
                            ),
                          ),
                        );
                      }).toList();
                    },
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: convertCurrency,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 255, 166),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Convert',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(height: 20),
                  // Text(
                  //   'Select Currency Type:',
                  //   style: TextStyle(
                  //     color: isDarkMode ? Colors.white : Colors.black,
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
                  // const SizedBox(height: 10),
                  // DropdownButton<String>(
                  //   value: selectedCurrencyType,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       selectedCurrencyType = value!;
                  //     });
                  //   },
                  //   items: ['USD', 'INR'].map((currencyType) {
                  //     return DropdownMenuItem<String>(
                  //       value: currencyType,
                  //       child: Text(
                  //         currencyType,
                  //         style: TextStyle(
                  //           color: isDarkMode ? Colors.white : Colors.black,
                  //         ),
                  //       ),
                  //     );
                  //   }).toList(),
                  //   dropdownColor:
                  //       isDarkMode ? Colors.grey[800] : Colors.grey[200],
                  //   style: TextStyle(
                  //     color: isDarkMode ? Colors.white : Colors.black,
                  //   ),
                  //   iconEnabledColor: isDarkMode ? Colors.white : Colors.black,
                  // ),
                  const SizedBox(height: 20),
                  Text(
                    'Converted Amount:',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${selectedCurrencyType == 'INR' ? '₹' : '\$'}${convertedAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: isDarkMode ? Colors.greenAccent : Colors.green,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
