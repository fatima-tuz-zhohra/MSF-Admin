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
    await bloodDonorCollection
        .doc(bloodDonorItem.id)
        .delete()
        .catchError(() {});
  }

  Future<void> addNew(
    String name,
    String address,
    String phoneNo,
    String bloodGroup,
  ) async {
    final doc = bloodDonorCollection.doc();
    final bloodDonorItem =
        BloodDonorItem(doc.id, name, address, phoneNo, bloodGroup);
    await doc.set(bloodDonorItem.toMap());
  }
}
