import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/alert.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/user/view/login/user_Login.dart';
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

  //    Future<void> _getuserDetails() async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     setState(() {
  //       userId = prefs.getString("userUid");
  //     });
  //   } catch (e) {
  //     print("Error fetching user details: $e");
  //   }
  // }

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
          // Ensure userSnapshot data is not null
          // Map<String, dynamic>? userData =
          //     userSnapshot.data() as Map<String, dynamic>?;

          if (userSnapshot != null) {
            setState(() {
              userName = userSnapshot["Name"] ?? "Name not available";
              userEmail = userSnapshot["Email"] ?? "Email not available";
              // Check if 'ImageUrl' exists in the document data
              userImageUrl = userSnapshot["ImageUrl"];
                  

              print("Name: $userName");
              print("Email: $userEmail");
            });
          }
        }
      }
    } catch (e) {
      print("Error fetching user details: $e");
    }
  }

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
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  String? userUid = prefs.getString("userUid");

                  if (userUid != null) {
                    // Delete account from Firestore
                    await FirebaseFirestore.instance
                        .collection("Agencies")
                        .doc(userUid)
                        .delete();

                    // Delete Firebase Authentication account
                    User? user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                       FirebaseFirestore.instance.collection('Users').doc(user.uid).delete();
      await user.delete();/// Deletes user from Firebase Authentication
                    }

                    // Show success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Account deleted successfully"),
                      ),
                    );

                    // Remove agencyId from SharedPreferences
                    await prefs.remove("agencyUid");
                    Navigator.pop(context);
                    // Navigate to the login screen
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserLogin(),
                      ),
                      (route) => false,
                    );
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
                    await prefs.remove("userUid");

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Logged out successfully")),
                    );

                    Navigator.pop(context);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserLogin(),
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
            //      SizedBox(
            //   height: 30.h,
            // ),
            // StreamBuilder<DocumentSnapshot>(
            //   stream: FirebaseFirestore.instance.collection('Users').doc(userId).snapshots(),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasError) {
            //       return Center(child: Text('Error fetching user data'));
            //     }

            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return Center(child: CircularProgressIndicator());
            //     }

            //     if (!snapshot.hasData || !snapshot.data!.exists) {
            //       return Center(child: Text('No user data available'));
            //     }

            //     // Fetch user data
            //     var userData = snapshot.data!.data() as Map<String, dynamic>?;

            //     if (userData == null) {
            //       return Center(child: Text('No user data available'));
            //     }

            //     // Update the UI fields
            //     userName = userData['Name'] ?? 'Name not available';
            //     userEmail = userData['Email'] ?? 'Email not available';
            //     userImageUrl = userData['ImageUrl'];

            //     return Column(
            //       children: [
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             CircleAvatar(
            //               radius: 40,
            //               backgroundImage: (userImageUrl != null && userImageUrl!.isNotEmpty)
            //                   ? NetworkImage(userImageUrl!) as ImageProvider
            //                   : AssetImage("assets/images/User 1.png") as ImageProvider,
            //             ),
            //           ],
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             CustomText(
            //                 text: userName ?? "Name not available",
            //                 size: 16,
            //                 weight: FontWeight.w400,
            //                 color: myColor.textcolor),
            //           ],
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             CustomText(
            //                 text: userEmail ?? "Email not available",
            //                 size: 16,
            //                 weight: FontWeight.w400,
            //                 color: myColor.textcolor),
            //           ],
            //         ),
            //       ],
            //     );
            //   },
            // ),

            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: (userImageUrl != null &&
                          userImageUrl!.isNotEmpty)
                      ? NetworkImage(userImageUrl!) as ImageProvider
                      : AssetImage(
                              "assets/images/User 1.png") // Fallback to asset image
                          as ImageProvider<Object>,
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
                // userDeleteAccount(context);
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
                        color: myColor.errortext),
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
