import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/view/widgets/appbar.dart';
import 'package:hommie/view/widgets/custom_card.dart';
import 'package:hommie/view/widgets/custom_text.dart';
import 'package:hommie/view/agency/agencyhome/agencyaccount/agency_history_details.dart';

class AgencyHistory extends StatelessWidget {
  const AgencyHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColor.background,
      appBar: CustomAppBar(
        automaticallyImplyLeading: false,
        title: "History"),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, top: 20),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AgencyHistoryDetails()));
          },
          child: CustomCard(
            elevation: 2,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 85.h,
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
                  height: 85.h,
                  width: 230.w,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.horizontal(right: Radius.circular(10)),
                    color: myColor.background,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                            ),
                            child: Row(
                              children: [
                                CustomText(
                                    text: "Hilite villa ",
                                    size: 13,
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
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 60, right: 20),
                        child: Row(
                          children: [
                            CustomText(
                                text: "Completed",
                                size: 12,
                                weight: FontWeight.w500,
                                color: myColor.textcolor)
                          ],
                        ),
                      )
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
