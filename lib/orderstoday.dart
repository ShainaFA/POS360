import 'package:flutter/material.dart';
import 'ordering.dart';
import 'inventory.dart';
import 'main.dart'; // For LoginPage
import 'profile.dart';
import 'user.dart';
import 'dashboard.dart';

void main() {
  runApp(const OrdersToday());
}

class OrdersToday extends StatelessWidget {
  const OrdersToday({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orders Today App',
      theme: ThemeData(
        primarySwatch: Colors.green, // A fresh color for orders
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: const OrdersTodayScreen(),
    );
  }
}

class OrdersTodayScreen extends StatefulWidget {
  const OrdersTodayScreen({super.key});

  @override
  State<OrdersTodayScreen> createState() => _OrdersTodayScreenState();
}

class _OrdersTodayScreenState extends State<OrdersTodayScreen> {
  int _selectedIndex = 0; // Set to 0 to highlight 'Orders Today' initially

  // Dummy data for orders today
  final List<Map<String, dynamic>> _ordersToday = [
    {
      'orderId': 'OTD001',
      'customerName': 'Grace Hopper',
      'item': 'Bubble Milk Tea',
      'quantity': 2,
      'amount': 12.50,
      'time': '10:30 AM',
    },
    {
      'orderId': 'OTD002',
      'customerName': 'Alan Turing',
      'item': 'Taro Milk Tea',
      'quantity': 1,
      'amount': 6.75,
      'time': '11:00 AM',
    },
    {
      'orderId': 'OTD003',
      'customerName': 'Ada Lovelace',
      'item': 'Matcha Latte',
      'quantity': 1,
      'amount': 7.00,
      'time': '11:45 AM',
    },
    {
      'orderId': 'OTD004',
      'customerName': 'Linus Torvalds',
      'item': 'Classic Milk Tea',
      'quantity': 3,
      'amount': 18.00,
      'time': '01:15 PM',
    },
    {
      'orderId': 'OTD005',
      'customerName': 'Margaret Hamilton',
      'item': 'Strawberry Milk Tea',
      'quantity': 2,
      'amount': 13.50,
      'time': '02:00 PM',
    },
    {
      'orderId': 'OTD006',
      'customerName': 'Bill Gates',
      'item': 'Brown Sugar Boba',
      'quantity': 1,
      'amount': 7.25,
      'time': '03:30 PM',
    },
  ];

  void _onBottomNavTapped(int index) {
    setState(() => _selectedIndex = index);
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const OrderingPage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Dashboard()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const InventoryPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate total sales for today
    final double totalSalesToday = _ordersToday.fold(
      0.0,
      (sum, order) => sum + order['amount'],
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Dashboard()),
            );
          },
        ),
        title: const Text(
          'ORDERS TODAY',
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
              decoration: BoxDecoration(color: Color.fromARGB(255, 0, 0, 0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Manager',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
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
              leading: const Icon(Icons.restaurant_menu_rounded),
              title: const Text('Ordering'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const OrderingPage()),
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
                Navigator.pop(context);
              },
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(48),
                  alignment: Alignment.center,
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
      body: Column(
        children: [
          // Total Sales Today Summary
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.green[600], // Darker green for summary card
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      'Total Sales Today',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '₱${totalSalesToday.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color:
                            Colors.lightGreenAccent, // Highlight total amount
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // List of individual orders
          Expanded(
            child: _ordersToday.isEmpty
                ? const Center(
                    child: Text(
                      'No orders recorded for today.',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    itemCount: _ordersToday.length,
                    itemBuilder: (context, index) {
                      final order = _ordersToday[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.green[100],
                            child: Text(
                              (index + 1).toString(),
                              style: TextStyle(
                                color: Colors.green[800],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          title: Text(
                            '${order['item']} x${order['quantity']}',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            '${order['customerName']} - ${order['time']}',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          trailing: Text(
                            '₱${order['amount'].toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green, // Indicate sales with green
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        onTap: _onBottomNavTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Ordering',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            label: 'Inventory',
          ),
        ],
        backgroundColor: Colors.white,
      ),
    );
  }
}
