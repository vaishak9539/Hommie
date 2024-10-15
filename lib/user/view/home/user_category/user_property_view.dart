import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/user/view/home/user_chat/user_chat_list.dart';
import 'package:hommie/widgets/cu_inkwell_button.dart';
import 'package:hommie/widgets/custom_text.dart';
import 'package:hommie/user/view/home/user_category/user_agency_profile_view.dart';
import 'package:hommie/user/userprovider/user_provider_class.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class UserPropertyView extends StatefulWidget {
  const UserPropertyView({super.key});

  @override
  State<UserPropertyView> createState() => _UserPropertyViewState();
}

class _UserPropertyViewState extends State<UserPropertyView> {
  var activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    // final smoothIndicatorProvider =
        // Provider.of<SmoothIndicatorProvider>(context);
    return Scaffold(
        body: Stack(
      children: [
        CarouselSlider.builder(
            itemCount: backgroundimage.length,
            itemBuilder: (context, index, realIndex) {
              return SizedBox(
                width: double.infinity,
                child: Image.asset(
                  backgroundimage[index],
                  height: 390.h,
                  fit: BoxFit.cover,
                ),
              );
            },
            options: CarouselOptions(
              height: 390.h,
              onPageChanged: (index, reason) {
                setState(() {
                  activeIndex = index;
                });
              },
            )),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: AnimatedSmoothIndicator(
                      activeIndex: activeIndex,
                      count: backgroundimage.length,
                      effect: JumpingDotEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        activeDotColor: Colors.red,
                        dotColor: Colors.grey,
                        spacing: 8,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 23,top: 5),
                        child: CustomText(
                            text: "₹20,0000",
                            size: 18,
                            weight: FontWeight.w500,
                            color: myColor.textcolor),
                      ),
                    ],
                  ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 20, top: 20),
                      //   child: CustomText(
                      //       text: "Greenvally Villa",
                      //       size: 17,
                      //       weight: FontWeight.w500,
                      //       color: myColor.textcolor),
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.only(right: 23, top: 15),
                      //       child: CustomText(
                      //           text: "₹20,0000",
                      //           size: 18,
                      //           weight: FontWeight.w500,
                      //           color: myColor.textcolor),
                      //     ),
                      //   ],
                      // ),
                       Padding(
                        padding: const EdgeInsets.only(right: 25),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => UserAgencyProfileView(),));
                          },
                          child: CircleAvatar(backgroundImage: AssetImage(icons[5]),)),
                      )
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
                        padding: const EdgeInsets.only(left: 8, top: 5),
                        child: Column(
                          children: const [
                            Text("Golden bazhar building,\nPalazhi road")
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(left: 23,top: 5),
                  //       child: CustomText(
                  //           text: "₹20,0000",
                  //           size: 18,
                  //           weight: FontWeight.w500,
                  //           color: myColor.textcolor),
                  //     ),
                  //   ],
                  // ),
                  Divider(),
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
                    height: 50.h,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomInkwellButton(
                    width: 300.w, height: 45.h, onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UserChatList(),));
                    },
                    icon: Icon(Icons.chat,color: myColor.background,),
                     text: "Chat",fontWeight: FontWeight.w500,),
               
              ],
            ),
          ),
        )
      ],
    ));
  }
}
