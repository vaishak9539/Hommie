import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/alert.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/model/utils/widgets/appbar.dart';
import 'package:hommie/model/utils/widgets/custom_text.dart';

class AgencyAccount extends StatelessWidget {
  const AgencyAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColor.background,
      appBar: CustomAppBar(
        title: "Account",
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child:IconButton(onPressed: () {
              Navigator.pushNamed(context, "User Notification");
            }, icon: Image.asset(
              icons[1],
              width: 25,
            ),)
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
                Navigator.pushNamed(context, "AgencyProfile");
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
                Navigator.pushNamed(context, "AgencyHistory");
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
                Navigator.pushNamed(context, "AgencyTermsAndConditions");
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
                Navigator.pushNamed(context, "AgencyFeedback");
              },
              child: Row(
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
            ),
            Row(
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
            InkWell(
              onTap: () {
                agencyDeleteAccount(context);
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
                agencyLogoutdialogbox(context);
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