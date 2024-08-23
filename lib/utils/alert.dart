import 'package:flutter/material.dart';

void userDeleteAccount(String title, String content, String delete, String cancel, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title,style: TextStyle(
          color: Colors.red
        ),),
        content: Text(content,style: TextStyle(
          color: Colors.black
        ),),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(cancel,style: TextStyle(
          color: Colors.black
        ),),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(delete,style: TextStyle(
          color: Colors.red
        ),),
          ),
        ],
      );
    },
  );
}

 userLogoutdialogbox(String content, String logout, String cancel, BuildContext context){
  showDialog(context: context, builder: (context) {
    return AlertDialog(
      content: Text(content,style: TextStyle(
        fontSize: 15
        ),),
      actions: [
        TextButton(onPressed: () {
          Navigator.pop(context);
        }, child: Text(cancel,style: TextStyle(
          color: Colors.black
        ),)),
        TextButton(onPressed: () {
          Navigator.pop(context);
        }, child: Text(logout,style: TextStyle(
          color: Colors.red
        ),))
      ],
    );
  },);
}
