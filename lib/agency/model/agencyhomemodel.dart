import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Agencyhomemodel {
  Future<List<String>> uploadImages(List<File> images) async {
    List<String> imageUrls = [];
    for (File image in images) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef =
          FirebaseStorage.instance.ref().child('uploads/$fileName');
      UploadTask uploadTask = storageRef.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      imageUrls.add(downloadUrl);
    }
    return imageUrls;
  }

  Future<String> uploadData(
      String typ,
      String name,
      String bedroom,
      String bathroom,
      String furnishing,
      String sqft,
      String totalFloors,
      String carParking,
      String fullAddress,
      String roadName,
      String landmark,
      String pincode,
      String setPrize,
      String description,
      List<String> imageUrls) async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('items');
    DocumentReference docRef = await collectionRef.add({
      "Typ": typ,
      "Name": name,
      "Bedroom": bedroom,
      "Bathroom": bathroom,
      "Furnishing": furnishing,
      "Sqft": sqft,
      "TotalFloors": totalFloors,
      "CarParking": carParking,
      "FullAddress": fullAddress,
      "RoadName": roadName,
      "Landmark": landmark,
      "Pincode": pincode,
      "SetPrize": setPrize,
      "Description": description,
      'imageUrls': imageUrls,
      'CreatedAt': FieldValue.serverTimestamp(),
    });

    return docRef.id; // Return document ID
  }
}
