import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/model/utils/widgets/cu_text_button.dart';
import 'package:hommie/model/utils/widgets/custom_text.dart';

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
                backgroundimage[2]),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 560.h
            ),
            Padding(
              padding:  EdgeInsets.only(left: 28.w),
              child: CustomText(text: "Get more for your real estates with \nus, We help you have access to \nlow cost and unique real estates.", size: 18, weight: FontWeight.w400, color: Colors.white),
            ),
            SizedBox(
              height: 20.h
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(right: 10.w),
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