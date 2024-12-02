import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name;

  UserModel({required this.name});

  static fromFirestore(QueryDocumentSnapshot<Object?> doc) {}
}
