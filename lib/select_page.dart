import 'package:flutter/material.dart';
import 'package:hommie/view/widgets/cu_inkwell_button.dart';
import 'package:hommie/view/admin/admin_login.dart';
import 'package:hommie/view/agency/agencylogin/agency_login.dart';
import 'package:hommie/view/user/login/slider1.dart';

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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Slider1(),));
              }, text: "User"),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: CustomInkwellButton(onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AgencyLogin(),));
            }, text: "Agency"),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: CustomInkwellButton(onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => AdminLogin(),));
            }, text: "Admin"),
          ),
         
        ],
      ),
    );
  }
}