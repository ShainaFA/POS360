import 'package:flutter/material.dart';

class MealMenuPage extends StatefulWidget {
  const MealMenuPage({super.key});

  @override
  State<MealMenuPage> createState() => _MealMenuPageState();
}

class _MealMenuPageState extends State<MealMenuPage> {
  final List<Map<String, dynamic>> meals = [
    {
      'name': 'Chicken Meal',
      'prices': {'Meal 1': 99, 'Meal 2': 119, 'Meal 3': 129},
      'selectedSize': 'Meal 1',
    },
  ];

  void _onSizeChanged(int index, String? newSize) {
    if (newSize != null) {
      setState(() {
        meals[index]['selectedSize'] = newSize;
      });
    }
  }

  void _buyNow(int index) {
    final meal = meals[index];
    final size = meal['selectedSize'];
    final price = meal['prices'][size];
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('You bought ${meal['name']} ($size) - ₱$price'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MEAL MENU',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: meals.length,
        itemBuilder: (context, index) {
          final meal = meals[index];
          final prices = meal['prices'] as Map<String, int>;
          final selectedSize = meal['selectedSize'] as String;
          final price = prices[selectedSize]!;

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.fastfood, color: Colors.brown),
                    title: Text(
                      meal['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      '₱$price',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: prices.keys.map((size) {
                      return Row(
                        children: [
                          Radio<String>(
                            value: size,
                            groupValue: selectedSize,
                            onChanged: (value) => _onSizeChanged(index, value),
                            activeColor: Colors.brown,
                          ),
                          Text(size),
                        ],
                      );
                    }).toList(),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: () => _buyNow(index),
                      icon: const Icon(Icons.shopping_bag),
                      label: const Text('Buy'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
