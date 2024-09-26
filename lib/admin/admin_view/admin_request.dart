import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/cu_inkwell_button.dart';
import 'package:hommie/widgets/custom_text.dart';

class AdminRequest extends StatelessWidget {
  const AdminRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColor.background,
      appBar: CustomAppBar(title: "Request details"),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 50, right: 20),
        child: Column(
          children: [
           
            Container(
              height: 210.h,
              width: 320.w,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(8),
                color: Color.fromARGB(255, 231, 246, 245),
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
                          child: CustomText(
                              text: "agency Name",
                              size: 15,
                              weight: FontWeight.w400,
                              color: myColor.textcolor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: CustomText(
                              text: "Buyer Name",
                              size: 15,
                              weight: FontWeight.w400,
                              color: myColor.textcolor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: CustomText(
                              text: "Property Name",
                              size: 15,
                              weight: FontWeight.w400,
                              color: myColor.textcolor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: CustomText(
                              text: "Selling Date",
                              size: 15,
                              weight: FontWeight.w400,
                              color: myColor.textcolor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: CustomText(
                              text: "Selling Price",
                              size: 15,
                              weight: FontWeight.w400,
                              color: myColor.textcolor),
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
                          child: CustomText(
                              text: ":",
                              size: 15,
                              weight: FontWeight.w400,
                              color: myColor.textcolor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: CustomText(
                              text: ":",
                              size: 15,
                              weight: FontWeight.w400,
                              color: myColor.textcolor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: CustomText(
                              text: ":",
                              size: 15,
                              weight: FontWeight.w400,
                              color: myColor.textcolor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: CustomText(
                              text: ":",
                              size: 15,
                              weight: FontWeight.w400,
                              color: myColor.textcolor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: CustomText(
                              text: ":",
                              size: 15,
                              weight: FontWeight.w400,
                              color: myColor.textcolor),
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
                          child: CustomText(
                              text: "agency",
                              size: 15,
                              weight: FontWeight.w400,
                              color: myColor.textcolor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: CustomText(
                              text: "Hilite villa",
                              size: 15,
                              weight: FontWeight.w400,
                              color: myColor.textcolor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: CustomText(
                              text: "Green Villa",
                              size: 15,
                              weight: FontWeight.w400,
                              color: myColor.textcolor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: CustomText(
                              text: "10/6/2024",
                              size: 15,
                              weight: FontWeight.w400,
                              color: myColor.textcolor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: CustomText(
                              text: "35,00000",
                              size: 15,
                              weight: FontWeight.w400,
                              color: myColor.textcolor),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: CustomInkwellButton(onTap: () {
                    
                  }, text: "accept"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}