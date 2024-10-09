import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/cu_inkwell_button.dart';
import 'package:hommie/widgets/custom_textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AgencyProfile extends StatefulWidget {
  const AgencyProfile({super.key});

  @override
  State<AgencyProfile> createState() => _AgencyProfileState();
}

class _AgencyProfileState extends State<AgencyProfile> {
  var name = TextEditingController();
  var mobileNo = TextEditingController();
  var email = TextEditingController();
  var licence = TextEditingController();
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

  
  Future<void> getAgencyDetails() async {
    setState(() {
      isLoading = true;
    });

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? agencyId = prefs.getString("agencyUid");
      print("Shared Preference Agency ID : $agencyId");

      if (agencyId != null && agencyId.isNotEmpty) {
        DocumentSnapshot agencySnapshot = await FirebaseFirestore.instance
            .collection("AgencyCollection")
            .doc(agencyId)
            .get();
        if (agencySnapshot.exists) {
          setState(() {
            name.text = agencySnapshot["Name"];
            mobileNo.text = agencySnapshot["ContactNo"];
            email.text = agencySnapshot["Email"];
            licence.text = agencySnapshot["Licence"];
            city.text = agencySnapshot["City"];
            state.text = agencySnapshot["State"];
            imageurl = agencySnapshot["imageurl"]; 
          });
        }
      }
    } catch (e) {
      print('Error Fetching Agency details: $e');
      Fluttertoast.showToast(msg: "Error fetching Agency details: $e");
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
          .child('AgencyProfileImage')
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
        licence.text.isNotEmpty &&
        state.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var agencyId = prefs.getString("agencyUid");
        print("Shared Preference Agency ID : $agencyId");

        if (agencyId != null && agencyId.isNotEmpty) {
          
          await FirebaseFirestore.instance
              .collection("AgencyCollection")
              .doc(agencyId)
              .update({
            "Name": name.text,
            "ContactNo": mobileNo.text,
            "Email": email.text,
            "State": state.text,
            "City": city.text,
            "Licence": licence.text,
            'imageurl': imageurl ?? '', 
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
          Navigator.pop(context); 
        }
      } catch (e) {
        print("Error updating agency data: $e");
        Fluttertoast.showToast(
          msg: "Error updating agency data: $e",
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
    getAgencyDetails();
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
                        backgroundImage: image != null
                            ? FileImage(image!) as ImageProvider<Object>
                            : (imageurl != null && imageurl!.isNotEmpty)
                                ? NetworkImage(imageurl!)
                                : null,
                        child: image == null &&
                                (imageurl == null || imageurl!.isEmpty)
                            ? Icon(Icons.person, size: 50)
                            : null,
                        radius: 43,
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
                            width: 20,
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
              hintText: "Name",
              controller: name,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CuTextField(
                hintText: "Mobile No",
                controller: mobileNo,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CuTextField(
                hintText: "Email",
                controller: email,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CuTextField(
                hintText: "Licence",
                controller: licence,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CuTextField(
                hintText: "City",
                controller: city,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CuTextField(
                hintText: "State",
                controller: state,
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            CustomInkwellButton(
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await profileimg(); 
                  await updateagencyData(); 
                },
                text: "Done")
          ],
        ),
      ),
    );
  }
}