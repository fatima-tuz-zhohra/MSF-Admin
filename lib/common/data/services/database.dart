import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_project_template/common/data/model/items/blood_donor_item.dart';
import 'package:flutter_project_template/common/data/model/items/hospital_item.dart';
import 'package:flutter_project_template/common/data/model/items/medicine_item.dart';
import 'package:flutter_project_template/common/data/model/items/oxygen_item.dart';
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
    HospitalItem(doc.id, name, address, type, phoneNo, latitude, longitude );
    await doc.set(hospitalItem.toMap());
  }

}

class OxygenService {
  OxygenService();

  final CollectionReference oxygenCollection =
      FirebaseFirestore.instance.collection('Oxygen_Supplier');

  Stream<List<OxygenItem>> getOxygen() {
    final stream = oxygenCollection.snapshots();
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
    OxygenItem(doc.id, name, address, phoneNo, latitude, longitude );
    await doc.set(oxygenItem.toMap());
  }
}

class BloodDonorService {
  BloodDonorService();

  final CollectionReference bloodDonorCollection =
  FirebaseFirestore.instance.collection('Blood_Donors');

  Stream<List<BloodDonorItem>> getBloodDonors() {
    final stream = bloodDonorCollection.snapshots();
    return stream.map((updatedCollection) {
      final List<BloodDonorItem> bloodDonors = [];
      updatedCollection.docs.forEach((element) {
        final dbItem = element.data()! as Map<String, dynamic>;
        final bloodDonor = BloodDonorItem(
          dbItem['id'],
          dbItem['name'],
          dbItem['address'],
          dbItem['phoneNo'],
          dbItem['bloodGroup'],
        );
        bloodDonors.add(bloodDonor);
      });
      return bloodDonors;
    });
  }
  Future<void> delete(BloodDonorItem bloodDonorItem) async {
    await bloodDonorCollection.doc(bloodDonorItem.id).delete().catchError(() {});
  }

  Future<void> addNew(
      String name,
      String address,
      String phoneNo,
      String bloodGroup,

      ) async {
    final doc = bloodDonorCollection.doc();
    final bloodDonorItem =
    BloodDonorItem(doc.id, name, address, phoneNo, bloodGroup );
    await doc.set(bloodDonorItem.toMap());
  }
}
