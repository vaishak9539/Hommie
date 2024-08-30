import 'package:flutter/material.dart';
import 'package:hommie/model/utils/widgets/cu_inkwell_button.dart';

class Select  extends StatelessWidget {
  const Select ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomInkwellButton(onTap: () {
                Navigator.pushReplacementNamed(context,"Slider1");
              }, text: "User"),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: CustomInkwellButton(onTap: () {
              Navigator.pushNamed(context,"AgencyLogin");
            }, text: "Agency"),
          ),
        ],
      ),
    );
  }
}