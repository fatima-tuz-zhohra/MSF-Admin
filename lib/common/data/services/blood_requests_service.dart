import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project_template/common/constants.dart';
import 'package:flutter_project_template/common/data/model/blood_request_post.dart';

class BloodRequestListService {
  BloodRequestListService();

  final CollectionReference bloodRequestCollection =
      FirebaseFirestore.instance.collection('blood_request');

  Stream<List<BloodRequest>> getBloodPostList() {
    final stream = bloodRequestCollection.snapshots();
    return stream.map((updatedCollection) {
      final List<BloodRequest> bloodRequests = [];
      updatedCollection.docs.forEach((element) {
        final dbItem = element.data()! as Map<String, dynamic>;
        final bloodRequest = BloodRequest.fromMap(dbItem);
        bloodRequests.add(bloodRequest);
      });
      return bloodRequests;
    });
  }

  Future<void> delete(BloodRequest bloodRequest) async {
    await bloodRequestCollection
        .doc(bloodRequest.docId)
        .delete()
        .catchError(() {});
  }

  Future<void> approve(BloodRequest bloodRequest) async {
    final doc = bloodRequestCollection.doc(bloodRequest.docId);
    await doc.update({
      'status': BloodConstants.approved,
    });
  }
}
