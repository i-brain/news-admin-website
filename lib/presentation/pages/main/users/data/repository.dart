import 'package:cloud_firestore/cloud_firestore.dart';

import 'update/request.dart';

abstract class IUserRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>> usersStream();
  Future<void> delete(String id);
  Future<void> update(UpdateUserRequest request);
}

class UserRepository implements IUserRepository {
  final _usersCollection = FirebaseFirestore.instance.collection('users');
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> usersStream() {
    return _usersCollection.snapshots();
  }

  @override
  Future<void> delete(String id) async {
    await _usersCollection.doc(id).delete();
  }

  @override
  Future<void> update(UpdateUserRequest request) async {
    await _usersCollection.doc(request.id).update(request.toJson());
  }
}
