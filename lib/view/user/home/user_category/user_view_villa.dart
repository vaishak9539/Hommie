import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/model/utils/widgets/appbar.dart';
import 'package:hommie/model/utils/widgets/custom_text.dart';
import 'package:hommie/view/user/userprovider/user_provider_class.dart';
import 'package:provider/provider.dart';

class UserViewVilla extends StatelessWidget {
  const UserViewVilla({super.key});

  @override
  Widget build(BuildContext context) {
    final userVillaSavedProvider = Provider.of<UserVillaSavedProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(title: "Villa"),
      body: GridView.builder(
        itemCount: 4,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                        child: Image.asset(
                          backgroundimage[2],
                          height: 100.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Hilite Villa",
                              size: 14,
                              weight: FontWeight.w500,
                              color: myColor.textcolor,
                            ),
                            CustomText(
                              text: "nova auditorium\npalazhi",
                              size: 12,
                              weight: FontWeight.w400,
                              color: myColor.textcolor,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: CustomText(
                                text: "35 L",
                                size: 17,
                                weight: FontWeight.w600,
                                color: myColor.textcolor,
                              ),
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
                  padding: const EdgeInsets.only(bottom: 10, right: 8),
                  child: IconButton(
                    onPressed: () {
                      userVillaSavedProvider.userVillaSaved(index);
                    },
                    icon: userVillaSavedProvider.isvillaSaved(index)
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
