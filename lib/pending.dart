// pending.dart

import 'package:flutter/material.dart';
import 'pending_data.dart';

class PendingPage extends StatelessWidget {
  const PendingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = PendingOrderData.pendingOrders;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PENDING ORDERS',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: orders.isEmpty
            ? const Center(child: Text('No pending orders.'))
            : ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final orderItems = orders[index];
                  final orderTotal = orderItems.fold(
                    0,
                    (sum, item) => sum + item.qty * item.price,
                  );

                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order #${index + 1}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          ...orderItems.map(
                            (item) => ListTile(
                              title: Text(item.name),
                              subtitle: Text(
                                'Qty: ${item.qty} x ₱${item.price}',
                              ),
                              trailing: Text(
                                '₱${(item.qty * item.price).toStringAsFixed(2)}',
                              ),
                              dense: true,
                            ),
                          ),
                          const Divider(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Total: ₱${orderTotal.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
