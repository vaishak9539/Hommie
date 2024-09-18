import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/firebase_options.dart';
import 'package:hommie/select_page.dart';
import 'package:hommie/view/admin/adminprovider/adminprovider.dart';
import 'package:hommie/view/agency/agencyprovider/agency_provider_class.dart';
import 'package:hommie/view/user/userprovider/user_provider_class.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
          create: (context) => SmoothIndicatorProvider(),
        ),
        // ChangeNotifierProvider(
        //   create: (context) => UserVillaSavedProvider(),
        // ),
        // ChangeNotifierProvider(
        //   create: (context) => UserHomeSavedProvider(),
        // ),
        ChangeNotifierProvider(
          create: (context) => AgencyObscuretextProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AgencyCheckboxProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AgencyNavigationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AgencyCityProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AgencyStateProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AgencyPropertyTypProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AgencyFurnishingProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AdminObscureTextProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AdminNavigationProvider(),
        ),
      ],
      child: ScreenUtilInit(
        builder: (context, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Hommie',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: Select()
              // routes: {
              //*"Select": (context) => Select(),
              //* "Slider1": (context) => Slider1(),
              //*   "Slider2": (context) => Slider2(),
              //*   "UserLoginPage": (context) => UserLogin(),
              //*   "UserForgotPassword": (context) => UserForgotPassword(),
              //*   "UserOtpVerification": (context) => UserOtpVerification(),
              //*   "UserResetPassword": (context) => UserResetPassword(),
              //*   "UserRegister": (context) => UserRegister(),
              //*   "UserButtomNavigation": (context) => UserBottomNavigation(),
              //*   "UserAgencyProfileView": (context) => UserAgencyProfileView(),
              //*   "UserViewVilla": (context) => UserViewVilla(),
              //*   "UserViewHome": (context) => UserViewHome(),
              //*   "UserViewApartment": (context) => UserViewApartment(),
              //*   "UserViewLands": (context) => UserViewLands(),
              //*   "User Profile": (context) => UserProfile(),
              //*   "UserTermsAndConditions": (context) => UserTermsAndConditions(),
              //*   "UserFeedback": (context) => UserFeedback(),
              //*   "UserHistory": (context) => UserHistory(),
              //*   "UserPropertyView": (context) => UserPropertyView(),
              //*   "User Notification": (context) => UserNotification(),
              //*   "UserHistoryDetails": (context) => UserHistoryDetails(),
              //*   "AgencyLogin": (context) => AgencyLogin(),
              //*   "AgencyForgotPassword": (context) => AgencyForgotPassword(),
              // *  "AgencyOtpVerification": (context) => AgencyOtpVerification(),
              //*   "AgencyResetPassword": (context) => AgencyResetPassword(),
              //*   "AgencyRegister": (context) => AgencyRegister(),
              //*   "AgencyBottomNav": (context) => AgencyBottomNav(),
              //*   "AgencyAddHomeDetails": (context) => AgencyAddHomeDetails(),
              //*   "AgencyAddLandDetails": (context) => AgencyAddLandDetails(),
              //*   "AgencyAddedSuccessfully": (context) => AgencyAddedSuccessfully(),
              //*   "AgencyHistoryDetails": (context) => AgencyHistoryDetails(),
              //   "AgencyFeedback": (context) => AgencyFeedback(),
              //*   "AgencyTermsAndConditions": (context) => AgencyTermsConditions(),
              //*   "AgencyProfile": (context) => AgencyProfile(),
              //*   "AgencyNotification": (context) => AgencyNotification(),
              //*   "AgencyHistory": (context) => AgencyHistory(),
              //*   "AgencyaddItem": (context) => AgencyaddItem(),
              //*   "AdminLogin": (context) => AdminLogin(),
              //*   "AdminBottomnav": (context) => AdminBottomnav(),
              //   "AdminRequestDetails": (context) => AdminRequestDetails(),
              //   "AdminAgencyDetails": (context) => AdminAgencyDetails(),
              //   "AdminUserDetails": (context) => AdminUserDetails(),
              // },
              // initialRoute: "Select",
              );
        },
      ),
    );
  }
}
