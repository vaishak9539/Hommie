import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/view/widgets/appbar.dart';
import 'package:hommie/view/widgets/cu_inkwell_button.dart';
import 'package:hommie/view/widgets/custom_text.dart';
import 'package:hommie/view/user/login/user_reset_password.dart';
import 'package:pinput/pinput.dart';

class UserOtpVerification extends StatelessWidget {
  const UserOtpVerification({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPintheme = PinTheme(
        width: 56.w,
        height: 56.h,
        textStyle: TextStyle(
          fontSize: 22,
          color: myColor.textcolor,
        ),
        decoration: BoxDecoration(
            color: Colors.teal.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.transparent)));
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          title: " Verification",
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
          child: Column(
            children: [
              SizedBox(
                height: 120.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: CustomText(
                    text: "Enter the code to your phone",
                    size: 15,
                    weight: FontWeight.w400,
                    color: myColor.background),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Pinput(
                  length: 4,
                  defaultPinTheme: defaultPintheme,
                  focusedPinTheme: defaultPintheme.copyWith(
                      decoration: defaultPintheme.decoration!
                          .copyWith(border: Border.all(color: Colors.green))),
                  onCompleted: (pin) => debugPrint(pin),
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              CustomInkwellButton(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserResetPassword(),));
                  },
                  text: "Next")
            ],
          ),
        ));
  }
}
