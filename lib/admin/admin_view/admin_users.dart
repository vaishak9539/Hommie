import 'package:flutter/material.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/admin/admin_view/admin_agency_list.dart';
import 'package:hommie/admin/admin_view/admin_user_list.dart';

class AdminUsers extends StatelessWidget {
  const AdminUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: myColor.background,
        appBar: CustomAppBar(title: "Users"),
        body: Column(
          children: [
            TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.center,
              labelColor: myColor.background,
              labelPadding: EdgeInsets.symmetric(horizontal: 0,),
              dividerColor: Colors.white,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff08A9A9),
              ),
              tabs: const [
                SizedBox(width: 150, child: Tab(text: "Users List")),
                SizedBox(width: 150, child: Tab(text: "Agency List")),
              ],
            ),
            Expanded(
              child: TabBarView(children: [AdminUserList(),AdminAgencyList()]),
            )
          ],
        ),
      ),
    );
  }
}
