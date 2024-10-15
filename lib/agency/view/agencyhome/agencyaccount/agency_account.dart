// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/agency/view/agencyhome/agency_history.dart';
import 'package:hommie/agency/view/agencyhome/agency_notification.dart';
import 'package:hommie/agency/view/agencyhome/agencyaccount/agency_profile.dart';
import 'package:hommie/agency/view/agencyhome/agencyaccount/agency_terms_conditions.dart';
import 'package:hommie/agency/view/agencylogin/agency_login.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/custom_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AgencyAccount extends StatefulWidget {
  const AgencyAccount({super.key});

  @override
  State<AgencyAccount> createState() => _AgencyAccountState();
}

class _AgencyAccountState extends State<AgencyAccount> {

void agencyDeleteAccount() {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(
          "Delete Your Account",
          style: TextStyle(color: Colors.red),
        ),
        content: const Text(
          "Are you sure you want to delete your account?",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () async {
              try {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String? agencyId = prefs.getString("agencyUid");

                if (agencyId != null) {
                  // Delete account from Firestore
                  await FirebaseFirestore.instance
                      .collection("Agencies")
                      .doc(agencyId)
                      .delete();

                  // Delete Firebase Authentication account
                  User? user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    await user.delete();  // Deletes user from Firebase Authentication
                  }

                  // Show success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Account deleted successfully"),
                    ),
                  );

                  // Remove agencyId from SharedPreferences
                  await prefs.remove("agencyUid");

                  // Navigate to the login screen
                 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AgencyLogin(),), (route) => false,);
                } else {
                  print("Agency ID is null");
                }
              } catch (e) {
                print("Error deleting account: $e");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error deleting account: $e")),
                );
              }
            },
            child: const Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}


  void agencyLogoutdialogbox() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(
            "Are you sure ?",
            style: TextStyle(fontSize: 15),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "cancel",
                  style: TextStyle(color: Colors.black),
                )),
            TextButton(
                onPressed: () async {
                  try {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.remove("agencyUid");

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Logged out successfully")),
                    );

                    Navigator.pop(context);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AgencyLogin(),
                      ),
                      (route) => false,
                    );
                  } catch (e) {
                    print("Error logging out: $e");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error logging out: $e")),
                    );
                  }
                },
                child: Text(
                  "logout",
                  style: TextStyle(color: Colors.red),
                ))
          ],
        );
      },
    );
  }

  Future<void> _launchEmail(String email, BuildContext context) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    try {
      if (!await launchUrl(emailLaunchUri,
          mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $emailLaunchUri');
      }
    } catch (e) {
      print('Error launching email: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open email client')),
      );
    }
  }

  String? agencyId;
  var agencyName;
  String? agencyEmail;
  String? agencyImageUrl;

  Future<void> _getAgencyDetails() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        agencyId = prefs.getString("agencyUid");
      });

      if (agencyId != null) {
        DocumentSnapshot agencySnapshot = await FirebaseFirestore.instance
            .collection("Agencies")
            .doc(agencyId)
            .get();

        if (agencySnapshot.exists) {
          setState(() {
            agencyName = agencySnapshot["Name"];
            agencyEmail = agencySnapshot["Email"];
            agencyImageUrl = agencySnapshot["ImageUrl"];
            print("object : $agencyName");
            print("object : $agencyEmail");
          });
        }
      }
    } catch (e) {
      print("Error fetching agency details: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _getAgencyDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColor.background,
      appBar: CustomAppBar(
        title: "Account",
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AgencyNotification()),
                );
              },
              icon: Image.asset(
                icons[1],
                width: 25,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage:
                      (agencyImageUrl != null && agencyImageUrl!.isNotEmpty)
                          ? NetworkImage(agencyImageUrl!) as ImageProvider
                          : null,
                  child: (agencyImageUrl == null || agencyImageUrl!.isEmpty)
                      ? const Icon(Icons.person, size: 50)
                      : null,
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: agencyName ?? "Name not available",
                  size: 16,
                  weight: FontWeight.w400,
                  color: myColor.textcolor,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: "$agencyEmail",
                  size: 16,
                  weight: FontWeight.w400,
                  color: myColor.textcolor,
                ),
              ],
            ),
            SizedBox(height: 30.h),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AgencyProfile(),
                  ),
                );
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: CustomText(
                      text: "Edit Profile",
                      size: 20,
                      weight: FontWeight.w400,
                      color: myColor.textcolor,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 25),
                  child: CustomText(
                    text: "Dark Mode",
                    size: 20,
                    weight: FontWeight.w400,
                    color: myColor.textcolor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15, top: 10),
                  child: const Icon(
                    Icons.toggle_off,
                    size: 40,
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AgencyHistory(),
                  ),
                );
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 25),
                    child: CustomText(
                      text: "History",
                      size: 20,
                      weight: FontWeight.w400,
                      color: myColor.textcolor,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AgencyTermsConditions(),
                  ),
                );
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 25),
                    child: CustomText(
                      text: "Terms & Conditions",
                      size: 20,
                      weight: FontWeight.w400,
                      color: myColor.textcolor,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                _launchEmail("Vaishakp2024@gmail.com", context);
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25, left: 20),
                    child: CustomText(
                      text: "Contact us",
                      size: 20,
                      weight: FontWeight.w400,
                      color: myColor.textcolor,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                agencyDeleteAccount();
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25, left: 20),
                    child: CustomText(
                      text: "Delete Account",
                      size: 20,
                      weight: FontWeight.w400,
                      color: myColor.errortext,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                agencyLogoutdialogbox();
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25, left: 20),
                    child: CustomText(
                      text: "Logout",
                      size: 20,
                      weight: FontWeight.w400,
                      color: myColor.textcolor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
