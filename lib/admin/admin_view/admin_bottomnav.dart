import 'package:flutter/material.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/admin/admin_view/admin_agency_request.dart';
import 'package:hommie/admin/admin_view/admin_badge.dart';
import 'package:hommie/admin/admin_view/admin_users.dart';
import 'package:hommie/admin/adminprovider/adminprovider.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class AdminBottomnav extends StatelessWidget {
  const AdminBottomnav({super.key});

  @override
  Widget build(BuildContext context) {
    List pages = [AdminAgencyRequest(), AdminUsers(),AdminBadge()];
    final adminNavigationProvider = Provider.of<AdminNavigationProvider>(context);
    return Scaffold(
      
      bottomNavigationBar: NavigationBar(
        height: 60,
        elevation: 0,
        selectedIndex: adminNavigationProvider.navigationIndex,
        onDestinationSelected: (int index) {
          adminNavigationProvider.adminNavigationCurrentIndex(index);
        },
       backgroundColor: Colors.grey[200],
        indicatorColor: Colors.teal[300],
        animationDuration: Durations.short4,
        destinations: [
          NavigationDestination(
              icon: adminNavigationProvider.navigationIndex == 0
                  ? Icon(
                      IconlyBold.home,
                      size: 23,
                    )
                  : Icon(IconlyLight.home),
              label: "Home"),
          NavigationDestination(
              icon: adminNavigationProvider.navigationIndex == 1
                  ? Icon(IconlyBold.profile, size: 23)
                  : Icon(IconlyLight.profile, size: 23),
              label: "User"),
          NavigationDestination(
              icon: adminNavigationProvider.navigationIndex == 2
                  ? Image.asset(icons[2], width: 23)
                  : Image.asset(icons[3], width: 23),
              label: "Request"),
         
        ],
      ),
      body: pages[adminNavigationProvider.navigationIndex],
    );
  }
}