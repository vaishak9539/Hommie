import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/model/utils/widgets/appbar.dart';
import 'package:hommie/model/utils/widgets/custom_text.dart';

class UserHistoryDetails extends StatelessWidget {
  const UserHistoryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColor.background,
      appBar: CustomAppBar(title: "Property details"),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,top: 50,right: 20),
        child: Column(
          children: [
            Container(
              height: 190.h,
              width: 320.w,
             decoration:  BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                image: DecorationImage(image: AssetImage(backgroundimage[2]),fit: BoxFit.cover)
              ),
            ),
            Container(
              height: 210,
              width: 320,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
                color: Colors.teal.withOpacity(0.3)
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: CustomText(text: "agency Name", size: 15, weight: FontWeight.w400, color: myColor.textcolor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: CustomText(text: "Property Name", size: 15, weight: FontWeight.w400, color: myColor.textcolor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: CustomText(text: "Date", size: 15, weight: FontWeight.w400, color: myColor.textcolor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: CustomText(text: "Amount", size: 15, weight: FontWeight.w400, color: myColor.textcolor),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: CustomText(text: ":", size: 15, weight: FontWeight.w400, color: myColor.textcolor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: CustomText(text: ":", size: 15, weight: FontWeight.w400, color: myColor.textcolor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: CustomText(text: ":", size: 15, weight: FontWeight.w400, color: myColor.textcolor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: CustomText(text: ":", size: 15, weight: FontWeight.w400, color: myColor.textcolor),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: CustomText(text: "agency", size: 15, weight: FontWeight.w400, color: myColor.textcolor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: CustomText(text: "Hilite villa", size: 15, weight: FontWeight.w400, color: myColor.textcolor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: CustomText(text: "10/6/2024", size: 15, weight: FontWeight.w400, color: myColor.textcolor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: CustomText(text: "35,00000", size: 15, weight: FontWeight.w400, color: myColor.textcolor),
                        ),
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
  }
}