import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? name;
  String? contactNo;
  String? state;
  String? city;
  String? email;
  String? password;
  DateTime? createdAt;
  String? uid;

  UserModel(
      {this.name,
      this.contactNo,
      this.state,
      this.city,
      this.email,
      this.password,
      this.createdAt,
      this.uid});

  //* (FireBase) Json to dart
  factory UserModel.fromJson(DocumentSnapshot data) {
    Timestamp timestamp = data["createdAt"] as Timestamp;
    return UserModel(
      name: data["name"],
      uid: data["uid"],
      contactNo: data["contactNo"],
      state: data["state"],
      city: data["city"],
      email: data["email"],
      password: data["password"],
       createdAt: timestamp.toDate(),
    );
  }

  //* Dart to Json (FireBase)
  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "contactNo": contactNo,
      "state": state,
      "city": city,
      "email": email,
      "password": password,
      "createdAt": createdAt
    };
  }
}
