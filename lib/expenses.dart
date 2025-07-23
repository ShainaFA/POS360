import 'package:flutter/material.dart';
import 'ordering.dart'; // Import the ProductScreen
import 'profile.dart';
import 'user.dart';
import 'dashboard.dart';
import 'main.dart';
import 'inventory.dart';

void main() {
  runApp(const Expenses());
}

class Expenses extends StatelessWidget {
  const Expenses({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Milktea Expenses App',
      theme: ThemeData(
        primarySwatch:
            Colors.brown, // A suitable color for a milktea shop theme
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: const MilkteaExpensesScreen(),
    );
  }
}

class MilkteaExpensesScreen extends StatefulWidget {
  const MilkteaExpensesScreen({super.key});

  @override
  State<MilkteaExpensesScreen> createState() => _MilkteaExpensesScreenState();
}

class _MilkteaExpensesScreenState extends State<MilkteaExpensesScreen> {
  int _selectedIndex = 0; // Set to 0 to highlight 'Expenses' initially

  // Dummy data for milktea shop expenses
  final List<Map<String, dynamic>> _expenses = [
    {
      'id': 'EXP001',
      'category': 'Ingredients',
      'description': 'Milk, Tea Leaves, Pearls',
      'amount': 500.00,
      'date': '2025-07-15',
    },
    {
      'id': 'EXP002',
      'category': 'Rent',
      'description': 'Monthly Shop Rent',
      'amount': 1200.00,
      'date': '2025-07-01',
    },
    {
      'id': 'EXP003',
      'category': 'Salaries',
      'description': 'Staff Wages',
      'amount': 800.00,
      'date': '2025-07-20',
    },
    {
      'id': 'EXP004',
      'category': 'Utilities',
      'description': 'Electricity Bill',
      'amount': 250.00,
      'date': '2025-07-10',
    },
    {
      'id': 'EXP005',
      'category': 'Marketing',
      'description': 'Social Media Ads',
      'amount': 150.00,
      'date': '2025-07-12',
    },
    {
      'id': 'EXP006',
      'category': 'Ingredients',
      'description': 'Syrups and Toppings',
      'amount': 300.00,
      'date': '2025-07-18',
    },
    {
      'id': 'EXP007',
      'category': 'Maintenance',
      'description': 'Equipment Repair',
      'amount': 100.00,
      'date': '2025-07-19',
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

  // Helper function to get category icon
  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Ingredients':
        return Icons.local_cafe;
      case 'Rent':
        return Icons.home;
      case 'Salaries':
        return Icons.people;
      case 'Utilities':
        return Icons.lightbulb_outline;
      case 'Marketing':
        return Icons.campaign;
      case 'Maintenance':
        return Icons.build;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate total expenses
    final double totalExpenses = _expenses.fold(
      0.0,
      (sum, item) => sum + item['amount'],
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
          'EXPENSES',
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
          // Total Expenses Summary
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.brown[600], // Darker brown for summary card
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      'Total Expenses',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '₱${totalExpenses.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent, // Highlight total amount
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // List of individual expenses
          Expanded(
            child: _expenses.isEmpty
                ? const Center(
                    child: Text(
                      'No expenses recorded yet.',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    itemCount: _expenses.length,
                    itemBuilder: (context, index) {
                      final expense = _expenses[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.brown[100],
                            child: Icon(
                              _getCategoryIcon(expense['category']),
                              color: Colors.brown[800],
                            ),
                          ),
                          title: Text(
                            expense['description'],
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            '${expense['category']} - ${expense['date']}',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          trailing: Text(
                            '-₱${expense['amount'].toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  Colors.redAccent, // Indicate expense with red
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
