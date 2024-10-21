import 'package:cloud_firestore/cloud_firestore.dart';
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
        body: StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Users").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          Center(child: Text("Error: ${snapshot.error}"));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No items found"));
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var userdata = snapshot.data!.docs[index];
            // var userid = userdata.id;
            var name = userdata["Name"];
            var userImageUrl = userdata["ImageUrl"];
            

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomCard(
                  child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[400],
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AdminUserDetails(userdata: userdata),
                        ));
                  },
                  leading: CircleAvatar(
                    backgroundImage: (userImageUrl != null && userImageUrl.isNotEmpty)
                          ? NetworkImage(userImageUrl)
                          : AssetImage("assets/images/User 1.png"),
                  ),
                  title: CustomText(
                      text: name,
                      size: 15,
                      weight: FontWeight.w500,
                      color: myColor.textcolor),
                ),
              )),
            );
          },
        );
      },
    ));
  }
}
