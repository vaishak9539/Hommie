import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hommie/user/model/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _userCollection = FirebaseFirestore.instance.collection("users");

  Future<UserCredential?> registerUser(UserModel user) async {
    try {
      UserCredential userData = await _auth.createUserWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );
      
      final uid = userData.user!.uid;
      await _userCollection.doc(uid).set({
        "uid": uid,
        "name": user.name,
        "contactNo": user.contactNo,
        "state": user.state,
        "city": user.city,
        "email": user.email,
        "password": user.password,
        "createdAt": user.createdAt,
      });

      return userData;
    } catch (e) {
      print("Error registering user: $e");
      return null;
    }}}