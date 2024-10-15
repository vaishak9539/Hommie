import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/user/view/home/user_account/user_account.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/cu_inkwell_button.dart';
import 'package:hommie/widgets/custom_textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var name = TextEditingController();
  var mobileNo = TextEditingController();
  var email = TextEditingController();
  var city = TextEditingController();
  var state = TextEditingController();

  XFile? pick;
  File? image;
  String? imageurl;
  bool isLoading = false;

  Future<void> pickimage() async {
    ImagePicker picked = ImagePicker();
    pick = await picked.pickImage(source: ImageSource.gallery);
    if (pick != null) {
      setState(() {
        image = File(pick!.path);
      });
    }
  }

 Future<void> getuserDetails() async {
  setState(() {
    isLoading = true;
  });

  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userUid");

    // Print userId for debugging
    print("User ID retrieved from SharedPreferences: $userId");

    if (userId != null && userId.isNotEmpty) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection("Users")
          .doc(userId)
          .get();

      if (userSnapshot.exists) {
        var data = userSnapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          setState(() {
            name.text = data["Name"] ?? "";
            mobileNo.text = data["ContactNo"] ?? "";
            email.text = data["Email"] ?? "";
            city.text = data["City"] ?? "";
            state.text = data["State"] ?? "";

            // Safely check if "ImageUrl" exists before accessing it
            imageurl = data.containsKey("ImageUrl") ? data["ImageUrl"] : "";
          });
        }
      } else {
        print("No document found for User ID: $userId");
        Fluttertoast.showToast(msg: "No User details found.");
      }
    }
  } catch (e) {
    print('Error Fetching User details: $e');
    Fluttertoast.showToast(msg: "Error fetching User details: $e");
  } finally {
    setState(() {
      isLoading = false;
    });
  }
}

  Future<void> profileimg() async {
    if (image != null) {
      var ref = FirebaseStorage.instance
          .ref()
          .child('UserProfileImage')
          .child(DateTime.now().millisecondsSinceEpoch.toString());
      await ref.putFile(image!);
      var imgurl = await ref.getDownloadURL();
      setState(() {
        imageurl = imgurl;
      });
    }
  }


  Future<void> updateagencyData() async {
    if (name.text.isNotEmpty &&
        email.text.isNotEmpty &&
        mobileNo.text.isNotEmpty &&
        state.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var userId = prefs.getString("userUid");
        print("Shared Preference Agency ID : $userId");

        if (userId != null && userId.isNotEmpty) {
          await FirebaseFirestore.instance
              .collection("Users")
              .doc(userId)
              .update({
            "Name": name.text,
            "ContactNo": mobileNo.text,
            "Email": email.text,
            "State": state.text,
            "City": city.text,
            'ImageUrl': imageurl ?? '',
          });
          Fluttertoast.showToast(
            msg: "Profile Successfully Updated",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => UserAccount(),
              ));
        }
      } catch (e) {
        print("Error updating User data: $e");
        Fluttertoast.showToast(
          msg: "Error updating User data: $e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    getuserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColor.background,
      appBar: CustomAppBar(title: "Edit Profile"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 86.w,
                  height: 86.h,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 43,
                        backgroundImage: image != null
                            ? FileImage(
                                image!) // If a new image is picked, show it
                            : (imageurl != null && imageurl!.isNotEmpty)
                                ? NetworkImage(
                                    imageurl!) // If image URL is available, show the network image
                                : AssetImage(
                                        "assets/images/User 1.png") // Fallback to asset image
                                    as ImageProvider<Object>,
                        child: image == null &&
                                (imageurl == null || imageurl!.isEmpty)
                            ? null // No child widget needed when displaying images
                            : null,
                      ),
                      Positioned(
                        bottom: -2,
                        right: -11,
                        child: IconButton(
                          onPressed: () {
                            pickimage();
                          },
                          icon: Image.asset(
                            icons[6],
                            width: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            CuTextField(
              controller: name,
              hintText: "Name",
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CuTextField(
                controller: mobileNo,
                hintText: "Mobile No",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CuTextField(
                controller: email,
                hintText: "Email",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CuTextField(
                controller: state,
                hintText: "state",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CuTextField(
                controller: city,
                hintText: "city",
              ),
            ),
            SizedBox(
              height: 60.h,
            ),
            CustomInkwellButton(
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await profileimg();
                  await updateagencyData();

                  Navigator.pop(context);
                },
                text: "Done")
          ],
        ),
      ),
    );
  }
}
