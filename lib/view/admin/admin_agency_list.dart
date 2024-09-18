import 'package:flutter/material.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/view/widgets/custom_card.dart';
import 'package:hommie/view/widgets/custom_text.dart';
import 'package:hommie/view/admin/admin_agency_details.dart';

class AdminAgencyList extends StatelessWidget {
  const AdminAgencyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomCard(
              child: InkWell(
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => AdminAgencyDetails(),));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[400],
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(icons[5]),
                ),
                title: CustomText(
                    text: "Agency Name",
                    size: 15,
                    weight: FontWeight.w500,
                    color: myColor.textcolor),
              ),
            ),
          )),
        )
    );
  }
}