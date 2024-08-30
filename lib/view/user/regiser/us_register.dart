import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/widgets/cu_inkwell_button.dart';
import 'package:hommie/model/utils/widgets/custom_text.dart';
import 'package:hommie/model/utils/widgets/custom_textfield.dart';
import 'package:hommie/model/utils/widgets/dropdown.dart';
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // CuDropdown(
                    //     items: userstateDropdownProvider.state,
                    //     onChanged: (newValue) {
                    //       userstateDropdownProvider.userSelectedState(newValue);
                    //     },
                    //     hintText: "State",
                    //     backgroundColor: myColor.background)
                    SizedBox(
                      width: 150,
                      child: DropdownSearch<String>(
                        popupProps: PopupProps.menu(
                            showSelectedItems: true,
                            fit: FlexFit.loose,
                            menuProps:
                                MenuProps(backgroundColor: myColor.background),
                            constraints: BoxConstraints(
                                maxHeight: 200.h, maxWidth: 200.w)),
                        items: userstateDropdownProvider.state,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                                contentPadding: EdgeInsets.all(8),
                                suffixIconColor:
                                    myColor.background.withOpacity(0.8),
                                fillColor: Colors.transparent,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: myColor.background, width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: myColor.background, width: 2),
                                ),
                                hintText: "State",
                                hintStyle: TextStyle(
                                    color:
                                        myColor.background.withOpacity(0.6)))),
                        onChanged: (newValue) {
                          userstateDropdownProvider.userSelectedState(newValue);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: DropdownSearch<String>(
                        popupProps: PopupProps.menu(
                            showSelectedItems: true,
                            fit: FlexFit.loose,
                            menuProps:
                                MenuProps(backgroundColor: myColor.background),
                            constraints: BoxConstraints(
                                maxHeight: 200.h, maxWidth: 200.w)),
                        items: userCityDropdownProvider.city,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                                contentPadding: EdgeInsets.all(8),
                                suffixIconColor:
                                    myColor.background.withOpacity(0.8),
                                fillColor: Colors.transparent,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: myColor.background, width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: myColor.background, width: 2),
                                ),
                                hintText: "city",
                                hintStyle: TextStyle(
                                    color:
                                        myColor.background.withOpacity(0.6)))),
                        onChanged: (value) {
                          userCityDropdownProvider.userSelectedCity(value);
                        },
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
                        Navigator.pushNamed(context, "UserTermsAndConditions");
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
                          Navigator.pushNamed(context, "UserLoginPage");
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
                      onTap: () {},
                      child: Container(
                        height: ScreenUtil().setHeight(42),
                        width: ScreenUtil().setWidth(250),
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
              ],
            ),
          ),
        ));
  }
}
