import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hommie/agency/view/agencyhome/agency_bottomnav.dart';
import 'package:hommie/agency/view/agencyhome/agencyaccount/agency_terms_conditions.dart';
import 'package:hommie/agency/view/agencylogin/agency_login.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/widgets/cu_inkwell_button.dart';
import 'package:hommie/widgets/custom_text.dart';
import 'package:hommie/widgets/custom_textfield.dart';
import 'package:hommie/widgets/dropdown.dart';

class AgencyRegister extends StatefulWidget {
  const AgencyRegister({super.key});

  @override
  State<AgencyRegister> createState() => _AgencyRegisterState();
}

class _AgencyRegisterState extends State<AgencyRegister> {
  final formkey = GlobalKey<FormState>();

  final agencynameController = TextEditingController();
  final agencycontactNoController = TextEditingController();
  final agencyemailController = TextEditingController();
  final agencypasswordController = TextEditingController();
  final agencylicenceController = TextEditingController();

  bool ischecked = false;

  final List<String> agencystate = ["Kerala"];
  String agencyStateValue = "";
  final List<String> agencyCity = [
    "Kozhikode",
    "Wayanad",
    "Palakkad",
    "Malappuram",
    "Kannur",
  ];
  String agencyCityValue = "";

  @override
  void dispose() {
    agencynameController.dispose();
    agencycontactNoController.dispose();
    agencyemailController.dispose();
    agencypasswordController.dispose();
    agencylicenceController.dispose();
    super.dispose();
  }

  Future<void> validationCheckingAgency() async {
    if (formkey.currentState!.validate()) {
      if (ischecked == true) {
        try {
          UserCredential userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: agencyemailController.text,
            password: agencypasswordController.text,
          );
          String agencyAuthenticationUid = userCredential.user!.uid;

          // Save to Firestore
          await FirebaseFirestore.instance
              .collection("Agencies") // Updated collection name
              .doc(agencyAuthenticationUid)
              .set({
            "Name": agencynameController.text,
            "ContactNo": agencycontactNoController.text,
            "State": agencyStateValue,
            "City": agencyCityValue,
            "Licence": agencylicenceController.text, // Use text property
            "Email": agencyemailController.text,
            "Password": agencypasswordController.text,
            "Terms": ischecked,
            "AuthUid": agencyAuthenticationUid,
            'CreatedAt': DateTime.now(),
            "ImageUrl" : '',
          });

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AgencyLogin(),
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
                SizedBox(height: 50.h),
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
                  height: ScreenUtil().setHeight(18),
                ),
                CustomTextField(
                  hintText: "Name",
                  cursorColor: myColor.background,
                  controller: agencynameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your name";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(18),
                ),
                CustomTextField(
                  cursorColor: myColor.background,
                  hintText: "Contact No",
                  controller: agencycontactNoController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your number";
                    }
                    if (value.length < 10) {
                      return "Contact number must be at least 10 digits";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(18),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CuDropdown(
                      items: agencystate,
                      onChanged: (String? value) {
                        setState(() {
                          agencyStateValue = value!;
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
                      items: agencyCity,
                      onChanged: (String? value) {
                        setState(() {
                          agencyCityValue = value!;
                        });
                      },
                      hintText: "City",
                      backgroundColor: myColor.background,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please select a city";
                        }
                        return null;
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(18),
                ),
                CustomTextField(
                  hintText: "Licence or Aadhaar No",
                  cursorColor: myColor.background,
                  controller: agencylicenceController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your licence or Aadhaar number";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(18),
                ),
                CustomTextField(
                  hintText: "Email",
                  cursorColor: myColor.background,
                  controller: agencyemailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(18),
                ),
                CustomTextField(
                  hintText: "Password",
                  cursorColor: myColor.background,
                  controller: agencypasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password";
                    }
                    if (!RegExp(r'[A-Z]').hasMatch(value)) {
                      return 'Uppercase letter is missing';
                    }
                    if (!RegExp(r'[a-z]').hasMatch(value)) {
                      return 'Lowercase letter is missing';
                    }
                    if (!RegExp(r'[0-9]').hasMatch(value)) {
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
                          });
                        },
                        activeColor: Color(0xff3FA2F6),
                      ),
                    ),
                    CustomText(
                      text: "I Agree with ",
                      size: 11,
                      weight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AgencyTermsConditions()));
                      },
                      child: CustomText(
                        text: "Terms & conditions",
                        size: 11,
                        weight: FontWeight.w400,
                        color: Color(0xff3FA2F6),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(13),
                ),
                CustomInkwellButton(
                  onTap: () {
                    validationCheckingAgency();
                  },
                  text: "Register",
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(15),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: "Already have an account?",
                      size: 12,
                      weight: FontWeight.w400,
                      color: Colors.white,
                    ),
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
                          color: Color(0xff3FA2F6),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(15),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: ScreenUtil().setHeight(2),
                      width: ScreenUtil().setWidth(100),
                      color: Colors.white,
                    ),
                    CustomText(
                      text: "Or Sign with",
                      size: 12,
                      weight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    Container(
                      height: ScreenUtil().setHeight(2),
                      width: ScreenUtil().setWidth(100),
                      color: Colors.white,
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        // Handle Google sign-in
                      },
                      child: Container(
                        height: ScreenUtil().setHeight(42),
                        width: ScreenUtil().setWidth(250),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(31),
                          color: Color(0xffFFFFFF),
                        ),
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
                                color: Colors.black,
                              ),
                            ),
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
      ),
    );
  }
}
