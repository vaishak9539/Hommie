import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/view/widgets/appbar.dart';
import 'package:hommie/view/widgets/cu_inkwell_button.dart';
import 'package:hommie/view/widgets/custom_text.dart';
import 'package:hommie/view/widgets/custom_textfield.dart';
import 'package:hommie/view/user/login/user_Login.dart';

class UserResetPassword extends StatelessWidget {
  const UserResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          title: "Reset Password",
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
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: CustomText(
                          text: "Reset your password",
                          size: 16,
                          weight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextField(
                  hintText: "New Password",
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextField(
                  hintText: "New Password",
                ),
                SizedBox(
                  height: 30.h,
                ),
                CustomInkwellButton(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserLogin(),
                          ));
                    },
                    text: "Next")
              ],
            ),
          ),
        ));
  }
}
