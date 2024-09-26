// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/agency/view/agencyhome/agencyitemlist/agency_chat.dart';
import 'package:hommie/user/user_view/home/user_chat/user_chat.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/custom_card.dart';

class AgencyChatList extends StatelessWidget {
  const AgencyChatList({super.key});
  
  @override
  Widget build(BuildContext context) {
    final List chat = [AgencyChat()];
    return Scaffold(
      backgroundColor: myColor.background,
      appBar: CustomAppBar(title: "Chats"),

      body: ListView.builder(itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,),
          child: CustomCard(
            child: SizedBox(
              height: 60,
              child: ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => chat[index],));
                },
                leading: CircleAvatar(
                  backgroundImage: AssetImage(icons[5]),
                ),
                title: Text("Arun"),
                trailing: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Icon(Icons.cancel_outlined,color:myColor.errortext,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(Icons.check_circle_outline,color: Colors.green,),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }, itemCount: 2),
    );
  }
}