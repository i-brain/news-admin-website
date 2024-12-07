import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'request.dart';

abstract class IAuthRepository {
  Future<void> logout();
  Future<void> login(LoginRequest request);
}

class AuthRepository implements IAuthRepository {
  FirebaseAuth auth = FirebaseAuth.instance;

  final collectionRef = FirebaseFirestore.instance.collection('users');

  @override
  Future<void> login(LoginRequest request) async {
    await auth.signInWithEmailAndPassword(
      email: request.email,
      password: request.password,
    );
  }

  @override
  Future<void> logout() {
    return auth.signOut();
  }
}
