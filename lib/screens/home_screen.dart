import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/customer_provider.dart';
import 'add_customer_screen.dart';
import 'customer_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mini CRM")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Consumer<CustomerProvider>(
              builder: (_, provider, __) => TextField(
                onChanged: provider.search,
                decoration: InputDecoration(
                  hintText: "Search customer...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<CustomerProvider>(
              builder: (context, provider, _) {
                if (provider.customers.isEmpty) {
                  return const Center(
                    child: Text("No customers yet. Tap + to add."),
                  );
                }

                return ListView.builder(
                  itemCount: provider.customers.length,
                  itemBuilder: (context, index) {
                    final c = provider.customers[index];

                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Text(c['name'],
                            style:
                            const TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: Text(c['phone']),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CustomerDetailScreen(
                                customer: c,
                                index: index,
                              ),
                            ),
                          );
                        },
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () {
                            _confirmDelete(context, provider, index);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddCustomerScreen()),
          );
        },
      ),
    );
  }

  void _confirmDelete(context, provider, index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete"),
        content: const Text("Are you sure?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              provider.deleteCustomer(index);
              Navigator.pop(context);
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }
}