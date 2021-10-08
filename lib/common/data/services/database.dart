

import 'package:cloud_firestore/cloud_firestore.dart';

class MedicineService {
  MedicineService();

  final CollectionReference medicineCollection =
  FirebaseFirestore.instance.collection('Medicine');

  Stream<QuerySnapshot<Object?>> getMedicines() {
    return medicineCollection.snapshots();
  }
}