import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/view/widgets/cu_text_button.dart';
import 'package:hommie/view/widgets/custom_text.dart';
import 'package:hommie/view/user/login/slider2.dart';

class Slider1 extends StatelessWidget {
  const Slider1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6),
                BlendMode.darken,
              ),
              image: AssetImage(backgroundimage[1]),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 430.h),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.w, bottom: 2.h),
                      child: Container(
                        height: 100.h,
                        width: 2.w,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.h, left: 20.w),
                      child: CustomText(
                          text: "Find Your\n Dream\n Home Today",
                          size: 40.sp,
                          weight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 48.w),
                  child: CustomText(
                      text: "Find Your Dream Home Browse Our\nListing Now",
                      size: 16,
                      weight: FontWeight.w400,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: CustomTextButton(
                        text: "Next",
                        size: 16.sp,
                        color: Colors.white.withOpacity(0.6),
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Slider2(),));
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
