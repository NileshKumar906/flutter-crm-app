import 'package:hive/hive.dart';

class DBService {
  final box = Hive.box('customers');

  List<Map> getAll() {
    return box.values.cast<Map>().toList();
  }

  Future<void> add(Map data) async {
    await box.add(data);
  }

  Future<void> delete(int index) async {
    await box.deleteAt(index);
  }

  Future<void> update(int index, Map data) async {
    await box.putAt(index, data);
  }
}