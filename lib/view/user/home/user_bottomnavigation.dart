import 'package:flutter/material.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart'; // Make sure this has a valid path for icons
import 'package:hommie/view/user/home/user_account/user_account.dart';
import 'package:hommie/view/user/home/user_category/user_category.dart';
import 'package:hommie/view/user/home/user_home.dart';
import 'package:hommie/view/user/home/user_saved.dart';
import 'package:hommie/view/user/userprovider/user_provider_class.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class UserBottomNavigation extends StatelessWidget {
  const UserBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final userNavigationProvider = Provider.of<UserNavigationProvider>(context);

    List<Widget> pages = [
      const Home(),
      const UserCategory(),
      const UserSaved(),
      const UserAccount(),
    ];

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: 60,
        elevation: 0,
        selectedIndex: userNavigationProvider.currentIndex,
        onDestinationSelected: (int index) {
          userNavigationProvider.userNavigationCurrentIndex(index);
        },
        backgroundColor: myColor.background,
        indicatorColor: Colors.teal[200],
        animationDuration: Durations.short4,
        destinations: [
          NavigationDestination(
              icon: userNavigationProvider.currentIndex == 0
                  ? Icon(
                      IconlyBold.home,
                      size: 23,
                    )
                  : Icon(IconlyLight.home),
              label: "Home"),
          NavigationDestination(
              icon: userNavigationProvider.currentIndex == 1
                  ? Icon(IconlyBold.category, size: 23)
                  : Icon(IconlyLight.category, size: 23),
              label: "Category"),
          NavigationDestination(
              icon: userNavigationProvider.currentIndex == 2
                  ? Image.asset(icons[2], width: 23)
                  : Image.asset(icons[3], width: 23),
              label: "Saved"),
          NavigationDestination(
              icon: userNavigationProvider.currentIndex == 3
                  ? Icon(IconlyBold.profile, size: 23)
                  : Icon(IconlyLight.profile, size: 23),
              label: "Account"),
        ],
      ),
      body: pages[userNavigationProvider.currentIndex],
    );
  }
}
