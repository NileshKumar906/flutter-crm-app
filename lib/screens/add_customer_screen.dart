import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/customer_provider.dart';

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({super.key});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final phone = TextEditingController();
  final note = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Customer")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _field(name, "Name"),
              const SizedBox(height: 12),
              _field(phone, "Phone", isPhone: true),
              const SizedBox(height: 12),
              _field(note, "Note"),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) return;

                    await context.read<CustomerProvider>().addCustomer({
                      'name': name.text,
                      'phone': phone.text,
                      'note': note.text,
                      'date': DateTime.now().toString(),
                    });

                    Navigator.pop(context);
                  },
                  child: const Text("Save"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(controller, label, {bool isPhone = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: isPhone ? TextInputType.phone : null,
      decoration: InputDecoration(labelText: label),
      validator: (v) {
        if (v!.isEmpty) return "Enter $label";
        if (isPhone && v.length < 10) return "Invalid phone";
        return null;
      },
    );
  }
}