import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/provider/obscuretext_provider.dart';
import 'package:hommie/view/user/login/widgets/with_google.dart';
import 'package:hommie/view/user/regiser/us_register.dart';
import 'package:hommie/widgets/cu_inkwell_button.dart';
import 'package:hommie/widgets/cu_text_button.dart';
import 'package:hommie/widgets/custom_text.dart';
import 'package:hommie/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class UserLogin extends StatelessWidget {
  const UserLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final obscureTextProvider = Provider.of<ObscuretextProvider>(context);
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
                'assets/images/unsplash_yHg6p8vW_Is.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: ScreenUtil().setHeight(293),
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
                keyboardType: TextInputType.emailAddress,
                hintText: "Email",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CustomTextField(
                hintText: "Password",
                obscureText: obscureTextProvider.secureText,
                suffixIcon: IconButton(
                  icon: Icon(
                    obscureTextProvider.secureText
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    obscureTextProvider.checkvisibility();
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
                      Navigator.pushReplacementNamed(context, "UserForgotPassword");
                    },
                    text: "Forgot Password ?",
                    color: Colors.white.withOpacity(0.6),
                    size: 12,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomInkwellButton(
                  text: "Login",
                  onTap: () {
                    Navigator.pushReplacementNamed(context, "UserButtomNavigation");
                  },
                ),
              ],
            ),
            SizedBox(
              height: ScreenUtil().setHeight(20),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UsRegister(),
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
              height: ScreenUtil().setHeight(23),
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
              height: ScreenUtil().setHeight(28),
            ),
            WithGoogle()
          ]),
        ),
      ),
    );
  }
}
