import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/view/widgets/cu_inkwell_button.dart';
import 'package:hommie/view/widgets/custom_text.dart';
import 'package:hommie/view/widgets/custom_textfield.dart';
import 'package:hommie/view/widgets/dropdown.dart';
import 'package:hommie/view/user/home/user_account/user_terms_conditions.dart';
import 'package:hommie/view/user/home/user_bottomnavigation.dart';
import 'package:hommie/view/user/login/user_Login.dart';
import 'package:hommie/view/user/userprovider/user_provider_class.dart';
import 'package:provider/provider.dart';

class UserRegister extends StatelessWidget {
  const UserRegister({super.key});

  @override
  Widget build(BuildContext context) {
    final registrationProvider = Provider.of<RegistrationProvider>(context);
    final userstateDropdownProvider =
        Provider.of<UserStateDropdownProvider>(context);
    final userCityDropdownProvider =
        Provider.of<UserCityDropdownProvider>(context);
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
              image: AssetImage(
                  'assets/images/unsplash_yHg6p8vW_Is.png'), // Your image here
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
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
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  cursorColor: myColor.background,
                  hintText: "Contact No",
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CuDropdown(
                        items: userstateDropdownProvider.userstates,
                        onChanged: (newValue) {
                          userstateDropdownProvider.userSelectedState(newValue);
                        },
                        hintText: "StateA",
                        backgroundColor: myColor.background),
                    CuDropdown(
                        items: userCityDropdownProvider.usercity,
                        onChanged: (value) {
                          userCityDropdownProvider.userSelectedCity(value);
                        },
                        hintText: "City",
                        backgroundColor: myColor.background),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextField(
                  hintText: "Email",
                  cursorColor: myColor.background,
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextField(
                  hintText: "Password",
                  cursorColor: myColor.background,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Checkbox(
                        value: registrationProvider.ischecked,
                        onChanged: registrationProvider.toggleCheckbox,
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UserTermsAndConditions(),));
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
                    onTap: () {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => UserBottomNavigation(),));
                    },
                    text: "Register"),
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
                          Navigator.push(context,MaterialPageRoute(builder: (context) => UserLogin(),) );
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
        ));
  }
}
