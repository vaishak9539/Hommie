import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/provider/user_home_saved_provider.dart';
import 'package:hommie/utils/color.dart';
import 'package:hommie/utils/img_path.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class UserViewHome extends StatelessWidget {
  const UserViewHome({super.key});

  @override
  Widget build(BuildContext context) {
   final userHomeSavedProvider =Provider.of<UserHomeSavedProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(title: "Home"),
      body: GridView.builder(
        itemCount: 4,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 9 / 12, 
        ),
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(8)),
                        child: Image.asset(
                          backgroundimage[2],
                          height: 100.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 8),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    text: "New Home",
                                    size: 14,
                                    weight: FontWeight.w500,
                                    color: myColor.textcolor),
                                CustomText(
                                    text: "nova auditorium\npalazhi",
                                    size: 12,
                                    weight: FontWeight.w400,
                                    color: myColor.textcolor),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: CustomText(
                                      text: "35 L",
                                      size: 17,
                                      weight: FontWeight.w600,
                                      color: myColor.textcolor),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10,right: 8),
                  child: IconButton(
                      onPressed: () {
                         userHomeSavedProvider.usercheckSaved(index);
                      },
                      icon: userHomeSavedProvider.isHomeSaved(index)
                      ? Image.asset(
                          icons[2],
                          width: 20,
                        )
                      : Image.asset(
                          icons[3],
                          width: 20,
                        ),
                      ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}