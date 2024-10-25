import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hommie/user/view/login/user_Login.dart';
import 'package:hommie/user/view/login/user_forgot_password.dart';
import 'package:pinput/pinput.dart';

class MyOtp extends StatefulWidget {
  const MyOtp({super.key});

  @override
  State<MyOtp> createState() => _MyOtpState();
}

class _MyOtpState extends State<MyOtp> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var code = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Enter your OTP'),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Pinput(
              length: 6,
              showCursor: true,
              onChanged: (value) {
                code = value;
              },
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                // Use UserForgotPassword.verify here instead of MyPhone.verify
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: UserForgotPassword.verify, 
                  smsCode: code
                );

                // Sign in the user with the OTP credential
                await auth.signInWithCredential(credential);
                
                // Navigate to the login screen or home screen
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return UserLogin();
                  },
                ));
              } catch (e) {
                print("Error: Invalid OTP");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Invalid OTP, please try again")),
                );
              }
            },
            child: const Text('Submit OTP')
          ),
        ],
      ),
    );
  }
}
