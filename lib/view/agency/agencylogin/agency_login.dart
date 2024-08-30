

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/widgets/cu_inkwell_button.dart';
import 'package:hommie/model/utils/widgets/cu_text_button.dart';
import 'package:hommie/model/utils/widgets/custom_text.dart';
import 'package:hommie/model/utils/widgets/custom_textfield.dart';
import 'package:hommie/view/agency/agencyprovider/agency_provider_class.dart';
import 'package:provider/provider.dart';

class AgencyLogin extends StatelessWidget {
  const AgencyLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final agencyObscureTextProvider = Provider.of<AgencyObscuretextOProvider>(context);
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
            image: AssetImage('assets/images/unsplash_yHg6p8vW_Is.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 250.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28),
              child: CustomText(
                text: "Welcome Back !",
                size: 28,
                weight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 33, top: 8),
              child: CustomText(
                text: "Login to your account",
                size: 12,
                weight: FontWeight.w500,
                color: Colors.white,
                letterSpacing: 1.7,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CustomTextField(
                cursorColor: myColor.background,
                keyboardType: TextInputType.emailAddress,
                hintText: "Email",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CustomTextField(
                cursorColor: myColor.background,
                hintText: "Password",
                obscureText: agencyObscureTextProvider.agencySecureText,
                suffixIcon: IconButton(
                  icon: Icon(
                    agencyObscureTextProvider.agencySecureText
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    agencyObscureTextProvider.agencyCheckVisibility();
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CustomTextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, "AgencyForgotPassword");
                    },
                    text: "Forgot Password ?",
                    color: Colors.white.withOpacity(0.6),
                    size: 12,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomInkwellButton(
                  text: "Login",
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, "AgencyBottomNav");
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20.h
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                    text: "Don't have an account ?",
                    size: 12,
                    weight: FontWeight.w400,
                    color: Colors.white),
                InkWell(
                  onTap: () {
                 Navigator.pushNamed(context, "AgencyRegister");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: CustomText(
                        text: " Register",
                        size: 12,
                        weight: FontWeight.w400,
                        color: Color(0xff3FA2F6)),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 23.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 2.h,
                  width: 100.w,
                  color: Colors.white,
                ),
                CustomText(
                    text: " Or Sign with",
                    size: 12,
                    weight: FontWeight.w500,
                    color: Colors.white),
                Container(
                  height: 2.h,
                  width: 100.w,
                  color: Colors.white,
                ),
              ],
            ),
            SizedBox(
              height: 20.h
            ),
            Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            
          },
          child: Container(
            height: 42,
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(31),
              color: Color(0xffFFFFFF)
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 23),
                  child: Image.asset("assets/images/google.png",height: 28,width: 28,),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: CustomText(text: "continue with google", size: 14, weight: FontWeight.w400, color: Colors.black),
                )
              ],
            ),
          ),
        ),
      ],
    )
          ]),
        ),
      ),
    );
  }
}
