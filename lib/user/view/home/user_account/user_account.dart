import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/alert.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/custom_text.dart';
import 'package:hommie/user/view/home/user_account/user_history.dart';
import 'package:hommie/user/view/home/user_account/user_profile.dart';
import 'package:hommie/user/view/home/user_account/user_terms_conditions.dart';
import 'package:hommie/user/view/home/user_notification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class UserAccount extends StatefulWidget {
  const UserAccount({super.key});

  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  String? userId;
  var userName;
  String? userEmail;
  String? userImageUrl;

  Future<void> _getuserDetails() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        userId = prefs.getString("userUid");
      });

      if (userId != null) {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection("Users")
            .doc(userId)
            .get();

        if (userSnapshot.exists) {
          setState(() {
            userName = userSnapshot["Name"];
            userEmail = userSnapshot["Email"];
            userImageUrl = userSnapshot["ImageUrl"];
            print("object : $userName");
            print("object : $userEmail");
          });
        }
      }
    } catch (e) {
      print("Error fetching agency details: $e");
    }
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

  @override
  void initState() {
    super.initState();
    _getuserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColor.background,
      appBar: CustomAppBar(
        automaticallyImplyLeading: false,
        title: "Account",
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserNotification(),
                      ));
                },
                icon: Image.asset(
                  icons[1],
                  width: 25,
                ),
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage:
                      (userImageUrl != null && userImageUrl!.isNotEmpty)
                          ? NetworkImage(userImageUrl!) as ImageProvider
                          : null,
                  child: (userImageUrl == null || userImageUrl!.isEmpty)
                      ? const Icon(Icons.person, size: 50)
                      : null,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                    text: userName ?? "Name not available",
                    size: 16,
                    weight: FontWeight.w400,
                    color: myColor.textcolor),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                    text: userEmail ?? "Email not available",
                    size: 16,
                    weight: FontWeight.w400,
                    color: myColor.textcolor),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserProfile(),
                    ));
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: CustomText(
                        text: "Edit Profile",
                        size: 20,
                        weight: FontWeight.w400,
                        color: myColor.textcolor),
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
                      color: myColor.textcolor),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15, top: 10),
                  child: Icon(
                    Icons.toggle_off,
                    size: 40,
                  ),
                )
              ],
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserHistory(),
                    ));
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 25),
                    child: CustomText(
                        text: "History",
                        size: 20,
                        weight: FontWeight.w400,
                        color: myColor.textcolor),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserTermsAndConditions(),
                    ));
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 25),
                    child: CustomText(
                        text: "Terms & Conditions",
                        size: 20,
                        weight: FontWeight.w400,
                        color: myColor.textcolor),
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
                        color: myColor.textcolor),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                userDeleteAccount(context);
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25, left: 20),
                    child: CustomText(
                        text: "Delete Account",
                        size: 20,
                        weight: FontWeight.w400,
                        color: myColor.errortext),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                userLogoutdialogbox(context);
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25, left: 20),
                    child: CustomText(
                        text: "Logout",
                        size: 20,
                        weight: FontWeight.w400,
                        color: myColor.textcolor),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
