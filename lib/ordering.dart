import 'package:flutter/material.dart';
import 'profile.dart';
import 'main.dart';
import 'user.dart';
import 'dashboard.dart';
import 'inventory.dart';
import 'receipt.dart';
import 'hotcoffee.dart';
import 'colddrinks.dart';
import 'fruittea.dart';
import 'meal.dart';
import 'classicmilktea.dart';
import 'premiumilktea.dart';
import 'frappe.dart';
import 'milklatte.dart';
import 'sandwiches.dart';
import 'xbite.dart';
import 'barkadameal.dart';

void main() {
  runApp(const OrderingPage());
}

class ReceiptItemData {
  final String name;
  final int qty;
  final int price;

  ReceiptItemData({required this.name, required this.qty, required this.price});
}

class OrderingPage extends StatelessWidget {
  const OrderingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter UI',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Inter'),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All items';
  int _selectedIndex = 0;
  List<ReceiptItemData> selectedItems = [];
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  final Map<String, List<String>> categoryItems = {
    'All items': [
      'HOT\nCOFFEE',
      'COLD\nDRINKS',
      'CLASSIC\nMILKTEA',
      'PREMIUM\nMILKTEA',
      'FRAPPE',
      'MILK\nLATTE',
      'FRUIT\nTEA',
      'MEAL',
      'XBITE\nBURGER',
      'BARKADA\nMEAL',
      'SANDWICHES',
    ],
    'Coffee': ['HOT\nCOFFEE'],
    'Milktea': ['CLASSIC\nMILKTEA', 'PREMIUM\nMILKTEA'],
    'Meals': ['MEAL', 'XBITE\nBURGER', 'BARKADA\nMEAL', 'SANDWICHES'],
    'Drinks': ['FRUIT\nTEA', 'COLD\nDRINKS'],
  };

  List<String> get filteredItems {
    final allItems = categoryItems.values
        .expand((list) => list)
        .toSet()
        .toList();
    final baseItems = selectedCategory == 'All items'
        ? allItems
        : categoryItems[selectedCategory] ?? [];

    if (searchQuery.isEmpty) return baseItems;

    return allItems
        .where((item) => item.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  void addItemToReceipt(String name, int price) {
    setState(() {
      final index = selectedItems.indexWhere((item) => item.name == name);
      if (index != -1) {
        selectedItems[index] = ReceiptItemData(
          name: name,
          qty: selectedItems[index].qty + 1,
          price: price,
        );
      } else {
        selectedItems.add(ReceiptItemData(name: name, qty: 1, price: price));
      }
    });
  }

  void openMenuPage(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page)).then(
      (result) {
        if (result != null && result is Map<String, dynamic>) {
          addItemToReceipt(result['name'], result['price']);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MENU',
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
              title: const Text('Home'),
              onTap: () {},
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
              onTap: () => Navigator.pop(context),
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
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          switch (index) {
            case 0:
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Dashboard()),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const InventoryPage()),
              );
              break;
          }
        },
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),

          // CHARGE BUTTON
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReceiptPage(items: selectedItems),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'CHARGE',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₱${selectedItems.fold<double>(0, (sum, item) => sum + (item.qty * item.price)).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // CATEGORY + QR + SEARCH
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedCategory,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: categoryItems.keys
                        .map(
                          (value) => DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          ),
                        )
                        .toList(),
                    onChanged: (value) =>
                        setState(() => selectedCategory = value!),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.qr_code_scanner, color: Colors.grey),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search',
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, color: Colors.grey),
                              onPressed: () {
                                searchController.clear();
                                setState(() => searchQuery = '');
                              },
                            )
                          : const Icon(Icons.search, color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          const SizedBox(height: 8),

          // MENU GRID
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: filteredItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return ElevatedButton(
                    onPressed: () {
                      if (item.contains('HOT')) {
                        openMenuPage(const HotCoffeeMenuPage());
                      } else if (item.contains('COLD')) {
                        openMenuPage(const IcedCoffeeMenuPage());
                      } else if (item.contains('CLASSIC')) {
                        openMenuPage(const ClassicMilkteaPage());
                      } else if (item.contains('PREMIUM')) {
                        openMenuPage(const PremiumMilkteaPage());
                      } else if (item.contains('FRAPPE')) {
                        openMenuPage(const FrappeMenuPage());
                      } else if (item.contains('MILK')) {
                        openMenuPage(const MilkLatteMenuPage());
                      } else if (item.contains('FRUIT')) {
                        openMenuPage(const FruitTeaMenuPage());
                      } else if (item.contains('SANDWICHES')) {
                        openMenuPage(const SandwichesMenuPage());
                      } else if (item.contains('XBITE')) {
                        openMenuPage(const BurgerMenuPage());
                      } else if (item.contains('BARKADA')) {
                        openMenuPage(const BarkadaMenuPage());
                      } else if (item.contains('MEAL')) {
                        openMenuPage(const MealMenuPage());
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('You tapped on: $item')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[500],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(10),
                    ),
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          item,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
