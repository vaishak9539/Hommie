import 'package:flutter/material.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/user/user_view/home/user_chat/user_chat.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/custom_card.dart';

class UserChatList extends StatelessWidget {
  const UserChatList({super.key});
  
  @override
  Widget build(BuildContext context) {
    final List chat = [UserChat()];
    return Scaffold(
      backgroundColor: myColor.background,
      appBar: CustomAppBar(title: "Chats"),

      body: ListView.builder(itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: CustomCard(
            child: ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => chat[index],));
              },
              leading: CircleAvatar(
                backgroundImage: AssetImage(icons[5]),
              ),
              title: Text("Agency name"),
              subtitle: Text("Hilite Villa"),
            ),
          ),
        );
      },
       itemCount: 2),
    );
  }
}