

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final String uid;

  DatabaseService({required this.uid});

  final CollectionReference adminsCollection =
  FirebaseFirestore.instance.collection('Admins');

  Future<void> updateUserData(String name, String phoneNo, String email,String image) async {
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
}

class MedicineService {
  MedicineService();

  final CollectionReference medicineCollection =
  FirebaseFirestore.instance.collection('Medicine');

  Stream<QuerySnapshot<Object?>> getMedicines() {
    return medicineCollection.snapshots();
  }
}