import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/widgets/custom_text.dart';

class WithGoogle extends StatelessWidget {
  const WithGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            
          },
          child: Container(
            height: ScreenUtil().setHeight(42),
            width: ScreenUtil().setWidth(250),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(31),
              color: Color(0xffFFFFFF)
            ),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 23),
                  child: Image.asset("assets/images/google.png",height: 28,width: 28,),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: CustomText(text: "continue with google", size: 14, weight: FontWeight.w400, color: Colors.black),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}