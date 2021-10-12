import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project_template/common/data/model/user.dart';

class UsersService {
  UsersService();

  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('Users');

  Stream<List<User>> getAllUsers() {
    final stream = _usersCollection.snapshots();

    return stream.map((updatedCollection) {
      final List<User> users = [];
      updatedCollection.docs.forEach((doc) {
          final data = doc.data() as Map<String, dynamic>;
          final user = User.fromMap(data);
          users.add(user);
      });
      return users;
    });
  }
}
