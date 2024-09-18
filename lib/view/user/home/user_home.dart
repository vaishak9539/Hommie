// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/view/widgets/appbar.dart';
import 'package:hommie/view/widgets/custom_card.dart';
import 'package:hommie/view/widgets/custom_text.dart';
import 'package:hommie/view/widgets/custom_textfield.dart';
import 'package:hommie/view/user/home/user_category/user_property_view.dart';
import 'package:hommie/view/user/home/user_notification.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
            child: IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserNotification(),));
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
            padding: const EdgeInsets.only(left: 15,top: 15),
            child: CustomText(text: "Recomented", size: 17, weight: FontWeight.w500, color: myColor.textcolor),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserPropertyView(),));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomCard(
                  color: Color.fromARGB(255, 231, 246, 245),
                  elevation: 4,
                  child: SizedBox(
                    height: 200.h,
                    width: 160.w,
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
                CustomCard(
                  color: Color.fromARGB(255, 231, 246, 245),
                  elevation: 4,
                  child: SizedBox(
                    height: 200.h,
                    width: 160.w,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
