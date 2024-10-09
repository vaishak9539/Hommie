// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:hommie/agency/model/agencyprofilemodel.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AgencyProfileController extends ChangeNotifier {
//   AgencyProfileModel? _agency;
//   bool isLoading = false;
//   XFile? pick;
//   File? image;

//   AgencyProfileModel? get agency => _agency;

//   // Fetch agency profile details from Firestore
//   Future<void> fetchAgencyDetails() async {
//     isLoading = true;
//     notifyListeners();

//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? agencyId = prefs.getString("agencyUid");

//       if (agencyId != null && agencyId.isNotEmpty) {
//         DocumentSnapshot agencySnapshot = await FirebaseFirestore.instance
//             .collection("AgencyCollection")
//             .doc(agencyId)
//             .get();

//         if (agencySnapshot.exists) {
//           _agency = AgencyProfileModel.fromFirestore(
//               agencySnapshot.data() as Map<String, dynamic>);
//         }
//       }
//     } catch (e) {
//       print('Error fetching agency details: $e');
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }

//   // Update agency profile data in Firestore
//   Future<void> updateAgencyData(AgencyProfileModel updatedAgency) async {
//     isLoading = true;
//     notifyListeners();

//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? agencyId = prefs.getString("agencyUid");

//       if (agencyId != null && agencyId.isNotEmpty) {
//         await FirebaseFirestore.instance
//             .collection("AgencyCollection")
//             .doc(agencyId)
//             .update(updatedAgency.toFirestore());
//       }
//     } catch (e) {
//       print("Error updating agency data: $e");
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }

//   // Pick image from gallery
//   Future<void> pickImage() async {
//     ImagePicker picker = ImagePicker();
//     pick = await picker.pickImage(source: ImageSource.gallery);
//     if (pick != null) {
//       image = File(pick!.path);
//       notifyListeners();
//     }
//   }

//   // Upload image to Firebase Storage and get download URL
//   Future<String?> uploadProfileImage() async {
//     if (image != null) {
//       try {
//         var ref = FirebaseStorage.instance
//             .ref()
//             .child('AgencyProfileImage')
//             .child(DateTime.now().millisecondsSinceEpoch.toString());
//         await ref.putFile(image!);
//         return await ref.getDownloadURL();
//       } catch (e) {
//         print("Error uploading image: $e");
//         return null;
//       }
//     }
//     return null;
//   }
// }
