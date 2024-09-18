import 'package:flutter/material.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/view/widgets/custom_text.dart';

class AgencyTermsConditions extends StatelessWidget {
  const AgencyTermsConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColor.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
            text: "Terms & Conditions",
            size: 18,
            weight: FontWeight.w500,
            color: Colors.black),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20),
        child: Column(
          children: const [
            Text(
                " Lorem ipsum dolor sit, amet consectetur adipisicing elit. Ut optio commodi mollitia sint odio sit  recusandae eum, iusto dolorum nulla iste odit, quia ipsam porro aperiam, corrupti officiis expedita natus?"),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                  " Lorem ipsum dolor sit, amet consectetur adipisicing elit. Ut optio commodi mollitia sint odio sit  recusandae eum, iusto dolorum nulla iste odit, quia ipsam porro aperiam, corrupti officiis expedita natus?"),
            ),
          ],
        ),
      ),
    );
  }
}