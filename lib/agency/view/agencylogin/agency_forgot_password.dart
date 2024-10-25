import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/agency/view/agencylogin/agency_login.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/cu_inkwell_button.dart';
import 'package:hommie/widgets/custom_text.dart';
import 'package:hommie/widgets/custom_textfield.dart';

class AgencyForgotPassword extends StatefulWidget {
  const AgencyForgotPassword({super.key});

  @override
  State<AgencyForgotPassword> createState() => _AgencyForgotPasswordState();
}

class _AgencyForgotPasswordState extends State<AgencyForgotPassword> {
   var email = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> agencyResetPassword(BuildContext context) async {
    try {
      // Use email.text instead of just email
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Agencies')
          .where('Email', isEqualTo: email.text.trim())
          .get();
      
      if (querySnapshot.docs.isNotEmpty) {
        // Send the reset email
        await _auth.sendPasswordResetEmail(email: email.text.trim());

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password reset email sent')),
        );

        // Navigate to OTP verification screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AgencyLogin(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No chef account found with this email')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: "Forgot Password",
        color: myColor.background,
        backgroundColor: Colors.transparent,
      ),
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
          child: Column(
            children: [
              SizedBox(
                height: 120.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: CustomText(
                  text: "Please enter your registered phone number or email",
                  size: 15,
                  weight: FontWeight.w400,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              CustomTextField(
                hintText: "Enter your Email",
              ),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              CustomInkwellButton(
                  onTap: () {
                    agencyResetPassword(context);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => AgencyOtpVerification(),
                        // ));
                  },
                  text: "Next")
            ],
          ),
        ),
      ),
    );
  }
}
