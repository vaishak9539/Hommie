import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/view/widgets/appbar.dart';
import 'package:hommie/view/widgets/cu_inkwell_button.dart';
import 'package:hommie/view/widgets/custom_text.dart';
import 'package:hommie/view/widgets/custom_textfield.dart';
import 'package:hommie/view/agency/agencylogin/agency_otp_verification.dart';

class AgencyForgotPassword extends StatelessWidget {
  const AgencyForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: "Forgot Password",
        color: myColor.background,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.darken,
            ),
            image: AssetImage('assets/images/unsplash_yHg6p8vW_Is.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 120.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: CustomText(
                  text: "Please enter your registered phone number or email",
                  size: 15,
                  weight: FontWeight.w400,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              CustomTextField(
                hintText: "Enter your Email",
              ),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              CustomInkwellButton(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AgencyOtpVerification(),
                        ));
                  },
                  text: "Next")
            ],
          ),
        ),
      ),
    );
  }
}
