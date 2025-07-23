// receipt.dart

import 'package:flutter/material.dart';
import 'ordering.dart';
import 'pending.dart';
import 'pending_data.dart'; // ✅ Import global list

class ReceiptPage extends StatelessWidget {
  final List<ReceiptItemData> items;

  const ReceiptPage({super.key, required this.items});

  double get subtotal =>
      items.fold(0, (sum, item) => sum + (item.qty * item.price));
  double get vat => subtotal * 0.12;
  double get total => subtotal + vat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Receipt')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header with Go to Pending
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Receipt Summary',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const PendingPage(), // ✅ No need to pass anything
                      ),
                    );
                  },
                  icon: const Icon(Icons.pending_actions),
                  label: const Text('Go to Pending'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    textStyle: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text('Qty: ${item.qty} x ₱${item.price}'),
                    trailing: Text(
                      '₱${(item.qty * item.price).toStringAsFixed(2)}',
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text('Subtotal'),
              trailing: Text('₱${subtotal.toStringAsFixed(2)}'),
            ),
            ListTile(
              title: const Text('VAT (12%)'),
              trailing: Text('₱${vat.toStringAsFixed(2)}'),
            ),
            ListTile(
              title: const Text('Total'),
              trailing: Text('₱${total.toStringAsFixed(2)}'),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                // ✅ Add this receipt as a separate pending order
                PendingOrderData.pendingOrders.add(List.from(items));

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Receipt sent to printer and added to Pending Orders!',
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.print),
              label: const Text('Print Receipt'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
