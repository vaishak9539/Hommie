import 'package:flutter/material.dart';
import 'package:hommie/utils/color.dart';
import 'package:hommie/utils/img_path.dart';
import 'package:hommie/widgets/appbar.dart';

class UserSaved extends StatelessWidget {
  const UserSaved({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColor.background,
      appBar: CustomAppBar(title: "Saved",
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