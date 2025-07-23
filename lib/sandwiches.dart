import 'package:flutter/material.dart';

class SandwichesMenuPage extends StatefulWidget {
  const SandwichesMenuPage({super.key});

  @override
  State<SandwichesMenuPage> createState() => _SandwichesMenuPageState();
}

class _SandwichesMenuPageState extends State<SandwichesMenuPage> {
  final List<Map<String, dynamic>> coffees = [
    {
      'name': 'GRILLED HAM & CHEESE',
      'sizes': {'Price': 85},
      'selectedSize': 'Price',
      'qty': 1,
    },
    {
      'name': 'GRILLED TRIPLE CHEESE',
      'sizes': {'Price': 75},
      'selectedSize': 'Price',
      'qty': 1,
    },
    {
      'name': 'JUMBO HOTDOG SANDWICH',
      'sizes': {'Price': 59},
      'selectedSize': 'Price',
      'qty': 1,
    },
  ];

  void _addToOrder(Map<String, dynamic> item) {
    String size = item['selectedSize'];
    int price = item['sizes'][size];
    Navigator.pop(context, {
      'name': '${item['name']} ($size)',
      'price': price,
      'qty': item['qty'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SANDWICHES',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: coffees.length,
        itemBuilder: (context, index) {
          final item = coffees[index];
          final sizes = item['sizes'] as Map<String, int>;

          return Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    children: sizes.entries.map((entry) {
                      return RadioListTile<String>(
                        title: Text('${entry.key} - ₱${entry.value}'),
                        value: entry.key,
                        groupValue: item['selectedSize'],
                        onChanged: (value) {
                          setState(() {
                            item['selectedSize'] = value!;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (item['qty'] > 1) item['qty']--;
                          });
                        },
                      ),
                      Text('${item['qty']}'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            item['qty']++;
                          });
                        },
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () => _addToOrder(item),
                        child: const Text('Buy'),
                      ),
                    ],
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
