import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/user/model/user_model.dart';
import 'package:hommie/user/controller/auth_service.dart';
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

  @override
  Widget build(BuildContext context) {

    final userController = Provider.of<UserController>(context);

    // final registrationProvider = Provider.of<RegistrationProvider>(context);

    // final userstateDropdownProvider =
    //     Provider.of<UserStateDropdownProvider>(context);

    // final userCityDropdownProvider =
    //     Provider.of<UserCityDropdownProvider>(context);

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
                      if (formkey.currentState!.validate()) {
                        if (ischecked == true) {
                          final user = UserRegModel(
                            name: userNameController.text,
                            contactNo: userContactNoController.text,
                            state: userStateValue,
                            city: userStateValue,
                            email: userEmailController.text,
                            password: userPasswordController.text,
                            createdAt: DateTime.now(),
                            terms: ischecked,
                          );
                          userController.registerUser(user: user, onError: (e) {
                            print(e);
                          },
                           onSuccess: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => UserBottomNavigation(),));
                          },);
                        //   try {
                        //     final userData =
                        //         await _authService.registerUser(_userModel);
                        //     if (userData != null) {
                        //       Navigator.pushReplacement(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) => UserBottomNavigation(),
                        //         ),
                        //       );
                        //     } else {
                        //       // Show error message to user
                        //       ScaffoldMessenger.of(context).showSnackBar(
                        //         SnackBar(
                        //             content: Text(
                        //                 'Registration failed. Please try again.')),
                        //       );
                        //     }
                        //   } catch (e) {
                        //     // Handle any errors that occur during registration
                        //     print('Error during registration: $e');
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       SnackBar(
                        //           content: Text(
                        //               'An error occurred. Please try again.')),
                        //     );
                        //   }
                        // } else {
                        //   // Show message if terms and conditions are not accepted
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //         content: Text(
                        //             'Please accept the terms and conditions.')),
                        //   );
                        }
                      }
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserLogin(),
                                ));
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
                            // mainAxisAlignment: MainAxisAlignment.start,
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