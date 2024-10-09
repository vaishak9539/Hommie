import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hommie/agency/model/agencyhomemodel.dart';

class Agencyhomecontroller {
  List<XFile> selectedImages = [];
  final ImagePicker _picker = ImagePicker();
  final Agencyhomemodel _model = Agencyhomemodel();

  // Pick images from gallery
  Future<void> pickImages() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null && images.isNotEmpty) {
      selectedImages = images;
    }
  }

  // Upload data and images
  Future<void> uploadData(
    String name,
    String description,
    String bedroom,
    String bathroom,
    String sqft,
    String totalFloors,
    String carParking,
    String fullAddress,
    String roadName,
    String landmark,
    String pincode,
    String setPrize,
    String furnishingTyp,
    String typ,
  ) async {
    List<File> imagesToUpload =
        selectedImages.map((e) => File(e.path)).toList();

    List<String> imageUrls = await _model.uploadImages(imagesToUpload);
    String documentId = await _model.uploadData(
      typ,
      name,
      bedroom,
      bathroom,
      furnishingTyp,
      sqft,
      totalFloors,
      carParking,
      fullAddress,
      roadName,
      landmark,
      pincode,
      setPrize,
      description,
      imageUrls,
    );

    // Save document ID and agency UID to SharedPreferences
    SharedPreferences spref = await SharedPreferences.getInstance();
    await spref.setString("PropertydocId", documentId);
    print("Document ID saved to SharedPreferences: $documentId");
  }
}
