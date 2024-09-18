import 'package:flutter/material.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/view/agency/agencyhome/agency_badge.dart';
import 'package:hommie/view/agency/agencyhome/agency_history.dart';
import 'package:hommie/view/agency/agencyhome/agencyaccount/agency_account.dart';
import 'package:hommie/view/agency/agencyhome/agencyitemlist/agency_item_list.dart';
import 'package:hommie/view/agency/agencyprovider/agency_provider_class.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class AgencyBottomNav extends StatelessWidget {
  const AgencyBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final agencyNavigationProvider =
        Provider.of<AgencyNavigationProvider>(context);
    List<Widget> pages = [
      const AgencyItemList(),
      const AgencyBadge(),
      const AgencyHistory(),
      const AgencyAccount(),
    ];
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: 60,
        elevation: 0,
        selectedIndex: agencyNavigationProvider.currentIndex,
        onDestinationSelected: (int index) {
          agencyNavigationProvider.agencyNavigationCurrentIndex(index);
        },
       backgroundColor: Colors.grey[200],
        indicatorColor: Colors.teal[300],
        animationDuration: Durations.short4,
        destinations: [
          NavigationDestination(
              icon: agencyNavigationProvider.currentIndex == 0
                  ? Icon(
                      IconlyBold.home,
                      size: 23,
                    )
                  : Icon(IconlyLight.home),
              label: "Home",),
          NavigationDestination(
              icon: agencyNavigationProvider.currentIndex == 1
                  ? Image.asset(
                      icons[8],
                      width: 23,
                    )
                  : Image.asset(
                      icons[7],
                      width: 23,
                    ),
              label: "Badge"),
          NavigationDestination(
              icon: agencyNavigationProvider.currentIndex == 2
                  ? Image.asset(icons[12], width: 23)
                  : Image.asset(icons[11], width: 23),
              label: "History"),
          NavigationDestination(
              icon: agencyNavigationProvider.currentIndex == 3
                  ? Icon(IconlyBold.profile, size: 23)
                  : Icon(IconlyLight.profile, size: 23),
              label: "Account"),
        ],
      ),
      body: pages[agencyNavigationProvider.currentIndex],
    );
  }
}
