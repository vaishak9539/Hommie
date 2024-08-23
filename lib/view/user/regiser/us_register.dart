import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/provider/registration_provider.dart';
import 'package:hommie/provider/statedropdownbutton.dart';
import 'package:hommie/utils/color.dart';
import 'package:hommie/view/user/login/user_Login.dart';
import 'package:hommie/view/user/terms/terms_conditions.dart';
import 'package:hommie/widgets/cu_inkwell_button.dart';
import 'package:hommie/widgets/custom_text.dart';
import 'package:hommie/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class UsRegister extends StatelessWidget {
  const UsRegister({super.key});

  @override
  Widget build(BuildContext context) {
    final registrationProvider = Provider.of<RegistrationProvider>(context);
    final stateDropdownButton = Provider.of<StateDropdownButton>(context);
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.black
                    .withOpacity(0.6), // Set opacity of the overlay color
                BlendMode.darken, // Choose a blend mode
              ),
              image: AssetImage(
                  'assets/images/unsplash_yHg6p8vW_Is.png'), // Your image here
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 93.h
                ),
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
                  height: ScreenUtil().setHeight(20),
                ),
                CustomTextField(
                  hintText: "Name",
                  cursorColor: myColor.background,
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                CustomTextField(
                  cursorColor: myColor.background,
                  hintText: "Contact No",
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        cursorColor: myColor.background,
                        hintText: "state",
                        dropdownButton: DropdownButton<String>(
                          value: stateDropdownButton.dropdownValue,
                          dropdownColor: Colors.black,
                          items: stateDropdownButton.category
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white.withOpacity(0.9),
                          ),
                          onChanged: (String? newValue) {
                            // Update the provider's state
                            stateDropdownButton.setSelectedValue(
                              newValue!,
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: CustomTextField(
                        hintText: "District",
                        cursorColor: myColor.background,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                CustomTextField(
                  hintText: "Email",
                  cursorColor: myColor.background,
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TermsAndConditions(),
                              ));
                        },
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "TermsAndConditions");
                          },
                          child: CustomText(
                              text: "Terms & conditions",
                              size: 11,
                              weight: FontWeight.w400,
                              color: Color(0xff3FA2F6)),
                        ))
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(15),
                ),
                CustomInkwellButton(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, "UserButtomNavigation");
                    },
                    text: "Register"),
                SizedBox(
                  height: ScreenUtil().setHeight(15),
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
                        text: " Or Sign with",
                        size: 12,
                        weight: FontWeight.w500,
                        color: Colors.white),
                    Container(
                      height: ScreenUtil().setHeight(2),
                      width: ScreenUtil().setWidth(100),
                      color: Colors.white,
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(25),
                ),
                 Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            
          },
          child: Container(
            height: ScreenUtil().setHeight(42),
            width: ScreenUtil().setWidth(250),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(31),
              color: Color(0xffFFFFFF)
            ),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.start,
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
    )              ],
            ),
          ),
        ));
  }
}
