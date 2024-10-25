import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hommie/admin/admin_view/admin_bottomnav.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/widgets/cu_inkwell_button.dart';
import 'package:hommie/widgets/custom_text.dart';
import 'package:hommie/widgets/custom_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
   final formkey = GlobalKey<FormState>();
  final adminPasswordController = TextEditingController();
  final adminEmailController = TextEditingController();
   bool adminSecureText = false;
  Future<void> adminSignWithEmailAndPassword() async {
    if (formkey.currentState!.validate()) {
      String email = adminEmailController.text.trim();
      String password = adminPasswordController.text.trim();

      var querySnapshot = await FirebaseFirestore.instance
          .collection("Admin")
          .where("Email", isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var userData = querySnapshot.docs.first.data();
        var passwordFromDB = userData['Password'];
        print("passwordFromDB : $passwordFromDB");
        if (passwordFromDB != null && passwordFromDB == password) {
          var adminUid = userData["Authid"];
          if (adminUid != null) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString("AdminUid", adminUid);
          }
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? adminId = prefs.getString("AdminUid");
          print("Shared Preference User ID: $adminId");

          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AdminBottomnav();
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
                    controller: adminEmailController,
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
                    controller: adminPasswordController,
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
                    obscureText: adminSecureText,
                    suffixIcon: IconButton(
                      icon: Icon(
                        adminSecureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          adminSecureText = !adminSecureText;
                        });
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
                     adminSignWithEmailAndPassword();
                    },
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
