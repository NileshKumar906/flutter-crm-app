class Customer {
  final String name;
  final String phone;
  final String note;
  final String date;

  Customer({
    required this.name,
    required this.phone,
    required this.note,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'note': note,
      'date': date,
    };
  }

  factory Customer.fromMap(Map map) {
    return Customer(
      name: map['name'],
      phone: map['phone'],
      note: map['note'],
      date: map['date'],
    );
  }
}