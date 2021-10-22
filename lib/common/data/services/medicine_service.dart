import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project_template/common/data/model/items/medicine_item.dart';

class MedicineService {
  MedicineService();

  final CollectionReference medicineCollection =
      FirebaseFirestore.instance.collection('Medicine');

  Stream<List<MedicineItem>> getMedicines() {
    final stream =
        medicineCollection.orderBy('name', descending: false).snapshots();
    return stream.map((updatedCollection) {
      final List<MedicineItem> medicines = [];
      updatedCollection.docs.forEach((element) {
        final dbItem = element.data()! as Map<String, dynamic>;
        final medicine = MedicineItem(
          dbItem['id'],
          dbItem['name'],
          dbItem['generic'],
          dbItem['companyName'],
          double.parse("${dbItem['price']}"),
          dbItem['description'],
        );
        medicines.add(medicine);
      });
      return medicines;
    });
  }

  Future<void> delete(MedicineItem medicineItem) async {
    await medicineCollection.doc(medicineItem.id).delete().catchError(() {});
  }

  Future<void> addNew(
    String name,
    String generic,
    String companyName,
    double price,
    String description,
  ) async {
    final doc = medicineCollection.doc();
    final medicineItem =
        MedicineItem(doc.id, name, generic, companyName, price, description);
    await doc.set(medicineItem.toMap());
  }

  Future<void> update(
    String id,
    String name,
    String generic,
    String companyName,
    double price,
    String description,
  ) async {
    final doc = medicineCollection.doc(id);
    final medicineItem =
        MedicineItem(id, name, generic, companyName, price, description);
    await doc.update(medicineItem.toMap());
  }
}
