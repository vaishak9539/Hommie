import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/utils/color.dart';
import 'package:hommie/utils/img_path.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/custom_text.dart';

class UserCategory extends StatelessWidget {
  const UserCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColor.background,
      appBar: CustomAppBar(
        title: "Category",
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
          children: [
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                   onTap: () {
                Navigator.pushNamed(context, "UserViewHome");
              },
                  child: SizedBox(
                    width: 150,
                    height: 150,
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
                    Navigator.pushNamed(context, "UserViewVilla");
                  },
                  child: SizedBox(
                    width: 150,
                    height: 150,
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
            SizedBox(
              width: 150,
              height: 150,
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
                        text: "text",
                        size: 15,
                        weight: FontWeight.w400,
                        color: myColor.background,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 150,
              height: 150,
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
                        text: "text",
                        size: 15,
                        weight: FontWeight.w400,
                        color: myColor.background,
                      ),
                    ),
                  ],
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
