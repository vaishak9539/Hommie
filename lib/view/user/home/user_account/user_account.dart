import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/utils/alert.dart';
import 'package:hommie/utils/color.dart';
import 'package:hommie/utils/img_path.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/custom_text.dart';

class UserAccount extends StatelessWidget {
  const UserAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColor.background,
      appBar: CustomAppBar(
        title: "Account",
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Image.asset(
              icons[1],
              width: 25,
            ),
          ),
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
                Image.asset(
                  icons[5],
                  width: 90,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                    text: "Name",
                    size: 16,
                    weight: FontWeight.w400,
                    color: myColor.textcolor),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                    text: "Name@gmail.com",
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
                Navigator.pushNamed(context, "User Profile");
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
            Row(
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
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, "TermsAndConditions");
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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25, left: 20),
                  child: CustomText(
                      text: "Feedback",
                      size: 20,
                      weight: FontWeight.w400,
                      color: myColor.textcolor),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                userDeleteAccount(
                    "Delete Your Account",
                    "are you sure, you want to delete your account",
                    "delete",
                    "cancel",
                    context);
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
                userLogoutdialogbox("Are you sure ?", "logout", "cancel", context);
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
