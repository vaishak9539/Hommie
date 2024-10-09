import 'package:cloud_firestore/cloud_firestore.dart';

class UserRegModel {
  String name;
  String contactNo;
  String state;
  String city;
  String email;
  String password;
  bool terms;
  DateTime createdAt;
  String? authUid;

  UserRegModel(
      {required this.name,
      required this.contactNo,
      required this.state,
      required this.city,
      required this.email,
      required this.password,
      required this. terms,
      required this.createdAt,
       this.authUid});

  //* (FireBase) Json to dart
  factory UserRegModel.fromJson(DocumentSnapshot data) {
    Timestamp timestamp = data["createdAt"] as Timestamp;
    return UserRegModel(
      name: data["name"],
      authUid: data["authUid"],
      contactNo: data["contactNo"],
      state: data["state"],
      city: data["city"],
      email: data["email"],
      password: data["password"],
      terms: data ["Terms"],
       createdAt: timestamp.toDate(),
    );
  }

  //* Dart to Json (FireBase)
  Map<String, dynamic> toJson() {
    return {
      "authUid": authUid,
      "name": name,
      "contactNo": contactNo,
      "state": state,
      "city": city,
      "Terms": terms,
      "email": email,
      "password": password,
      "createdAt": createdAt
    };
  }
}
