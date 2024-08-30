import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/widgets/appbar.dart';
import 'package:hommie/model/utils/widgets/cu_inkwell_button.dart';
import 'package:hommie/model/utils/widgets/custom_textfield.dart';

class AgencyBadge extends StatelessWidget {
  const AgencyBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColor.background,
      appBar: CustomAppBar(title: "Sales Report"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 35),
              child: CuTextField(
                hintText: "Agency Name",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CuTextField(
                hintText: "Buyer Name",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CuTextField(
                hintText: "Buyer Email",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CuTextField(
                hintText: "Buyer Phone No",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CuTextField(
                hintText: "Property Name",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CuTextField(
                hintText: "Selling Date",
                suffixIcon: IconButton(
                    onPressed: () {}, icon: Icon(Icons.calendar_month)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CuTextField(
                hintText: "Selling Price",
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            CustomInkwellButton(onTap: () {
              
            }, text: "Submit")
          ],
        ),
      ),
    );
  }
}
