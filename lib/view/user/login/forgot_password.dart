import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/widgets/cu_inkwell_button.dart';
import 'package:hommie/widgets/custom_text.dart';
import 'package:hommie/widgets/custom_textfield.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(
          children: [
              SizedBox(
              height: ScreenUtil().setHeight(247),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28),
              child: CustomText(
                text: "Verify your Email Address",
                size: 28,
                weight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
              SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            
            CustomTextField(
              hintText: "Enter your Email",
            ),
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            CustomInkwellButton(onTap: () {
              Navigator.pushReplacementNamed(context, "UserResetPassword");
            },
             text: "Next")
          ],
        ),
      ),
      ),
    );
  }
}
