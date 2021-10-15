import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_project_template/common/data/model/items/hospital_item.dart';
import 'package:flutter_project_template/common/data/model/items/medicine_item.dart';
import 'package:flutter_project_template/common/data/model/profile_data.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  final CollectionReference adminsCollection =
      FirebaseFirestore.instance.collection('Admins');

  Future<void> updateUserData(
      String name, String phoneNo, String email, String image) async {
    return await adminsCollection.doc(uid).set({
      'name': name,
      'phoneNo': phoneNo,
      'email': email,
      'image': image,
    });
  }

  Future<bool> isExistingUser() async {
    final data = await adminsCollection.doc(uid).get();
    return data.exists;
  }

  Stream<Profile> getUserDataStream() {
    final stream = adminsCollection.doc(uid).snapshots();

    return stream.map((updatedDoc) {
      final data = updatedDoc.data() as Map<String, dynamic>;
      final profile = Profile(
        data['name'],
        data['email'],
        data['phoneNo'],
        data['image'],
      );
      return profile;
    });
  }
}

class MedicineService {
  MedicineService();

  final CollectionReference medicineCollection =
      FirebaseFirestore.instance.collection('Medicine');

  Stream<QuerySnapshot<Object?>> getMedicines() {
    final user = FirebaseAuth.instance.currentUser;
    print('User id: ${user?.uid}');

    return medicineCollection.snapshots();
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
}

class HospitalService {
  HospitalService();

  final CollectionReference hospitalCollection =
      FirebaseFirestore.instance.collection('Hospitals');

  Stream<List<HospitalItem>> getHospital() {
    final stream = hospitalCollection.snapshots();
    return stream.map((updatedCollection) {
      final List<HospitalItem> hospitals = [];
      updatedCollection.docs.forEach((element) {
        final dbItem = element.data()! as Map<String, dynamic>;
        final hospital = HospitalItem(
          dbItem['name'],
          dbItem['address'],
          dbItem['latitude'],
          dbItem['longitude'],
          dbItem['type'],
          dbItem['phoneNo'],
        );
        hospitals.add(hospital);
      });
      return hospitals;
    });
  }
}

class OxygenService {
  OxygenService();

  final CollectionReference oxygenCollection =
      FirebaseFirestore.instance.collection('Oxygen_Supplier');

  Stream<QuerySnapshot<Object?>> getOxygen() {
    return oxygenCollection.snapshots();
  }
}
