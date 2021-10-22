import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project_template/common/data/model/items/hospital_item.dart';

class HospitalService {
  HospitalService();

  final CollectionReference hospitalCollection =
  FirebaseFirestore.instance.collection('Hospitals');

  Stream<List<HospitalItem>> getHospital() {
    final stream =
    hospitalCollection.orderBy('name', descending: false).snapshots();

    return stream.map((updatedCollection) {
      final List<HospitalItem> hospitals = [];
      updatedCollection.docs.forEach((element) {
        final dbItem = element.data()! as Map<String, dynamic>;
        final hospital = HospitalItem(
          dbItem['id'],
          dbItem['name'],
          dbItem['address'],
          dbItem['type'],
          dbItem['phoneNo'],
          dbItem['latitude'],
          dbItem['longitude'],
        );
        hospitals.add(hospital);
      });
      return hospitals;
    });
  }

  Future<void> delete(HospitalItem medicineItem) async {
    await hospitalCollection.doc(medicineItem.id).delete().catchError(() {});
  }

  Future<void> addNew(
      String name,
      String address,
      String type,
      String phoneNo,
      double latitude,
      double longitude,
      ) async {
    final doc = hospitalCollection.doc();
    final hospitalItem =
    HospitalItem(doc.id, name, address, type, phoneNo, latitude, longitude);
    await doc.set(hospitalItem.toMap());
  }

  Future<void> update(
      String id,
      String name,
      String address,
      String type,
      String phoneNo,
      double latitude,
      double longitude,
      ) async {
    final doc = hospitalCollection.doc(id);
    final hospitalItem =
    HospitalItem(id, name, address, type, phoneNo, latitude, longitude);
    await doc.update(hospitalItem.toMap());
  }
}