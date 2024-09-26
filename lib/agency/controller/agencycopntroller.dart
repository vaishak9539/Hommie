import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hommie/agency/model/agencymodel.dart';

class AgencyController extends ChangeNotifier {
  final _collection = FirebaseFirestore.instance.collection("AgencyCollection");

  Future<void> registerAgency({
    required AgencyRegModel agency,
    required ValueChanged<Exception?> onError,
    required void Function() onSuccess,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: agency.email,
        password: agency.password,
      );

      String agencyAuthUid = userCredential.user!.uid;
      agency.authUid = agencyAuthUid;

      await _collection.doc(agencyAuthUid).set(agency.tojson());
      notifyListeners();
      onSuccess();
    } catch (e) {
      notifyListeners();
      onError(Exception("Failed to register: $e"));
    }
  }

  Future<void> loginAgency({
    required String email,
    required String password,
    required ValueChanged<Exception?> onError,
    required void Function() onSuccess,
  }) async {
    var querySnapshot = await _collection.where("Email", isEqualTo: email).limit(1).get();

    if (querySnapshot.docs.isNotEmpty) {
      try {
        var agencyData = querySnapshot.docs.first.data();
        var passwordFromDB = agencyData["Password"];

        if (password == passwordFromDB && password.isNotEmpty) {
          var agencyUid = agencyData ["AuthUid"];
          if (agencyData.isNotEmpty) {
            
          }
        }
      } catch (e) {
        
      }
    }
  }
}
