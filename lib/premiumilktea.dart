import 'package:flutter/material.dart';

class PremiumMilkteaPage extends StatefulWidget {
  const PremiumMilkteaPage({super.key});

  @override
  State<PremiumMilkteaPage> createState() => _PremiumMilkteaPageState();
}

class _PremiumMilkteaPageState extends State<PremiumMilkteaPage> {
  final List<Map<String, dynamic>> milkteas = [
    {
      'name': 'MATCHA',
      'sizes': {'Medium': 69, 'Large': 79},
      'selectedSize': 'Small',
      'qty': 1,
    },
    {
      'name': 'NUTELLA',
      'sizes': {'Medium': 69, 'Large': 79},
      'selectedSize': 'Small',
      'qty': 1,
    },
    {
      'name': 'OKINAWA',
      'sizes': {'Medium': 69, 'Large': 79},
      'selectedSize': 'Small',
      'qty': 1,
    },
    {
      'name': 'SALTED CARAMEL',
      'sizes': {'Medium': 69, 'Large': 79},
      'selectedSize': 'Small',
      'qty': 1,
    },
    {
      'name': 'WINTERMELON',
      'sizes': {'Medium': 69, 'Large': 79},
      'selectedSize': 'Small',
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
          'PREMIUM MILKTEA',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: milkteas.length,
        itemBuilder: (context, index) {
          final item = milkteas[index];
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
