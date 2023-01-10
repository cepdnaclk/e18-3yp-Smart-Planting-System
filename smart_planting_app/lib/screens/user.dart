import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser{
  final String id;
  final String username;
  final String email;
  final String password;
  final String photoUrl;
  final String about;

  AppUser({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.photoUrl,
    required this.about,
});

  factory AppUser.fromDocument(DocumentSnapshot doc) {
    return AppUser(
        id: doc['userId'],
        username: doc['username'],
        email: doc['email'],
        password: doc['password'],
        photoUrl: doc['photoUrl'],
        about: doc['about']
    );
  }

  static AppUser fromJson(Map<String, dynamic> json) => AppUser(
      id: json['userId'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      photoUrl: json['photoUrl'],
      about: json['about']
  );

}

