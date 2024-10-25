import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/custom_card.dart';
import 'package:hommie/widgets/custom_text.dart';

class UserAgencyProfileView extends StatefulWidget {
  final agencyid;
  const UserAgencyProfileView({super.key, required this.agencyid,});

  @override
  State<UserAgencyProfileView> createState() => _UserAgencyProfileViewState();
}

class _UserAgencyProfileViewState extends State<UserAgencyProfileView> {
  String? agencyName;
  String? agencyContactNumber;
  String? agencyEmail;
  String? agencyState;
  String? agencyDistrict;
  String? errorMessage;
  bool isLoading = true; // Added isLoading state

  @override
  void initState() {
    super.initState();
    fetchAgencyContactNumber();
  }

  Future<void> fetchAgencyContactNumber() async {
    setState(() {
      isLoading = true; // Start loading
    });
    
    try {
      DocumentSnapshot agencyDoc = await FirebaseFirestore.instance
          .collection('Agencies')
          .doc(widget.agencyid)
          .get();

      if (agencyDoc.exists) {
        setState(() {
          agencyName = agencyDoc.get("Name");

          agencyContactNumber = agencyDoc.get('ContactNo');
          agencyEmail = agencyDoc.get("Email");
          agencyState = agencyDoc.get("State");
          agencyDistrict = agencyDoc.get("City");
          print(agencyName);
          print(agencyContactNumber);
          print(agencyEmail);
          print(agencyState);
          print(agencyDistrict);
          isLoading = false; // Stop loading when data is fetched
        });
      } else {
        setState(() {
          errorMessage = 'Agency not found';
          isLoading = false; // Stop loading on error
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching agency contact: $e';
        isLoading = false; // Stop loading on error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColor.background,
      appBar: CustomAppBar(title: "Agency Details"),
      body: isLoading // Show loading indicator while fetching data
          ? Center(
              child: CircularProgressIndicator(), // Loading widget
            )
          : SingleChildScrollView(
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
                                backgroundImage: AssetImage(icons[5]),
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
                                            text: "Agency Name",
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
                                          maxLines: 1,
                                        overflow: TextOverflow.clip,
                                          text: agencyName ?? 'N/A', // Display data or N/A if null
                                          size: 15,
                                          weight: FontWeight.w400,
                                          color: myColor.textcolor,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 30),
                                        child: CustomText(
                                          text: agencyContactNumber ?? 'N/A', // Display data or N/A if null
                                          size: 15,
                                          weight: FontWeight.w400,
                                          color: myColor.textcolor,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 30),
                                        child: CustomText(
                                          text: agencyEmail ?? 'N/A', // Display data or N/A if null
                                          size: 15,
                                          weight: FontWeight.w400,
                                          color: myColor.textcolor,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 30),
                                        child: CustomText(
                                          text: agencyState ?? 'N/A', // Display data or N/A if null
                                          size: 15,
                                          weight: FontWeight.w400,
                                          color: myColor.textcolor,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 30),
                                        child: CustomText(
                                          text: agencyDistrict ?? 'N/A', // Display data or N/A if null
                                          size: 15,
                                          weight: FontWeight.w400,
                                          color: myColor.textcolor,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                            if (errorMessage != null)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  errorMessage!,
                                  style: TextStyle(color: Colors.red),
                                ),
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
