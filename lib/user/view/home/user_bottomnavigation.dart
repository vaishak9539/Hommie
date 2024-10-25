import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/img_path.dart'; // Make sure this has a valid path for icons
import 'package:hommie/user/view/home/user_account/user_account.dart';
import 'package:hommie/user/view/home/user_category/user_category.dart';
import 'package:hommie/user/view/home/user_home.dart';
import 'package:hommie/user/view/home/user_saved.dart';
import 'package:iconly/iconly.dart';

class UserBottomNavigation extends StatefulWidget {
  const UserBottomNavigation({super.key});

  @override
  State<UserBottomNavigation> createState() => _UserBottomNavigationState();
}

class _UserBottomNavigationState extends State<UserBottomNavigation> {
  // Move currentIndex outside of build method to persist state
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const Home(),
      const UserCategory(),
      const UserSaved(),
      const UserAccount(),
    ];

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: 55.h,
        elevation: 0,
        selectedIndex: currentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        backgroundColor: Colors.grey[200],
        indicatorColor: Colors.teal[300],
        animationDuration: Durations.short4,
        destinations: [
          NavigationDestination(
            icon: currentIndex == 0
                ? const Icon(
                    IconlyBold.home,
                    size: 23,
                  )
                : const Icon(IconlyLight.home),
            label: "Home",
          ),
          NavigationDestination(
            icon: currentIndex == 1
                ? const Icon(IconlyBold.category, size: 23)
                : const Icon(IconlyLight.category, size: 23),
            label: "Category",
          ),
          NavigationDestination(
            icon: currentIndex == 2
                ? Image.asset(icons[2], width: 23)
                : Image.asset(icons[3], width: 23),
            label: "Saved",
          ),
          NavigationDestination(
            icon: currentIndex == 3
                ? const Icon(IconlyBold.profile, size: 23)
                : const Icon(IconlyLight.profile, size: 23),
            label: "Account",
          ),
        ],
      ),
      body: pages[currentIndex],
    );
  }
}
