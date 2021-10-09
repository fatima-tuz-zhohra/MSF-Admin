import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_project_template/common/data/model/profile_data.dart';
import 'package:flutter_project_template/feature/home/profile_screen.dart';

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
}