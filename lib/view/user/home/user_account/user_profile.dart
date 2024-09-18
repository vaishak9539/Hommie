import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/view/widgets/appbar.dart';
import 'package:hommie/view/widgets/cu_inkwell_button.dart';
import 'package:hommie/view/widgets/custom_textfield.dart';

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
                SizedBox(
                  width: 86.w,
                  height: 86.h,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(icons[5]),
                        radius: 43,
                      ),
                      Positioned(
                        bottom: -2,
                        right: -11,
                        child: IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            icons[6],
                            width: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
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
            CustomInkwellButton(
                onTap: () {
                  Navigator.pop(context);
                },
                text: "Done")
          ],
        ),
      ),
    );
  }
}
