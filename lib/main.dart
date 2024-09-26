import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/agency/controller/agencycopntroller.dart';
import 'package:hommie/firebase_options.dart';
import 'package:hommie/select_page.dart';
import 'package:hommie/admin/adminprovider/adminprovider.dart';
import 'package:hommie/agency/agencyprovider/agency_provider_class.dart';
import 'package:hommie/user/userprovider/user_provider_class.dart';
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
        ChangeNotifierProvider(
          create: (context) => AgencyController(),
        ),
        ChangeNotifierProvider(
          create: (context) => AgencyNavigationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AgencyCityProvider(),
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
              );
        },
      ),
    );
  }
}
