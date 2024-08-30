import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/widgets/appbar.dart';
import 'package:hommie/model/utils/widgets/cu_inkwell_button.dart';
import 'package:hommie/model/utils/widgets/custom_text.dart';
import 'package:hommie/model/utils/widgets/custom_textfield.dart';

class AgencyFeedback extends StatelessWidget {
  const AgencyFeedback({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColor.background,
      appBar: CustomAppBar(title: "Feedback"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20),
                  child: CustomText(
                      text: "How do you rate this app ?",
                      size: 15,
                      weight: FontWeight.w400,
                      color: myColor.textcolor),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20,top: 15),
                  child: RatingBar.builder(
                    initialRating: 1,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 7.0),
                    itemBuilder: (ctx, _) {
                      return const Icon(
                        Icons.star,
                        color: Colors.amber,
                      );
                    },
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20,top: 50),
                  child: CustomText(text: "Describe your experience here", size: 15, weight: FontWeight.w400, color: myColor.textcolor),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: CustomTextField(
                filled: true,
                hintText: "Write here",
                textColor: myColor.textcolor,
                fillColor: Colors.grey[200],
                maxLines: 10,
              ),
            ),
           
           Padding(
             padding:  EdgeInsets.only(top: 60.h,bottom: 50.h),
             child: CustomInkwellButton(onTap: () {
               
             }, text: "Submit"),
           )
          ],
        ),
      ),
    );
  }
}