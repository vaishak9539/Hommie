import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/admin/admin_view/agency_property_list.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/cu_inkwell_button.dart';
import 'package:hommie/widgets/custom_card.dart';
import 'package:hommie/widgets/custom_text.dart';

class AdminAgencyDetails extends StatefulWidget {
  final agencydata;
  final docid;
  const AdminAgencyDetails({super.key, required this.agencydata, required this.docid});

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
    var licence = widget.agencydata['Licence'];
    var state = widget.agencydata["State"];
    var district = widget.agencydata["City"];
    log(widget.docid);
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
                             : AssetImage(
                                          "assets/images/User 1.png") // Fallback to asset image
                                      as ImageProvider<Object>,
                        
                          
                        ),
                      ),
                      Container(
                        child: Row(
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
                                    child: SizedBox(
                                      width: 100.h,
                                      child: CustomText(
                                        maxLines: 1,
                                        
                                          text: email ?? "N/A",
                                          size: 15,
                                          weight: FontWeight.w400,
                                          color: myColor.textcolor),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: Expanded(
                                      child: CustomText(
                                          text: licence ?? "N/A",
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
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                    ],
                  ),
                ),
              ),
              
            ),
            CustomInkwellButton(onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AgencyPropertyList(docid : widget.docid),));
            }, text: "View Propertys")
          ],
        ),
      ),
    );
  }
}
