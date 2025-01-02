import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = true; // Variable to track dark/light mode
  String profileName = 'John Doe'; // Placeholder for profile name
  String selectedPaymentMethod = 'Select Payment Method'; // Default text

  void toggleTheme(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  void logout() {
    // Handle logout (clear session, tokens, etc.)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Logged out successfully!")),
    );
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

  void selectPaymentMethod(String method) {
    setState(() {
      selectedPaymentMethod = method;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor:
            isDarkMode ? Colors.black : Color.fromARGB(255, 0, 255, 166),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Settings',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Section
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                title: Text(
                  profileName,
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                onTap: () {
                  // Navigate to profile page (optional)
                },
              ),
              const Divider(color: Colors.grey),

              // About Us Section
              ListTile(
                leading: Icon(
                  Icons.info_outline,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                title: Text('About the App',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    )),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text(
                        'About the App',
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      content: const Text(
                        'This is a Bitcoin Tracker app that allows you to track your cryptocurrencies.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const Divider(color: Colors.grey),

              // Theme Change Section
              SwitchListTile(
                title: Row(
                  children: [
                    Icon(
                      isDarkMode ? Icons.sunny : Icons.nightlight_round,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Dark Mode',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
                value: isDarkMode,
                onChanged: toggleTheme,
                activeColor: Color.fromARGB(255, 0, 255, 166),
                inactiveTrackColor:
                    isDarkMode ? Colors.grey[600] : Colors.grey[300],
              ),
              const Divider(color: Colors.grey),

              // Logout Button
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: logout, // Perform the logout
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
