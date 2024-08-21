import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/widgets/cu_inkwell_button.dart';
import 'package:hommie/widgets/custom_text.dart';
import 'package:hommie/widgets/custom_textfield.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

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
              Colors.black.withOpacity(0.6), // Set opacity of the overlay color
              BlendMode.darken, // Choose a blend mode
            ),
            image: AssetImage('assets/images/unsplash_yHg6p8vW_Is.png'), // Your image here
            fit: BoxFit.cover,
          ),
        ),
        child:  SingleChildScrollView(
        child: Column(children: [
          SizedBox(
              height: ScreenUtil().setHeight(247),
            ),
          CustomText(text: "Reset Password", size: 30, weight: FontWeight.w500, color: Colors.white),
          SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
          CustomTextField(
            hintText: "New Password",
          ),
          SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            CustomTextField(
            hintText: "New Password",
          ),
          SizedBox(
              height: ScreenUtil().setHeight(30),
            ),
            CustomInkwellButton(onTap: () {
              Navigator.pushReplacementNamed(context, "UserLoginPage");
            },
             text: "Next")
        ],),
      ),
      )
    );
  }
}