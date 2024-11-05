import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hommie/agency/view/agencyhome/agency_bottomnav.dart';
import 'package:hommie/agency/view/agencylogin/agency_forgot_password.dart';
import 'package:hommie/agency/view/agencylogin/agency_register.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/widgets/cu_inkwell_button.dart';
import 'package:hommie/widgets/cu_text_button.dart';
import 'package:hommie/widgets/custom_text.dart';
import 'package:hommie/widgets/custom_textfield.dart';

class AgencyLogin extends StatefulWidget {
  const AgencyLogin({super.key});

  @override
  State<AgencyLogin> createState() => _AgencyLoginState();
}

class _AgencyLoginState extends State<AgencyLogin> {
  final formkey = GlobalKey<FormState>();
  final agencyPasswordController = TextEditingController();
  final agencyEmailController = TextEditingController();
  bool agencySecureText = false;


Future<void> agencySignWithEmailAndPassword() async {
  if (formkey.currentState!.validate()) {
    String agencyEmail = agencyEmailController.text.trim();
    String agencyPassword = agencyPasswordController.text.trim();

    try {
      // Use Firebase Authentication for signing in
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: agencyEmail, password: agencyPassword);

      // Get the user ID after successful authentication
      String authUid = userCredential.user!.uid;

      // Now you can fetch additional agency data from Firestore if needed
      var querySnapshot = await FirebaseFirestore.instance
          .collection("Agencies")
          .where("AuthUid", isEqualTo: authUid)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        log("agency login : $authUid");

        // Navigate to the agency dashboard or home screen
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return AgencyBottomNav();
        }));

        Fluttertoast.showToast(
          msg: 'Successfully logged in',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        print('No matching agency found for this user');
        Fluttertoast.showToast(
          msg: 'No agency record found',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print('Authentication failed: $e');
      Fluttertoast.showToast(
        msg: 'Authentication failed: ${e.toString()}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}


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
            image: AssetImage('assets/images/unsplash_yHg6p8vW_Is.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
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
                  controller: agencyEmailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return "Please enter a valid email";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CustomTextField(
                  cursorColor: myColor.background,
                  hintText: "Password",
                  controller: agencyPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your Password";
                    }
                    if (!RegExp((r'[A-Z]')).hasMatch(value)) {
                      return 'Uppercase letter is missing';
                    }
                    if (!RegExp((r'[a-z]')).hasMatch(value)) {
                      return 'Lowercase letter is missing';
                    }
                    if (!RegExp((r'[0-9]')).hasMatch(value)) {
                      return 'Digit is missing';
                    }
                    if (value.length < 8) {
                      return "Password must have at least 8 characters";
                    }
                    return null;
                  },
                  obscureText: agencySecureText,
                  suffixIcon: IconButton(
                    icon: Icon(
                      agencySecureText
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        agencySecureText = !agencySecureText;
                      });
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AgencyForgotPassword(),
                            ));
                      },
                      text: "Forgot Password ?",
                      color: Colors.white.withOpacity(0.6),
                      size: 12,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomInkwellButton(
                    text: "Login",
                    onTap: () {
                      agencySignWithEmailAndPassword();
                    },
                  ),
                ],
              ),
              SizedBox(height: 20.h),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AgencyRegister()));
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
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 42,
                      width: 250,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(31),
                          color: Color(0xffFFFFFF)),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 23),
                            child: Image.asset(
                              "assets/images/google.png",
                              height: 28,
                              width: 28,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: CustomText(
                                text: "continue with google",
                                size: 14,
                                weight: FontWeight.w400,
                                color: Colors.black),
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
      ),
    );
  }
}
