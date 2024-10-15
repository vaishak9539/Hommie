import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/user/view/home/user_bottomnavigation.dart';
import 'package:hommie/user/view/login/us_register.dart';
import 'package:hommie/user/view/login/user_forgot_password.dart';
import 'package:hommie/widgets/cu_inkwell_button.dart';
import 'package:hommie/widgets/cu_text_button.dart';
import 'package:hommie/widgets/custom_text.dart';
import 'package:hommie/widgets/custom_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final formkey = GlobalKey<FormState>();
  final userPasswordController = TextEditingController();
  final userEmailController = TextEditingController();
  bool userSecureText = false;



  Future<void> userSignWithEmailAndPassword() async {
    if (formkey.currentState!.validate()) {
      String email = userEmailController.text.trim();
      String password = userPasswordController.text.trim();

      var querySnapshot = await FirebaseFirestore.instance
          .collection("Users")
          .where("Email", isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var userData = querySnapshot.docs.first.data();
        var passwordFromDB = userData['Password'];
        if (passwordFromDB != null && passwordFromDB == password) {
          var userUid = userData["AuthUid"];
          if (userUid != null) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString("userUid", userUid);
          }
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? userId = prefs.getString("userUid");
          print("Shared Preference User ID: $userId");

          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return UserBottomNavigation();
          }));
          Fluttertoast.showToast(
            msg: 'Succesfully loggined',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else {
          print('Incorrect password');
          Fluttertoast.showToast(
            msg: 'Incorrect Password',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } else {
        print('User not found');
        Fluttertoast.showToast(
          msg: 'User not found',
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
        child: Form(
          key: formkey,
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
                  controller: userEmailController,
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
                  controller: userPasswordController,
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
                  obscureText: userSecureText,
                  suffixIcon: IconButton(
                    icon: Icon(
                      userSecureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        userSecureText = !userSecureText;
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
                              builder: (context) => UserForgotPassword(),
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
                      userSignWithEmailAndPassword();
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
                            builder: (context) => UserRegister(),
                          ));
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
                      height: 42.h,
                      width: 250.w,
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
