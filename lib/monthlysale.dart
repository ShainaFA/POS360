import 'package:flutter/material.dart';
import 'dashboard.dart'; // Ensure DashboardPage is defined in home.dart
import 'main.dart'; // Ensure LoginPage is defined here
import 'user.dart';
import 'ordering.dart';
import 'profile.dart';
import 'inventory.dart'; // Import InventoryPage

void main() {
  runApp(const MonthSale());
}

class MonthSale extends StatelessWidget {
  const MonthSale({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monthly Sales App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey, // A neutral color for the app bar
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Define a consistent text theme for better readability
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: const MonthlySalesScreen(),
    );
  }
}

class MonthlySalesScreen extends StatefulWidget {
  const MonthlySalesScreen({super.key});

  @override
  State<MonthlySalesScreen> createState() => _MonthlySalesScreenState();
}

class _MonthlySalesScreenState extends State<MonthlySalesScreen> {
  int _selectedIndex = 1; // Set to 1 to highlight 'Monthly Sales' initially
  int _currentMonthIndex =
      DateTime.now().month - 1; // 0-indexed for list of months

  final List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  // Dummy sales data for demonstration
  // Map where key is month index (0-11) and value is a list of daily sales
  final Map<int, List<Map<String, dynamic>>> _salesData = {
    0: [
      // January
      {'day': 'Jan 1', 'amount': 1250.00},
      {'day': 'Jan 5', 'amount': 980.50},
      {'day': 'Jan 10', 'amount': 1500.00},
      {'day': 'Jan 15', 'amount': 750.25},
      {'day': 'Jan 20', 'amount': 2100.00},
      {'day': 'Jan 25', 'amount': 1120.00},
      {'day': 'Jan 30', 'amount': 1800.00},
    ],
    1: [
      // February
      {'day': 'Feb 2', 'amount': 1100.00},
      {'day': 'Feb 7', 'amount': 1300.75},
      {'day': 'Feb 14', 'amount': 2500.00},
      {'day': 'Feb 20', 'amount': 900.00},
      {'day': 'Feb 28', 'amount': 1600.00},
    ],
    2: [
      // March
      {'day': 'Mar 3', 'amount': 1400.00},
      {'day': 'Mar 10', 'amount': 1750.50},
      {'day': 'Mar 17', 'amount': 1900.00},
      {'day': 'Mar 25', 'amount': 1200.00},
    ],
    // Add more months with dummy data as needed
    // For simplicity, only a few months are populated.
    // You would fetch real data here.
    DateTime.now().month - 1: [
      // Current month's data
      {'day': 'Day 1', 'amount': 1000.00},
      {'day': 'Day 5', 'amount': 1200.50},
      {'day': 'Day 10', 'amount': 850.00},
      {'day': 'Day 15', 'amount': 1500.00},
      {'day': 'Day 20', 'amount': 950.75},
      {'day': 'Day 25', 'amount': 1300.00},
    ],
  };

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

  void _previousMonth() {
    setState(() {
      _currentMonthIndex =
          (_currentMonthIndex - 1 + _months.length) % _months.length;
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonthIndex = (_currentMonthIndex + 1) % _months.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentMonthSales = _salesData[_currentMonthIndex] ?? [];
    final totalSales = currentMonthSales.fold(
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
          'MONTHLY SALES',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Month Navigation
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.blueGrey[50],
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_left, size: 30),
                    onPressed: _previousMonth,
                  ),
                  Text(
                    _months[_currentMonthIndex],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_right, size: 30),
                    onPressed: _nextMonth,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Total Sales Summary
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.orangeAccent,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      'Total Sales for the Month',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '₱${totalSales.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Daily Sales List
            Text(
              'Daily Sales Details:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[700],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: currentMonthSales.isEmpty
                  ? Center(
                      child: Text(
                        'No sales data available for ${_months[_currentMonthIndex]}.',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: currentMonthSales.length,
                      itemBuilder: (context, index) {
                        final sale = currentMonthSales[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blueGrey[100],
                              child: Text(
                                (index + 1).toString(),
                                style: TextStyle(
                                  color: Colors.blueGrey[800],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            title: Text(
                              sale['day'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: Text(
                              '\$${sale['amount'].toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
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
