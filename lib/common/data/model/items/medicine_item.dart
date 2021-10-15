class MedicineItem {
  String? id;
  late String? name;
  late String? generic;
  late String? companyName;
  late double? price;
  late String? description;

  MedicineItem(
    this.id,
    this.name,
    this.generic,
    this.companyName,
    this.price,
    this.description,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'generic': this.generic,
      'companyName': this.companyName,
      'price': this.price,
      'description': this.description,
    };
  }

  factory MedicineItem.fromMap(Map<String, dynamic> map) {
    return MedicineItem(
      map['id'] as String,
      map['name'] as String,
      map['generic'] as String,
      map['companyName'] as String,
      map['price'] as double,
      map['description'] as String,
    );
  }
}
