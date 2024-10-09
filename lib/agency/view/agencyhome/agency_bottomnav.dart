import 'package:flutter/material.dart';
import 'package:hommie/agency/view/agencyhome/agency_history.dart';
import 'package:hommie/agency/view/agencyhome/agencyaccount/agency_account.dart';
import 'package:hommie/agency/view/agencyhome/agencyitemlist/agency_item_list.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:iconly/iconly.dart';

class AgencyBottomNav extends StatefulWidget {
  const AgencyBottomNav({super.key});

  @override
  State<AgencyBottomNav> createState() => _AgencyBottomNavState();
}

class _AgencyBottomNavState extends State<AgencyBottomNav> {
  List<Widget> pages = [
     AgencyItemList(),
    const AgencyHistory(),
    const AgencyAccount(),
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: 60,
        elevation: 0,
        selectedIndex: selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        backgroundColor: Colors.grey[200],
        indicatorColor: Colors.teal[300],
        animationDuration: Durations.short4,
        destinations: [
          NavigationDestination(
            icon: selectedIndex == 0
                ? Icon(
                    IconlyBold.home,
                    size: 23,
                  )
                : Icon(IconlyLight.home),
            label: "Home",
          ),
          NavigationDestination(
              icon: selectedIndex == 1
                  ? Image.asset(icons[12], width: 23)
                  : Image.asset(icons[11], width: 23),
              label: "History"),
          NavigationDestination(
              icon: selectedIndex == 2
                  ? Icon(IconlyBold.profile, size: 23)
                  : Icon(IconlyLight.profile, size: 23),
              label: "Account"),
        ],
      ),
      body: pages[selectedIndex],
    );
  }
}
