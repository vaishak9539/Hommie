// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/agency/view/agencyhome/agencyitemlist/agency_chat_list.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/custom_card.dart';
import 'package:hommie/widgets/custom_text.dart';
import 'package:hommie/agency/view/agencyhome/agency_notification.dart';
import 'package:hommie/agency/view/agencyhome/agencyitemlist/agency_add_item.dart';

class AgencyItemList extends StatelessWidget {
  const AgencyItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColor.background,
      appBar: CustomAppBar(
        automaticallyImplyLeading: false,
        title: "Home",
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AgencyNotification()));
                },
                icon: Image.asset(
                  icons[1],
                  width: 25,
                ),
              )),
        ],
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
        return Padding(
        padding: const EdgeInsets.only(left: 10, top: 20,right: 10),
        child: CustomCard(
          color: myColor.background,
          elevation: 2,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 85.h,
                width: 100.w,
                child: ClipRRect(
                    borderRadius:
                        BorderRadius.horizontal(left: Radius.circular(10)),
                    child: Image.asset(
                      backgroundimage[2],
                      fit: BoxFit.cover,
                    )),
              ),
              Container(
                height: 85.h,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(10)),
                ),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                          ),
                          child: Row(
                            children: [
                              CustomText(
                                  text: "Hilite villa ",
                                  size: 13,
                                  weight: FontWeight.w500,
                                  color: myColor.textcolor)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: Row(
                            children: [
                              CustomText(
                                  text: "nova  auditorium,\npalazhi",
                                  size: 10,
                                  weight: FontWeight.w400,
                                  color: myColor.textcolor),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AgencyChatList(),));
                            },
                            icon: Icon(Icons.chat_bubble_outline_rounded)
                          ),
                          
                          PopupMenuButton(
                            color: myColor.background,
                            itemBuilder: (context) {
                            
                            return [
                              PopupMenuItem(child: Text("Edit")),
                              PopupMenuItem(child: Text("Delete"))
                            ];
                          },)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
      },),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: myColor.maincolor,
          onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AgencyaddItem()));
          },
          child: Icon(
            Icons.add,
            size: 40,
            color: myColor.background,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
