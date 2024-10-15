import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/custom_card.dart';
import 'package:hommie/widgets/custom_text.dart';

class AdminUserDetails extends StatefulWidget {
  final userdata;
  const AdminUserDetails({super.key, required this.userdata, });

  @override
  State<AdminUserDetails> createState() => _AdminUserDetailsState();
}

class _AdminUserDetailsState extends State<AdminUserDetails> {
  
  @override
  Widget build(BuildContext context) {
    var userImageUrl = widget.userdata["ImageUrl"] ?? "N/A";
    return Scaffold(
      backgroundColor: myColor.background,
      appBar: CustomAppBar(title: "User Details"),
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
                          backgroundImage:
                      (userImageUrl != null && userImageUrl!.isNotEmpty)
                          ? NetworkImage(userImageUrl!) as ImageProvider
                          : null,
                  child: (userImageUrl == null || userImageUrl!.isEmpty)
                      ? const Icon(Icons.person, size: 50)
                      : null,
                            ),
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
                                      text: "Name",
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
                                      text:  widget.userdata["Name"] ?? "N/A",
                                      size: 15,
                                      weight: FontWeight.w400,
                                      color: myColor.textcolor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: CustomText(
                                      text:  widget.userdata["ContactNo"] ?? "N/A",
                                      size: 15,
                                      weight: FontWeight.w400,
                                      color: myColor.textcolor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: CustomText(
                                      text:  widget.userdata["Email"] ?? "N/A",
                                      size: 15,
                                      weight: FontWeight.w400,
                                      color: myColor.textcolor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: CustomText(
                                      text:  widget.userdata["State"] ?? "N/A",
                                      size: 15,
                                      weight: FontWeight.w400,
                                      color: myColor.textcolor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: CustomText(
                                      text:  widget.userdata["City"] ?? "N/A",
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