import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project_template/common/data/model/items/oxygen_item.dart';

class OxygenService {
  OxygenService();

  final CollectionReference oxygenCollection =
  FirebaseFirestore.instance.collection('Oxygen_Supplier');

  Stream<List<OxygenItem>> getOxygen() {

    final stream = oxygenCollection.orderBy('name', descending: false).snapshots();

    return stream.map((updatedCollection) {
      final List<OxygenItem> OxygenSuppliers = [];
      updatedCollection.docs.forEach((element) {
        final dbItem = element.data()! as Map<String, dynamic>;
        final oxygen = OxygenItem(
          dbItem['id'],
          dbItem['name'],
          dbItem['address'],
          dbItem['phoneNo'],
          dbItem['latitude'],
          dbItem['longitude'],
        );
        OxygenSuppliers.add(oxygen);
      });
      return OxygenSuppliers;
    });
  }

  Future<void> delete(OxygenItem oxygenItem) async {
    await oxygenCollection.doc(oxygenItem.id).delete().catchError(() {});
  }

  Future<void> addNew(
      String name,
      String address,
      String phoneNo,
      double latitude,
      double longitude,
      ) async {
    final doc = oxygenCollection.doc();
    final oxygenItem =
    OxygenItem(doc.id, name, address, phoneNo, latitude, longitude);
    await doc.set(oxygenItem.toMap());
  }

  Future<void> update(
      String id,
      String name,
      String address,
      String phoneNo,
      double latitude,
      double longitude,
      ) async {
    final doc = oxygenCollection.doc(id);
    final oxygenItem =
    OxygenItem(id, name, address, phoneNo, latitude, longitude);
    await doc.update(oxygenItem.toMap());
  }
}