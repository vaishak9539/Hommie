import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/model/utils/widgets/appbar.dart';
import 'package:hommie/model/utils/widgets/custom_text.dart';

class Agencyadd extends StatelessWidget {
  const Agencyadd({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColor.background,
      appBar: CustomAppBar(
        title: "Category",
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "User Notification");
                },
                icon: Image.asset(
                  icons[1],
                  width: 25.w,
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
                    Navigator.pushNamed(context, "UserViewHome");
                  },
                  child: SizedBox(
                    width: 150.w,
                    height: 150.h,
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
                    width: 150.w,
                    height: 150.h,
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
                  width: 150.w,
                  height: 150.h,
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
                  width: 150.w,
                  height: 150.h,
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
