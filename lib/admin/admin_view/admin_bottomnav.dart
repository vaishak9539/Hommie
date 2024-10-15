import 'package:flutter/material.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/admin/admin_view/admin_agency_request.dart';
import 'package:hommie/admin/admin_view/admin_badge.dart';
import 'package:hommie/admin/admin_view/admin_users.dart';
import 'package:hommie/admin/adminprovider/adminprovider.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class AdminBottomnav extends StatefulWidget {
  const AdminBottomnav({super.key});

  @override
  State<AdminBottomnav> createState() => _AdminBottomnavState();
}

class _AdminBottomnavState extends State<AdminBottomnav> {
  var navigationIndex = 0;
  @override
  Widget build(BuildContext context) {
    List pages = [AdminAgencyRequest(), AdminUsers(),
    // AdminBadge()
    ];
    // final adminNavigationProvider = Provider.of<AdminNavigationProvider>(context);
    return Scaffold(
      
      bottomNavigationBar: NavigationBar(
        height: 60,
        elevation: 0,
        selectedIndex: navigationIndex,
        onDestinationSelected: (int index) {
          setState(() {
            navigationIndex=index;
          });
        },
       backgroundColor: Colors.grey[200],
        indicatorColor: Colors.teal[300],
        animationDuration: Durations.short4,
        destinations: [
          NavigationDestination(
              icon: navigationIndex == 0
                  ? Icon(
                      IconlyBold.home,
                      size: 23,
                    )
                  : Icon(IconlyLight.home),
              label: "Home"),
          NavigationDestination(
              icon: navigationIndex == 1
                  ? Icon(IconlyBold.profile, size: 23)
                  : Icon(IconlyLight.profile, size: 23),
              label: "User"),
          // NavigationDestination(
          //     icon: adminNavigationProvider.navigationIndex == 2
          //         ? Image.asset(icons[2], width: 23)
          //         : Image.asset(icons[3], width: 23),
              // label: "Request"),
         
        ],
      ),
      body: pages[navigationIndex],
    );
  }
}