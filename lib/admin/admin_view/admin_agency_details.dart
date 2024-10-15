import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/custom_card.dart';
import 'package:hommie/widgets/custom_text.dart';

class AdminAgencyDetails extends StatefulWidget {
  final agencydata;
  const AdminAgencyDetails({super.key, required this.agencydata});

  @override
  State<AdminAgencyDetails> createState() => _AdminAgencyDetailsState();
}

class _AdminAgencyDetailsState extends State<AdminAgencyDetails> {
  @override
  Widget build(BuildContext context) {
    var userImageUrl = widget.agencydata["ImageUrl"];
    var name = widget.agencydata["Name"];
    var number = widget.agencydata["ContactNo"];
    var email = widget.agencydata["Email"];
    var state = widget.agencydata["State"];
    var district = widget.agencydata["City"];
    
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
                    color: Colors.teal.withOpacity(0.2),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 35, bottom: 20),
                        child: CircleAvatar(
                          radius: 45,
                          backgroundImage: (userImageUrl != null && userImageUrl.isNotEmpty)
                              ? NetworkImage(userImageUrl) as ImageProvider
                              : null,
                          child: (userImageUrl == null || userImageUrl.isEmpty)
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
                                      text: "Licence",
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
                                      text: name ?? "N/A",
                                      size: 15,
                                      weight: FontWeight.w400,
                                      color: myColor.textcolor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: CustomText(
                                      text: number ?? "N/A",
                                      size: 15,
                                      weight: FontWeight.w400,
                                      color: myColor.textcolor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Expanded(
                                    child: CustomText(
                                        text: email ?? "N/A",
                                        size: 15,
                                        weight: FontWeight.w400,
                                        color: myColor.textcolor),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: CustomText(
                                      text: state ?? "N/A",
                                      size: 15,
                                      weight: FontWeight.w400,
                                      color: myColor.textcolor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: CustomText(
                                      text: district ?? "N/A",
                                      size: 15,
                                      weight: FontWeight.w400,
                                      color: myColor.textcolor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
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
