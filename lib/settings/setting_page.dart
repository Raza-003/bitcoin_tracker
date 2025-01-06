import 'package:bitcoin_tracker/auth/login_screen.dart';
import 'package:bitcoin_tracker/main.dart';
import 'package:bitcoin_tracker/settings/info.dart';
import 'package:bitcoin_tracker/settings/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut(); // Sign out the user
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const LoginScreen(), // Navigate to LoginScreen
          ),
        );
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Logged out successfully!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to log out: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDarkMode = themeNotifier.isDarkMode;

    // Get the current user's email
    final email = FirebaseAuth.instance.currentUser?.email ?? 'No Email Found';
    final name = email != 'No Email Found' ? email.split('@').first : 'User';

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor:
            isDarkMode ? Colors.black : const Color.fromARGB(255, 0, 255, 166),
        elevation: 0,
        centerTitle: true,automaticallyImplyLeading: false,
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
                  'Profile',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                onTap: () {
                  // Navigate to ProfilePage with email and name
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(
                        email: email,
                        name: name,
                      ),
                    ),
                  );
                },
              ),
              const Divider(color: Colors.grey),
              // About Section
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
                      return const Infopage();
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
                    const SizedBox(width: 8),
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
                activeColor: const Color.fromARGB(255, 0, 255, 166),
                inactiveTrackColor:
                    isDarkMode ? Colors.grey[600] : Colors.grey[300],
              ),
              const Divider(color: Colors.grey),

              // Logout Button
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: logout,
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
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
