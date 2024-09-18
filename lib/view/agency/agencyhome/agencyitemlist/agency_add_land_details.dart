import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/view/widgets/appbar.dart';
import 'package:hommie/view/widgets/cu_inkwell_button.dart';
import 'package:hommie/view/widgets/custom_textfield.dart';
import 'package:hommie/view/agency/agencyhome/agencyitemlist/agency_added_successfully.dart';

class AgencyAddLandDetails extends StatelessWidget {
  const AgencyAddLandDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColor.background,
      appBar: CustomAppBar(title: "Add Details"),
      body: SingleChildScrollView(
        child: Column(
          children: [
             Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Container(
                  height: 250.h,
                  width: double.infinity,
                  color: Colors.grey[350],
                  child: Center(
                      child: Image.asset(
                    icons[6],
                    width: 170,
                    color: Colors.black,
                  )),
                ),
              ),
        
               Padding(
                padding: const EdgeInsets.only(top: 10),
                child: CuTextField(
                  hintText: "Name",
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(top: 10),
                child: CuTextField(
                  hintText: "Sqft",
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(top: 10),
                child: CuTextField(
                  hintText: "location",
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(top: 10),
                child: CuTextField(
                  hintText: "Road Name",
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(top: 10),
                child: CuTextField(
                  hintText: "Landmark",
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(top: 10),
                child: CuTextField(
                  hintText: "City/Pincode",
                ),
              ),
               
               Padding(
                padding: const EdgeInsets.only(top: 10),
                child: CuTextField(
                  hintText: "Set Prize",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5,right: 5,top: 30),
                  child: CustomTextField(
                    
                    hintText: "Description",
                    hintStyle: TextStyle(
                      backgroundColor: Colors.blue
                    ),
                    borderColor: myColor.textcolor.withOpacity(0.5),
                    maxLines: 5,
                    textColor: myColor.textcolor,
                    
                  ),
                ),
              ),
              SizedBox(
              height: 30.h,
            ),
            CustomInkwellButton(
              height: 40.h,
              width: 300.w,
              onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => AgencyAddedSuccessfully()));
            }, text: "Next"),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }
}