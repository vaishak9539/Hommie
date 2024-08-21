import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/widgets/cu_text_button.dart';
import 'package:hommie/widgets/custom_text.dart';

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
            image: AssetImage(
                'assets/images/unsplash_yHg6p8vW_Is.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 450.h
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 2),
                  child: Container(
                    height: ScreenUtil().setHeight(100),
                    width: ScreenUtil().setWidth(2),
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, left: 20),
                  child: CustomText(
                      text: "Find Your\n Dream\n Home Today",
                      size: 40,
                      weight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 48),
              child: CustomText(
                  text: "Find Your Dream Home Browse Our\nListing Now",
                  size: 16,
                  weight: FontWeight.w400,
                  color: Colors.white),
            ),
            SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: CustomTextButton(
                    text: "Next",
                    color: Colors.white.withOpacity(0.6),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context,"Slider2");
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      )
    );
  }
}
