import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/alert.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/custom_text.dart';
import 'package:hommie/agency/view/agencyhome/agency_history.dart';
import 'package:hommie/agency/view/agencyhome/agency_notification.dart';
import 'package:hommie/agency/view/agencyhome/agencyaccount/agency_profile.dart';
import 'package:hommie/agency/view/agencyhome/agencyaccount/agency_terms_conditions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AgencyAccount extends StatefulWidget {
  const AgencyAccount({super.key});

  @override
  State<AgencyAccount> createState() => _AgencyAccountState();
}

class _AgencyAccountState extends State<AgencyAccount> {
  String? agencyId;

  // Fetch agencyId from shared preferences
  Future<void> _getAgencyId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    agencyId = prefs.getString("agencyUid");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getAgencyId();
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
                icons[1], // Update with your actual notification icon
                width: 25,
              ),
            ),
          ),
        ],
      ),
      body: agencyId != null
          ? StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("AgencyCollection")
                  .doc(agencyId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const Center(
                    child: Text("Agency details not available"),
                  );
                }

                // Fetch data from the snapshot
                var agencyData = snapshot.data!.data() as Map<String, dynamic>;
                String name = agencyData['Name'] ?? 'Name not available';
                String email = agencyData['Email'] ?? 'Email not available';
                String imageurl = agencyData['imageurl'] ?? '';

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: (imageurl.isNotEmpty)
                                ? NetworkImage(imageurl) as ImageProvider
                                : const AssetImage(
                                    'assets/images/default_profile.png'),
                            child: imageurl.isEmpty
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
                            text: name,
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
                            text: email,
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
                      Row(
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
                                color: myColor.errortext,
                              ),
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
                                color: myColor.textcolor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
