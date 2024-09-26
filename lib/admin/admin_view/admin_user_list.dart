import 'package:flutter/material.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/widgets/custom_card.dart';
import 'package:hommie/widgets/custom_text.dart';
import 'package:hommie/admin/admin_view/admin_user_details.dart';

class AdminUserList extends StatelessWidget {
  const AdminUserList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomCard(
              child: InkWell(
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => AdminUserDetails(),));
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
                    text: "users Name",
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