import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/select_page.dart';
import 'package:hommie/view/agency/agencyhome/agency_bottomnav.dart';
import 'package:hommie/view/agency/agencyhome/agency_history.dart';
import 'package:hommie/view/agency/agencyhome/agency_notification.dart';
import 'package:hommie/view/agency/agencyhome/agencyaccount/agency_feedback.dart';
import 'package:hommie/view/agency/agencyhome/agencyaccount/agency_history_details.dart';
import 'package:hommie/view/agency/agencyhome/agencyaccount/agency_profile.dart';
import 'package:hommie/view/agency/agencyhome/agencyaccount/agency_terms_conditions.dart';
import 'package:hommie/view/agency/agencyhome/agencyaddproperty/agencyadd.dart';
import 'package:hommie/view/agency/agencylogin/agency_forgot_password.dart';
import 'package:hommie/view/agency/agencylogin/agency_login.dart';
import 'package:hommie/view/agency/agencylogin/agency_otp_verification.dart';
import 'package:hommie/view/agency/agencylogin/agency_register.dart';
import 'package:hommie/view/agency/agencylogin/agency_reset_password.dart';
import 'package:hommie/view/agency/agencyprovider/agency_provider_class.dart';
import 'package:hommie/view/user/home/user_account/user_feedback.dart';
import 'package:hommie/view/user/home/user_account/user_history.dart';
import 'package:hommie/view/user/home/user_account/user_history_details.dart';
import 'package:hommie/view/user/home/user_account/user_profile.dart';
import 'package:hommie/view/user/home/user_bottomnavigation.dart';
import 'package:hommie/view/user/home/user_category/user_property_view.dart';
import 'package:hommie/view/user/home/user_category/user_view_home.dart';
import 'package:hommie/view/user/home/user_category/user_view_villa.dart';
import 'package:hommie/view/user/home/user_notification.dart';
import 'package:hommie/view/user/login/user_forgot_password.dart';
import 'package:hommie/view/user/login/user_otp_verification.dart';
import 'package:hommie/view/user/login/user_reset_password.dart';
import 'package:hommie/view/user/login/slider1.dart';
import 'package:hommie/view/user/login/slider2.dart';
import 'package:hommie/view/user/login/user_Login.dart';
import 'package:hommie/view/user/regiser/us_register.dart';
import 'package:hommie/view/user/userprovider/user_provider_class.dart';
import 'package:hommie/view/user/home/user_account/user_terms_conditions.dart';
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
          create: (context) => UserStateDropdownProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserCityDropdownProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserNavigationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserVillaSavedProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserHomeSavedProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AgencyObscuretextOProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AgencyCheckboxProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AgencyNavigationProvider(),
        )
      ],
      child: ScreenUtilInit(
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Homeie',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),

            // home: User()
            routes: {
              "Select": (context) => Select(),
              "Slider1": (context) => Slider1(),
              "Slider2": (context) => Slider2(),
              "UserLoginPage": (context) => UserLogin(),
              "UserForgotPassword": (context) => UserForgotPassword(),
              "UserOtpVerification": (context) => UserOtpVerification(),
              "UserResetPassword": (context) => UserResetPassword(),
              "UserRegister": (context) => UserRegister(),
              "UserButtomNavigation": (context) => UserBottomNavigation(),
              "UserViewVilla": (context) => UserViewVilla(),
              "UserViewHome": (context) => UserViewHome(),
              "User Profile": (context) => UserProfile(),
              "UserTermsAndConditions": (context) => UserTermsAndConditions(),
              "UserFeedback": (context) => UserFeedback(),
              "UserHistory": (context) => UserHistory(),
              "User Property View": (context) => UserPropertyView(),
              "User Notification": (context) => UserNotification(),
              "UserHistoryDetails": (context) => UserHistoryDetails(),
              "AgencyLogin": (context) => AgencyLogin(),
              "AgencyForgotPassword": (context) => AgencyForgotPassword(),
              "AgencyOtpVerification": (context) => AgencyOtpVerification(),
              "AgencyResetPassword": (context) => AgencyResetPassword(),
              "AgencyRegister": (context) => AgencyRegister(),
              "AgencyBottomNav": (context) => AgencyBottomNav(),
              "AgencyHistoryDetails" : (context)=> AgencyHistoryDetails(),
              "AgencyFeedback" : (context)=> AgencyFeedback(),
              "AgencyTermsAndConditions" : (context)=> AgencyTermsConditions(),
              "AgencyProfile" : (context)=> AgencyProfile(),
              "AgencyNotification" : (context)=> AgencyNotification(),
              "AgencyHistory" : (context)=> AgencyHistory(),
              "Agencyadd" : (context)=> Agencyadd(),
            },
            initialRoute: "Select",
          );
        },
      ),
    );
  }
}
