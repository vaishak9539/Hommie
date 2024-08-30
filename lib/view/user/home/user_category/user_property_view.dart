import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/model/utils/widgets/cu_inkwell_button.dart';
import 'package:hommie/model/utils/widgets/custom_text.dart';

class UserPropertyView extends StatelessWidget {
  const UserPropertyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          height: 390.h,
          width: double.infinity,
          child: Image.asset(
            backgroundimage[1],
            height: 400,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 10),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: myColor.background,
                size: 30,
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 320.h,
            width: double.infinity,
            decoration: BoxDecoration(
                color: myColor.background,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 25),
                        child: CustomText(
                            text: "Greenvally Villa",
                            size: 20,
                            weight: FontWeight.w500,
                            color: myColor.textcolor),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          children: [
                            Image.asset(
                              icons[4],
                              width: 15,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text("Golden bazhar building,\nPalazhi road")
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: CustomText(
                            text: "20,0000",
                            size: 20,
                            weight: FontWeight.w500,
                            color: myColor.textcolor),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: CustomText(
                            text: "Description",
                            size: 15,
                            weight: FontWeight.w500,
                            color: myColor.textcolor),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding:
                            const EdgeInsets.only(left: 20, top: 10, right: 15),
                        child: CustomText(
                            text:
                                "Set 12 km from Kanthanpara Waterfalls, Green Valley Holiday Home offers accommodation with free WiFi and free private parking. Some units feature a dining area and/or a balcony. Guests at the homestay can4 enjoy a vegetarian breakfast.",
                            size: 11,
                            weight: FontWeight.normal,
                            letterSpacing: 1,
                            color: myColor.textcolor),
                      ))
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30, left: 20),
                        child: CustomText(
                            text: "Details",
                            size: 15,
                            weight: FontWeight.w500,
                            color: myColor.textcolor),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 21),
                              child: CustomText(
                                  text: "Type",
                                  size: 13,
                                  weight: FontWeight.w400,
                                  color: myColor.textcolor),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: CustomText(
                                  text: "Bedroom",
                                  size: 13,
                                  weight: FontWeight.w400,
                                  color: myColor.textcolor),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: CustomText(
                                  text: "Bathrooms",
                                  size: 13,
                                  weight: FontWeight.w400,
                                  color: myColor.textcolor),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: CustomText(
                                  text: "Furnishing",
                                  size: 13,
                                  weight: FontWeight.w400,
                                  color: myColor.textcolor),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: CustomText(
                                  text: "Sqft",
                                  size: 13,
                                  weight: FontWeight.w400,
                                  color: myColor.textcolor),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: CustomText(
                                  text: "Total Floors",
                                  size: 13,
                                  weight: FontWeight.w400,
                                  color: myColor.textcolor),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              child: CustomText(
                                  text: "Car Parking",
                                  size: 13,
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
                            CustomText(
                                text: ":",
                                size: 15,
                                weight: FontWeight.w500,
                                color: myColor.textcolor),
                            Padding(
                              padding: const EdgeInsets.only(top: 18),
                              child: CustomText(
                                  text: ":",
                                  size: 15,
                                  weight: FontWeight.w500,
                                  color: myColor.textcolor),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 18),
                              child: CustomText(
                                  text: ":",
                                  size: 15,
                                  weight: FontWeight.w500,
                                  color: myColor.textcolor),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 18),
                              child: CustomText(
                                  text: ":",
                                  size: 15,
                                  weight: FontWeight.w500,
                                  color: myColor.textcolor),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 18),
                              child: CustomText(
                                  text: ":",
                                  size: 15,
                                  weight: FontWeight.w500,
                                  color: myColor.textcolor),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 18),
                              child: CustomText(
                                  text: ":",
                                  size: 15,
                                  weight: FontWeight.w500,
                                  color: myColor.textcolor),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 18),
                              child: CustomText(
                                  text: ":",
                                  size: 15,
                                  weight: FontWeight.w500,
                                  color: myColor.textcolor),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 21),
                              child: CustomText(
                                  text: "Villa",
                                  size: 13,
                                  weight: FontWeight.w400,
                                  color: myColor.textcolor),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: CustomText(
                                  text: "4",
                                  size: 13,
                                  weight: FontWeight.w400,
                                  color: myColor.textcolor),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: CustomText(
                                  text: "4",
                                  size: 13,
                                  weight: FontWeight.w400,
                                  color: myColor.textcolor),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: CustomText(
                                  text: "Furnished",
                                  size: 13,
                                  weight: FontWeight.w400,
                                  color: myColor.textcolor),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: CustomText(
                                  text: "2000",
                                  size: 13,
                                  weight: FontWeight.w400,
                                  color: myColor.textcolor),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: CustomText(
                                  text: "2",
                                  size: 13,
                                  weight: FontWeight.w400,
                                  color: myColor.textcolor),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 19),
                              child: CustomText(
                                  text: "3",
                                  size: 13,
                                  weight: FontWeight.w400,
                                  color: myColor.textcolor),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomInkwellButton(
                width: 330, height: 45, onTap: () {}, text: "Contact Now"),
          ),
        )
      ],
    ));
  }
}
