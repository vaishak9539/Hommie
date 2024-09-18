import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/view/widgets/custom_card.dart';
import 'package:hommie/view/widgets/appbar.dart';
import 'package:hommie/view/widgets/custom_text.dart';
import 'package:hommie/view/user/home/user_account/user_history_details.dart';

class UserHistory extends StatelessWidget {
  const UserHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColor.background,
      appBar: CustomAppBar(title: "History"),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserHistoryDetails(),
                ));
          },
          child: CustomCard(
            elevation: 4,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 85.h,
                  width: 90.w,
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
                  width: 240.w,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.horizontal(right: Radius.circular(10)),
                    color: Color.fromARGB(255, 231, 246, 245),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        child: Row(
                          children: [
                            CustomText(
                                text: "Hilite villa ",
                                size: 14,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CustomText(
                                text: "Completed",
                                size: 12,
                                weight: FontWeight.w500,
                                color: myColor.textcolor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
