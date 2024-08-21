// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/provider/user_navigation_provider.dart';
import 'package:hommie/utils/color.dart';
import 'package:hommie/utils/img_path.dart';
import 'package:hommie/view/user/home/user_account.dart';
import 'package:hommie/view/user/home/user_category.dart';
import 'package:hommie/view/user/home/user_home.dart';
import 'package:hommie/view/user/home/user_saved.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class UserButtomNavigation extends StatelessWidget {
  const UserButtomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final userNavigationProvider = Provider.of<UserNavigationProvider>(context);
    List pages=[Home(),UserCategory(),UserSaved(),UserAccount()];
    return Scaffold(
      backgroundColor: myColor.background,
      bottomNavigationBar: CurvedNavigationBar(
        height: ScreenUtil().setHeight(55),
        buttonBackgroundColor: Colors.teal[300],
        color: Colors.teal,

        backgroundColor: Colors.transparent,
        onTap: userNavigationProvider.userNavigationCurrentIndex,
        index: userNavigationProvider.currentIndex,
        items: [
        Icon(IconlyLight.home,size: 30,),
        Icon(IconlyLight.category,size: 30,),
        Image.asset(icons[2],width: 30,),
        Icon(IconlyLight.profile,size: 30,),
      ]),
      body: pages.elementAt(userNavigationProvider.currentIndex),
    );
  }
}