import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/utils/color.dart';
import 'package:hommie/utils/img_path.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/cu_inkwell_button.dart';
import 'package:hommie/widgets/custom_textfield.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColor.background,
      appBar: CustomAppBar(title: "Edit Profile"),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    icons[5],
                    width: 90,
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              CuTextField(
                hintText: "Name",
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CuTextField(
                  hintText: "Mobile No",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CuTextField(
                  hintText: "Email",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CuTextField(
                  hintText: "District",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CuTextField(
                  hintText: "State",
                ),
              ),
              SizedBox(
                height: 60.h,
              ),
              CustomInkwellButton(onTap: () {
                Navigator.pop(context);
              }, text: "Done")
          ],
        ),
      ),
    );
  }
}