import 'package:bitcoin_tracker/settings/info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider
import '../main.dart'; // Import ThemeNotifier

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String profileName = 'John Doe'; // Placeholder for profile name
  String selectedPaymentMethod = 'Select Payment Method'; // Default text

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
    // Access the theme provider
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDarkMode = themeNotifier.isDarkMode;

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
                title: Text('About the Company',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    )),
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Infopage();
                    },
                  );
                },
              ),
              const Divider(color: Colors.grey),

              // Theme Change Section
              SwitchListTile(
                title: Row(
                  children: [
                    Icon(
                      isDarkMode ? Icons.nightlight_round : Icons.sunny,
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
                onChanged: (value) {
                  themeNotifier.toggleTheme(value); // Update global theme
                },
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
