// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/model/utils/widgets/appbar.dart';
import 'package:hommie/model/utils/widgets/custom_card.dart';
import 'package:hommie/model/utils/widgets/custom_text.dart';
import 'package:hommie/model/utils/widgets/custom_textfield.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColor.background,
      appBar: CustomAppBar(
        title: "Home",
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(onPressed: () {
              Navigator.pushNamed(context, "User Notification");
            }, icon: Image.asset(
              icons[1],
              width: 25,
            ),)
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 33.h,
            child: CustomTextField(
              contentPadding: EdgeInsets.all(10),
              prefixIcon: Icon(Icons.search_rounded),
              fillColor: myColor.tabcolor,
              filled: true,
              borderWidth: 0,
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "User Property View");
                },
                child: CustomCard(
                  color: Color(0xffEEF7FF),
                  elevation: 4,
                  child: Container(
                    height: 220,
                    width: 160,
                    child:  Column(
                    
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(8)),
                        child: Image.asset(
                          backgroundimage[2],
                          height: 100.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 8),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    text: "New Home",
                                    size: 14,
                                    weight: FontWeight.w500,
                                    color: myColor.textcolor),
                                CustomText(
                                    text: "nova auditorium\npalazhi",
                                    size: 12,
                                    weight: FontWeight.w400,
                                    color: myColor.textcolor),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: CustomText(
                                          text: "35 L",
                                          size: 17,
                                          weight: FontWeight.w600,
                                          color: myColor.textcolor),
                                    ),
                                     Padding(
                                       padding: const EdgeInsets.only(left: 72),
                                       child: IconButton(onPressed: () {
                                         
                                       }, icon: Image.asset(icons[3],width: 20,)),
                                     )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  )
                ),
              )),
        ],
      ),
    );
  }
}
