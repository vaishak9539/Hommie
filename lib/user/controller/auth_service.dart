import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hommie/user/model/user_model.dart';

class UserController extends ChangeNotifier {
  final _collection = FirebaseFirestore.instance.collection("UserCollection");

  Future<void> registerUser({
    required UserRegModel user,
    required ValueChanged<Exception?> onError,
    required void Function() onSuccess,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      String userAuthUid = userCredential.user!.uid;
      user.authUid = userAuthUid;

      await _collection.doc(userAuthUid).set(user.toJson());
      notifyListeners();
      onSuccess();
    } catch (e) {
      notifyListeners();
      onError(Exception("Failed to register: $e"));
    }
  }


  // Future<void> loginAgency({
  //   required String email,
  //   required String password,
  //   required ValueChanged<Exception?> onError,
  //   required void Function() onSuccess,
  // }) async {
  //   var querySnapshot =
  //       await _collection.where("Email", isEqualTo: email).limit(1).get();

  //   if (querySnapshot.docs.isNotEmpty) {
  //     try {
  //       var agencyData = querySnapshot.docs.first.data();
  //       var passwordFromDB = agencyData["Password"];

  //       if (password == passwordFromDB && password.isNotEmpty) {
  //         var agencyUid = agencyData["AuthUid"];
  //         if (agencyData.isNotEmpty) {
  //           SharedPreferences spref = await SharedPreferences.getInstance();
  //           await spref.setString("agencyUid", agencyUid);
  //         }
  //         SharedPreferences spref = await SharedPreferences.getInstance();
  //         String? agencyId = spref.getString("agencyUid");
  //         print("SprefAgencyUID : $agencyId");
  //         notifyListeners();
  //         onSuccess();
  //       }else{
  //         notifyListeners();
  //         onError(Exception("Agency not Fount"));
  //       }
        
  //     } catch (e) {
  //       notifyListeners();
  //       onError(Exception("Failed to login: $e") );
  //     }
  //   }
  // }
}