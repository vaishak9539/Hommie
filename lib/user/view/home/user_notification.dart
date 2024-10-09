import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/custom_card.dart';
import 'package:hommie/widgets/custom_text.dart';

class UserNotification extends StatelessWidget {
  const UserNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColor.background,
      appBar: CustomAppBar(title: "Notification"),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 10),
        child: CustomCard(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 90.h,
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
                height: 90.h,
                width: 220.w,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.horizontal(right: Radius.circular(10)),
                    color: myColor.background),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 25, left: 10),
                          child: CustomText(
                              text: "Hilite Villa",
                              size: 15,
                              weight: FontWeight.w500,
                              color: myColor.textcolor),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 10),
                          child: CustomText(
                              text: "New villa added, check Now",
                              size: 13,
                              weight: FontWeight.w400,
                              color: myColor.textcolor),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
