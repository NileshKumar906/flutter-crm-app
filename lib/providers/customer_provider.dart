import 'package:flutter/material.dart';
import '../services/db_services.dart';

class CustomerProvider extends ChangeNotifier {
  final DBService _db = DBService();

  List<Map> _customers = [];
  String _searchQuery = "";

  List<Map> get customers {
    if (_searchQuery.isEmpty) return _customers;

    return _customers.where((c) {
      return c['name']
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
    }).toList();
  }

  int get total => _customers.length;

  Future<void> load() async {
    _customers = _db.getAll();
    notifyListeners();
  }

  Future<void> addCustomer(Map data) async {
    await _db.add(data);
    await load();
  }

  Future<void> deleteCustomer(int index) async {
    await _db.delete(index);
    await load();
  }

  Future<void> updateCustomer(int index, Map data) async {
    await _db.update(index, data);
    await load();
  }

  void search(String value) {
    _searchQuery = value;
    notifyListeners();
  }
}