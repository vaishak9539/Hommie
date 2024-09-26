// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class AgencyRegModel {
//   String name = "";
//   String contactNo = "";
//   String state = "";
//   String city = "";
//   String licence = "";
//   String email = "";
//   String password = "";
//   bool terms =false;

//   String? agencyName(String value) {
//     if (value.isEmpty) {
//       return "Name is Empty";
//     }
//     return null;
//   }

//   String? agencyContactNo(String value) {
//     if (value.isEmpty) {
//       return "Name is Empty";
//     }
//     return null;
//   }

//   String? agencyState(String value) {
//     if (value.isEmpty) {
//       return "Name is Empty";
//     }
//     return null;
//   }

//   String? agencyCity(String value) {
//     if (value.isEmpty) {
//       return "Name is Empty";
//     }
//     return null;
//   }

//   String? agencyLicence(String value) {
//     if (value.isEmpty) {
//       return "Name is Empty";
//     }
//     return null;
//   }

//   String? agencyEmail(String value) {
//     if (value.isEmpty) {
//       return "Name is Empty";
//     }
//     return null;
//   }

//   String? agencyPassword(String value) {
//     if (value.isEmpty) {
//       return "Name is Empty";
//     }
//     return null;
//   }

//   Future registerAgency() async {
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(email: email, password: password);
//           String agencyAuthenticationUid = userCredential.user!.uid;

//           await FirebaseFirestore.instance.collection("AgencyCollection").doc(agencyAuthenticationUid).set({
//             "Name": name,
//             "ContactNo" : contactNo,
//             "State" : state,
//             "City" : city,
//             "Licence" : licence,
//             "Email": email,
//             "Password" : password,
//             "Terms" : terms,
//             "createdAt" : Timestamp.now(),
//           });
//     } catch (e) {
//       print("Failed to register : $e");
//     }
//   }
// }





