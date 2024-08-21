import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/widgets/cu_text_button.dart';
import 'package:hommie/widgets/custom_text.dart';

class Slider2 extends StatelessWidget {
  const Slider2({super.key});

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
              height: 630.h
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28),
              child: CustomText(text: "Get more for your real estates with \nus, We help you have access to \nlow cost and unique real estates.", size: 18, weight: FontWeight.w400, color: Colors.white),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(20),
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
                        Navigator.pushReplacementNamed(context, "UserLoginPage");
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