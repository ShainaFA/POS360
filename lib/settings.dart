import 'package:flutter/material.dart';
import 'package:milktea/dashboard.dart';
import 'change_password.dart';
import 'profile.dart';
import 'main.dart';
import 'user.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool darkMode = false;
  bool allowNotifications = true;
  String selectedLanguage = 'English';
  TimeOfDay openTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay closeTime = const TimeOfDay(hour: 21, minute: 0);

  Future<void> _selectTime(BuildContext context, bool isOpeningTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isOpeningTime ? openTime : closeTime,
    );
    if (picked != null) {
      setState(() {
        if (isOpeningTime) {
          openTime = picked;
        } else {
          closeTime = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SETTINGS',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundImage: AssetImage('assets/profile.jpg'),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Ginold Moreno',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Manager', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Dashboard()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.supervised_user_circle_rounded),
              title: const Text('Users'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const UsersPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(48),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Shop Settings',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          ListTile(
            leading: const Icon(Icons.access_time),
            title: const Text('Opening Time'),
            trailing: Text(openTime.format(context)),
            onTap: () => _selectTime(context, true),
          ),

          ListTile(
            leading: const Icon(Icons.access_time_outlined),
            title: const Text('Closing Time'),
            trailing: Text(closeTime.format(context)),
            onTap: () => _selectTime(context, false),
          ),

          const Divider(height: 30),

          const Text(
            'Preferences',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          SwitchListTile(
            title: const Text("Dark Mode"),
            value: darkMode,
            onChanged: (val) => setState(() => darkMode = val),
          ),

          SwitchListTile(
            title: const Text("Allow Notifications"),
            value: allowNotifications,
            onChanged: (val) => setState(() => allowNotifications = val),
          ),

          ListTile(
            title: const Text("Language"),
            trailing: DropdownButton<String>(
              value: selectedLanguage,
              items: const [
                DropdownMenuItem(value: 'English', child: Text('English')),
                DropdownMenuItem(value: 'Filipino', child: Text('Filipino')),
              ],
              onChanged: (value) {
                setState(() => selectedLanguage = value!);
              },
            ),
          ),

          const Divider(height: 30),

          const Text(
            'Account',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Edit Profile"),
            onTap: () {
              // Navigate to Edit Profile screen
            },
          ),

          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text("Change Password"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChangePasswordPage(),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
              // Perform logout action
            },
          ),

          const Divider(height: 30),

          const Center(child: Text("App Version 1.0.0")),
        ],
      ),
    );
  }
}
