import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/view/admin/admin_bottomnav.dart';
import 'package:hommie/view/admin/adminprovider/adminprovider.dart';
import 'package:hommie/view/widgets/cu_inkwell_button.dart';
import 'package:hommie/view/widgets/custom_text.dart';
import 'package:hommie/view/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class AdminLogin extends StatelessWidget {
  const AdminLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final adminObscureTextProvider =
        Provider.of<AdminObscureTextProvider>(context);
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
                obscureText: adminObscureTextProvider.adminObscureText,
                suffixIcon: IconButton(
                  icon: Icon(
                    adminObscureTextProvider.adminObscureText
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    adminObscureTextProvider.checkvisibility();
                  },
                ),
              ),
            ),
            SizedBox(height: 40.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomInkwellButton(
                  text: "Login",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminBottomnav()));
                  },
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
