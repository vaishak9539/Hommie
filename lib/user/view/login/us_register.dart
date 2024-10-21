import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/widgets/cu_inkwell_button.dart';
import 'package:hommie/widgets/custom_text.dart';
import 'package:hommie/widgets/custom_textfield.dart';
import 'package:hommie/widgets/dropdown.dart';
import 'package:hommie/user/view/home/user_account/user_terms_conditions.dart';
import 'package:hommie/user/view/home/user_bottomnavigation.dart';
import 'package:hommie/user/view/login/user_Login.dart';
import 'package:hommie/user/userprovider/user_provider_class.dart';
import 'package:provider/provider.dart';

class UserRegister extends StatefulWidget {
  const UserRegister({super.key});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final formkey = GlobalKey<FormState>();

  final userNameController = TextEditingController();

  final userContactNoController = TextEditingController();

  final userStateController = TextEditingController();

  final userCityController = TextEditingController();

  final userEmailController = TextEditingController();

  final userPasswordController = TextEditingController();

  bool ischecked = false;

  final List<String> userstate = ["Kerala"];
  String userStateValue = "";
  final List<String> userCity = [
    "Kozhikode",
    "Wayanad",
    "Palakkad",
    "Malappuram",
    "Kannur",
  ];
  String userCityValue = "";

   Future<void> validationCheckingUser() async {
    if (formkey.currentState!.validate()) {
      if (ischecked == true) {
        try {
          UserCredential userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: userEmailController.text,
            password: userPasswordController.text,
          );
          String userAuthenticationUid = userCredential.user!.uid;

          // Save to Firestore
          await FirebaseFirestore.instance
              .collection("Users") // Updated collection name
              .doc(userAuthenticationUid)
              .set({
            "Name": userNameController.text,
            "ContactNo": userContactNoController.text,
            "State": userStateValue,
            "City": userCityValue,
            "Email": userEmailController.text,
            "Password": userPasswordController.text,
            "Terms": ischecked,
            "AuthUid": userAuthenticationUid,
            'CreatedAt': DateTime.now(),
          });

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserBottomNavigation(),
              ));

          // Reset form state after successful registration
          formkey.currentState!.reset();
          ischecked = false;
        } on FirebaseAuthException catch (e) {
          String errorMessage = "Registration failed. ${e.message}";

          if (e.code == 'email-already-in-use') {
            errorMessage = "Email is already in use. Please use a different email";
          }

          Fluttertoast.showToast(msg: errorMessage);
        } catch (e) {
          print("Unexpected error during registration: $e");
          Fluttertoast.showToast(msg: "Unexpected error during registration");
        }
      } else {
        Fluttertoast.showToast(msg: "Please agree to the terms and conditions");
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
              child: Column(
                children: [
                  SizedBox(height: 93.h),
                  CustomText(
                    text: "Register",
                    size: 30,
                    weight: FontWeight.w500,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                  CustomText(
                    text: "Create your account",
                    size: 12,
                    weight: FontWeight.w500,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextField(
                    hintText: "Name",
                    cursorColor: myColor.background,
                    controller: userNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    cursorColor: myColor.background,
                    hintText: "Contact No",
                    controller: userContactNoController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your number";
                      }
                      if (value.length < 10) {
                        return "Contact number must be at least 10 digits";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CuDropdown(
                        items: userstate,
                        onChanged: (String? value) {
                          setState(() {
                            userStateValue = value!;
                            print("Agency State is : $userStateValue");
                          });
                        },
                        hintText: "State",
                        backgroundColor: myColor.background,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please select a state";
                          }
                          return null;
                        },
                      ),
                      CuDropdown(
                        items: userCity,
                        onChanged: (String? value) {
                          setState(() {
                            userCityValue = value!;
                            print("Agency City is : $userCityValue");
                          });
                        },
                        hintText: "City",
                        backgroundColor: myColor.background,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please select a state";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextField(
                    hintText: "Email",
                    cursorColor: myColor.background,
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
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextField(
                    hintText: "Password",
                    cursorColor: myColor.background,
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
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Checkbox(
                          value: ischecked,
                          onChanged: (bool? value) {
                            setState(() {
                              ischecked = value!;
                              print("Agency Checkbox value is : $ischecked");
                            });
                          },
                          activeColor: Color(0xff3FA2F6),
                        ),
                      ),
                      CustomText(
                          text: "I Agree with ",
                          size: 11,
                          weight: FontWeight.w400,
                          color: Colors.white),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserTermsAndConditions(),
                              ));
                        },
                        child: CustomText(
                            text: "Terms & conditions",
                            size: 11,
                            weight: FontWeight.w400,
                            color: Color(0xff3FA2F6)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomInkwellButton(
                    onTap: () async {
                     validationCheckingUser();
                    },
                    text: "Register",
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                          text: "Already have an account ?",
                          size: 12,
                          weight: FontWeight.w400,
                          color: Colors.white),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: CustomText(
                                text: "Login",
                                size: 12,
                                weight: FontWeight.w400,
                                color: Color(0xff3FA2F6)),
                          ))
                    ],
                  ),
                  SizedBox(height: 15.h),
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
                    height: 25.h,
                  ),
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
                                  height: 28.h,
                                  width: 28.w,
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
                ],
              ),
            ),
          ),
        ));
  }
}
