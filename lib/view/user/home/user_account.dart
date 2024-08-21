import 'package:flutter/material.dart';
import 'package:hommie/utils/color.dart';
import 'package:hommie/utils/img_path.dart';
import 'package:hommie/widgets/appbar.dart';

class UserAccount extends StatelessWidget {
  const UserAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColor.background,
      appBar: CustomAppBar(title: "Account",
      actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Image.asset(
              icons[1],
              width: 25,
            ),
          ),
          
        ],
      ),
    );
  }
}