import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/view/widgets/appbar.dart';
import 'package:hommie/view/widgets/custom_card.dart';
import 'package:hommie/view/widgets/custom_text.dart';
import 'package:hommie/view/user/home/user_category/user_property_view.dart';

class UserViewApartment extends StatelessWidget {
  const UserViewApartment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColor.background,
      appBar: CustomAppBar(title: "Apartment"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserPropertyView(),
                      ));
                },
                child: CustomCard(
                    color: Color.fromARGB(255, 231, 246, 245),
                    elevation: 4,
                    child: SizedBox(
                      height: 200.h,
                      width: 160.w,
                      child: Column(
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
                                          padding:
                                              const EdgeInsets.only(top: 8),
                                          child: CustomText(
                                              text: "35 L",
                                              size: 17,
                                              weight: FontWeight.w600,
                                              color: myColor.textcolor),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 72),
                                          child: IconButton(
                                              onPressed: () {},
                                              icon: Image.asset(
                                                icons[3],
                                                width: 20,
                                              )),
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
                    )),
              )),
        ],
      ),
    );
  }
}
