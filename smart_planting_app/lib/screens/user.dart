import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser{
  final String id;
  late final String username;
  final String email;
  final String password;
  final String about;

  AppUser({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.about,
});

  factory AppUser.fromDocument(DocumentSnapshot doc) {
    return AppUser(
        id: doc.id,
        username: doc['username'],
        email: doc['email'],
        password: doc['password'],
        about: doc['about']
    );
  }

  static AppUser fromJson(Map<String, dynamic> json) => AppUser(
      id: '',
      username: json['username'],
      email: json['email'],
      password: json['password'],
      about: json['about']
  );

}

