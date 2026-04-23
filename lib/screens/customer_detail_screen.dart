import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/customer_provider.dart';

class CustomerDetailScreen extends StatelessWidget {
  final Map customer;
  final int index;

  const CustomerDetailScreen({
    super.key,
    required this.customer,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Details")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _item("Name", customer['name']),
            _item("Phone", customer['phone']),
            _item("Note", customer['note']),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<CustomerProvider>().deleteCustomer(index);
                      Navigator.pop(context);
                    },
                    child: const Text("Delete"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final updated = await _editDialog(context);
                      if (updated != null) {
                        context
                            .read<CustomerProvider>()
                            .updateCustomer(index, updated);
                      }
                    },
                    child: const Text("Edit"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _item(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Future<Map?> _editDialog(BuildContext context) {
    final name = TextEditingController(text: customer['name']);
    final phone = TextEditingController(text: customer['phone']);
    final note = TextEditingController(text: customer['note']);

    return showDialog<Map>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: name),
            TextField(controller: phone),
            TextField(controller: note),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, {
                'name': name.text,
                'phone': phone.text,
                'note': note.text,
                'date': customer['date'],
              });
            },
            child: const Text("Save"),
          )
        ],
      ),
    );
  }
}