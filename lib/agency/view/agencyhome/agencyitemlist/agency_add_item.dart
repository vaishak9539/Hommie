import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/agency/view/agencyhome/agency_notification.dart';
import 'package:hommie/agency/view/agencyhome/agencyitemlist/agency_add_home_details.dart';
import 'package:hommie/agency/view/agencyhome/agencyitemlist/agency_add_land_details.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/custom_text.dart';

class AgencyaddItem extends StatelessWidget {

  const AgencyaddItem({super.key});

  @override
  Widget build(BuildContext context) {
    List category = ["Home", "Villa", "Apartment", "Land"];
    return Scaffold(
      backgroundColor: myColor.background,
      appBar: CustomAppBar(
        title: "Category",
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
                icons[1],
                width: 25.w,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AgencyAddHomeDetails(
                          typ: category[0], 
                        
                        ),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: 150.w,
                    height: 140.h,
                    child: Card(
                      elevation: 10,
                      shadowColor: myColor.textcolor.withOpacity(0.4),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              backgroundimage[1],
                              color: Colors.black.withOpacity(0.4),
                              colorBlendMode: BlendMode.darken,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Center(
                            child: CustomText(
                              text: category[0],
                              size: 18,
                              weight: FontWeight.w500,
                              color: myColor.background,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AgencyAddHomeDetails(
                          typ: category[1], 
                         // Pass agencyId
                        ),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: 150.w,
                    height: 140.h,
                    child: Card(
                      elevation: 10,
                      shadowColor: myColor.textcolor.withOpacity(0.4),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              backgroundimage[1],
                              color: Colors.black.withOpacity(0.4),
                              colorBlendMode: BlendMode.darken,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Center(
                            child: CustomText(
                              text: category[1],
                              size: 18,
                              weight: FontWeight.w500,
                              color: myColor.background,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AgencyAddHomeDetails(
                          typ: category[2], 
                          
                        ),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: 150.w,
                    height: 140.h,
                    child: Card(
                      elevation: 10,
                      shadowColor: myColor.textcolor.withOpacity(0.4),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              backgroundimage[1],
                              color: Colors.black.withOpacity(0.4),
                              colorBlendMode: BlendMode.darken,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Center(
                            child: CustomText(
                              text: "Apartment",
                              size: 15,
                              weight: FontWeight.w400,
                              color: myColor.background,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AgencyAddLandDetails(
                          typ: category[3], 
                        ),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: 150.w,
                    height: 140.h,
                    child: Card(
                      elevation: 10,
                      shadowColor: myColor.textcolor.withOpacity(0.4),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              backgroundimage[1],
                              color: Colors.black.withOpacity(0.4),
                              colorBlendMode: BlendMode.darken,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Center(
                            child: CustomText(
                              text: "Land",
                              size: 15,
                              weight: FontWeight.w400,
                              color: myColor.background,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
