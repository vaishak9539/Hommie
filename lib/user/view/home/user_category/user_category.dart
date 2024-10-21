import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/custom_text.dart';
import 'package:hommie/user/view/home/user_category/user_view_Apartment.dart';
import 'package:hommie/user/view/home/user_category/user_view_home.dart';
import 'package:hommie/user/view/home/user_category/user_view_lands.dart';
import 'package:hommie/user/view/home/user_category/user_view_villa.dart';
import 'package:hommie/user/view/home/user_notification.dart';

class UserCategory extends StatelessWidget {
  const UserCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColor.background,
      appBar: CustomAppBar(
        automaticallyImplyLeading: false,
        title: "Category",
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => UserNotification(),));
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
          children: [
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserViewHome(),));
                  },
                  child: SizedBox(
                    width: 145.w,
                    height: 130.h,
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
                              text: "Home",
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserViewVilla(),));
                  },
                  child: SizedBox(
                    width: 145.w,
                    height: 130.h,
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
                              text: "Villa",
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
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserViewApartment(),));
                  },
                  child: SizedBox(
                    width: 145.w,
                    height: 130.h,
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
              // Navigator.push(context, MaterialPageRoute(builder: (context) => UserViewLands(),));

                  },
                  child: SizedBox(
                    width: 145.w,
                    height: 130.h,
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
