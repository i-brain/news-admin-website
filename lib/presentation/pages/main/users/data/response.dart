import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetails {
  final String id;
  final String email;
  final String username;
  final Role role;

  UserDetails({
    required this.id,
    required this.email,
    required this.username,
    required this.role,
  });

  factory UserDetails.fromJson(json) => UserDetails(
        id: json["id"],
        email: json["email"],
        username: json["username"],
        role: Role.values.firstWhere((element) => json["role"] == element.value,
            orElse: () => Role.user),
      );

  static List<UserDetails> usersFromSnapshot(
          List<QueryDocumentSnapshot> docs) =>
      List<UserDetails>.from(docs.map((x) => UserDetails.fromJson(x.data())));
}

enum Role {
  user('User', 'user'),
  admin('Admin', 'admin');

  final String title;
  final String value;
  const Role(this.title, this.value);
}
