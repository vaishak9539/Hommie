import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/custom_card.dart';
import 'package:hommie/widgets/custom_text.dart';
import 'package:hommie/user/user_view/home/user_notification.dart';

class UserSaved extends StatelessWidget {
  const UserSaved({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: myColor.background,
        appBar: CustomAppBar(
          automaticallyImplyLeading: false,
          title: "Saved",
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserNotification(),));
                  },
                  icon: Image.asset(
                    icons[1],
                    width: 25,
                  ),
                )),
          ],
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: Card(
                elevation: 4,
                child: Container(
                  height: 280.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 231, 246, 245),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, top: 10, right: 10),
                            child: CustomCard(
                                child: SizedBox(
                              height: 160.h,
                              width: 292.w,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.asset(
                                    backgroundimage[1],
                                    height: 180.h,
                                    fit: BoxFit.cover,
                                  )),
                            )),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18, top: 8),
                        child: CustomText(
                            text: "New Home",
                            size: 20,
                            weight: FontWeight.bold,
                            color: myColor.textcolor),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 18),
                            child: Image.asset(
                              icons[4],
                              width: 15,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 6, top: 5),
                            child: CustomText(
                                text: "nova  auditorium,\npalazhi",
                                size: 13,
                                weight: FontWeight.w400,
                                color: myColor.textcolor),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, top: 5),
                        child: CustomText(
                            text: "35,0000",
                            size: 23,
                            weight: FontWeight.bold,
                            color: myColor.textcolor),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 60,
              right: 40,
              child: IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    icons[2],
                    width: 28,
                  )),
            ),
          ],
        ));
  }
}
