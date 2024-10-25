// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:hommie/model/utils/style/color.dart';
// import 'package:hommie/widgets/appbar.dart';
// import 'package:hommie/widgets/cu_inkwell_button.dart';
// import 'package:hommie/widgets/custom_text.dart';
// import 'package:hommie/widgets/custom_textfield.dart';
// import 'package:hommie/user/view/login/user_otp_verification.dart';

// class UserForgotPassword extends StatefulWidget {
//   const UserForgotPassword({super.key});

//   @override
//   State<UserForgotPassword> createState() => _UserForgotPasswordState();
// }

// class _UserForgotPasswordState extends State<UserForgotPassword> {
//   var email = TextEditingController();
//      final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<void> chefresetpass(
//        BuildContext context) async {
//     try {
//       QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//           .collection('Users')
//           .where('Email', isEqualTo: email)
//           .get();
//       if (querySnapshot.docs.isNotEmpty) {
//         await _auth.sendPasswordResetEmail(email:email!.trim());

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Password reset email sent')),
//         );
        
        
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('No chef account found with this email')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('An unexpected error occurred')),
//       );
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: CustomAppBar(
//         title: "Forgot Password",
//         color: myColor.background,
//         backgroundColor: Colors.transparent,
//       ),
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             colorFilter: ColorFilter.mode(
//               Colors.black.withOpacity(0.6),
//               BlendMode.darken,
//             ),
//             image: AssetImage('assets/images/unsplash_yHg6p8vW_Is.png'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 120.h,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 20, right: 20),
//                 child: CustomText(
//                   text: "Please enter your registered phone number or email",
//                   size: 15,
//                   weight: FontWeight.w400,
//                   color: Colors.white,
//                   letterSpacing: 1.5,
//                 ),
//               ),
//               SizedBox(
//                 height: 30.h,
//               ),
//               CustomTextField(
//                 hintText: "Enter your Email",
//                 controller: email,
//               ),
//               SizedBox(
//                 height: 30.h,
//               ),
//               CustomInkwellButton(
//                   onTap: () {
//                     Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => UserOtpVerification(),),);
//                   },
//                   text: "Next")
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/user/view/login/otp.dart';
import 'package:hommie/user/view/login/user_Login.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/cu_inkwell_button.dart';
import 'package:hommie/widgets/custom_text.dart';
import 'package:hommie/widgets/custom_textfield.dart';

class UserForgotPassword extends StatefulWidget {
  const UserForgotPassword({super.key});
  static String verify = "";

  @override
  State<UserForgotPassword> createState() => _UserForgotPasswordState();
}

class _UserForgotPasswordState extends State<UserForgotPassword> {
 

   
  var phone = "";

  @override
  Widget build(BuildContext context) {
    return 
    
    Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Enter your Phone number'),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: TextField(
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                phone = value;
              },
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.verifyPhoneNumber(
                  phoneNumber: '+91$phone',
                  verificationCompleted: (PhoneAuthCredential credential) {},
                  verificationFailed: (FirebaseAuthException e) {},
                  codeSent: (String verificationId, int? resendToken) {
                    UserForgotPassword.verify = verificationId;
                    Navigator.pushNamed(context, "otp");
                  },
                  codeAutoRetrievalTimeout: (String verificationId) {},
                );
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return MyOtp();
                  },
                ));
              },
              child: const Text('send the code'))
        ],
      ),
    );
   
  }
}


 // var email = TextEditingController();
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  // Future<void> userResetPassword(BuildContext context) async {
  //   try {
  //     // Use email.text instead of just email
  //     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //         .collection('Users')
  //         .where('Email', isEqualTo: email.text.trim())
  //         .get();
      
  //     if (querySnapshot.docs.isNotEmpty) {
  //       // Send the reset email
  //       await _auth.sendPasswordResetEmail(email: email.text.trim());

  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Password reset email sent')),
  //       );

  //       // Navigate to OTP verification screen
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => UserLogin(),
  //         ),
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('No chef account found with this email')),
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('An unexpected error occurred')),
  //     );
  //   }
  // }


 // Scaffold(
    //   extendBodyBehindAppBar: true,
    //   appBar: CustomAppBar(
    //     title: "Forgot Password",
    //     color: myColor.background,
    //     backgroundColor: Colors.transparent,
    //   ),
    //   body: Container(
    //     height: double.infinity,
    //     width: double.infinity,
    //     decoration: BoxDecoration(
    //       image: DecorationImage(
    //         colorFilter: ColorFilter.mode(
    //           Colors.black.withOpacity(0.6),
    //           BlendMode.darken,
    //         ),
    //         image: AssetImage('assets/images/unsplash_yHg6p8vW_Is.png'),
    //         fit: BoxFit.cover,
    //       ),
    //     ),
    //     child: SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           SizedBox(
    //             height: 120.h,
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.only(left: 20, right: 20),
    //             child: CustomText(
    //               text: "Please enter your registered phone number or email",
    //               size: 15,
    //               weight: FontWeight.w400,
    //               color: Colors.white,
    //               letterSpacing: 1.5,
    //             ),
    //           ),
    //           SizedBox(
    //             height: 30.h,
    //           ),
    //           CustomTextField(
    //             hintText: "Enter your Email",
    //             controller: email,
    //           ),
    //           SizedBox(
    //             height: 30.h,
    //           ),
    //           CustomInkwellButton(
    //               onTap: () {
    //                 // Call chefresetpass method to handle password reset
    //                 userResetPassword(context);
    //               },
    //               text: "Next")
    //         ],
    //       ),
    //     ),
    //   ),
    // );

