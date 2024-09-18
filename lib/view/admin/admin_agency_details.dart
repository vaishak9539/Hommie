import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/view/widgets/appbar.dart';
import 'package:hommie/view/widgets/custom_card.dart';
import 'package:hommie/view/widgets/custom_text.dart';

class AdminAgencyDetails extends StatelessWidget {
  const AdminAgencyDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColor.background,
      appBar: CustomAppBar(title: "Agency Details"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: CustomCard(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.teal.withOpacity(0.2)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 35, bottom: 20),
                        child: CircleAvatar(
                            radius: 45,
                            backgroundImage: AssetImage(
                              icons[5],
                            )),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: CustomText(
                                      text: "agency Name",
                                      size: 15,
                                      weight: FontWeight.w400,
                                      color: myColor.textcolor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: CustomText(
                                      text: "Mobile number",
                                      size: 15,
                                      weight: FontWeight.w400,
                                      color: myColor.textcolor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: CustomText(
                                      text: "Email",
                                      size: 15,
                                      weight: FontWeight.w400,
                                      color: myColor.textcolor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: CustomText(
                                      text: "State",
                                      size: 15,
                                      weight: FontWeight.w400,
                                      color: myColor.textcolor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: CustomText(
                                      text: "District",
                                      size: 15,
                                      weight: FontWeight.w400,
                                      color: myColor.textcolor),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: CustomText(
                                      text: ":",
                                      size: 15,
                                      weight: FontWeight.w400,
                                      color: myColor.textcolor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: CustomText(
                                      text: ":",
                                      size: 15,
                                      weight: FontWeight.w400,
                                      color: myColor.textcolor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: CustomText(
                                      text: ":",
                                      size: 15,
                                      weight: FontWeight.w400,
                                      color: myColor.textcolor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: CustomText(
                                      text: ":",
                                      size: 15,
                                      weight: FontWeight.w400,
                                      color: myColor.textcolor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: CustomText(
                                      text: ":",
                                      size: 15,
                                      weight: FontWeight.w400,
                                      color: myColor.textcolor),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: CustomText(
                                      text: "agency",
                                      size: 15,
                                      weight: FontWeight.w400,
                                      color: myColor.textcolor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: CustomText(
                                      text: "125478956",
                                      size: 15,
                                      weight: FontWeight.w400,
                                      color: myColor.textcolor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: CustomText(
                                      text: "age@gmail.com",
                                      size: 15,
                                      weight: FontWeight.w400,
                                      color: myColor.textcolor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: CustomText(
                                      text: "35,00000",
                                      size: 15,
                                      weight: FontWeight.w400,
                                      color: myColor.textcolor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: CustomText(
                                      text: "35,00000",
                                      size: 15,
                                      weight: FontWeight.w400,
                                      color: myColor.textcolor),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 40.h,
                      )
                    ],
                  ),
                ),
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}