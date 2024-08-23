import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/provider/obscuretext_provider.dart';
import 'package:hommie/provider/registration_provider.dart';
import 'package:hommie/provider/statedropdownbutton.dart';
import 'package:hommie/provider/user_navigation_provider.dart';
import 'package:hommie/provider/user_home_saved_provider.dart';
import 'package:hommie/provider/user_villa_saved_provider.dart';
import 'package:hommie/view/user/home/user_bottomnavigation.dart';
import 'package:hommie/view/user/home/user_account/user_profile.dart';
import 'package:hommie/view/user/home/user_category/user_view_home.dart';
import 'package:hommie/view/user/home/user_category/user_view_villa.dart';
import 'package:hommie/view/user/login/forgot_password.dart';
import 'package:hommie/view/user/login/reset_password.dart';
import 'package:hommie/view/user/login/user_Login.dart';
import 'package:hommie/view/user/login/slider1.dart';
import 'package:hommie/view/user/login/slider2.dart';
import 'package:hommie/view/user/terms/terms_conditions.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    ScreenUtil.init(context,
        splitScreenMode: true,
        minTextAdapt: true,
        designSize: Size(width, height));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RegistrationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ObscuretextProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => StateDropdownButton(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserNavigationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserVillaSavedProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserHomeSavedProvider(),
        )
      ],
      child: ScreenUtilInit(
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            // home: UserViewProperty(),
            routes: {
              "Slider1": (context) => Slider1(),
              "Slider2": (context) => Slider2(),
              "UserLoginPage": (context) => UserLogin(),
              "UserForgotPassword": (context) => ForgotPassword(),
              "UserButtomNavigation": (context) => UserButtomNavigation(),
              "UserResetPassword": (context) => ResetPassword(),
              "UserViewVilla": (context) => UserViewVilla(),
              "UserViewHome": (context) => UserViewHome(),
              "User Profile" : (context) => UserProfile(),
              "TermsAndConditions" : (context)=> TermsAndConditions(),
            },
            initialRoute: "Slider1",
          );
        },
      ),
    );
  }
}
