import 'package:flutter/material.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/view/widgets/custom_text.dart';
import 'package:lottie/lottie.dart';

class AgencyAddedSuccessfully extends StatelessWidget {
  const AgencyAddedSuccessfully({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColor.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset("assets/json/successfully.json",fit: BoxFit.cover,width: 200),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CustomText(text: "Successfully Added", size: 22, weight: FontWeight.w500, color: myColor.textcolor),
              )
            ],
          )
        ],
      ),
    );
  }
}