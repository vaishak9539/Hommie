import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hommie/model/utils/style/color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? backgroundColor;
  final Color? color;
  final List<Widget>? actions;
  final Widget? leading;
  final double? height;
  final double? size;
  final bool automaticallyImplyLeading;
  CustomAppBar({
    Key? key,
    required this.title,
    this.backgroundColor = myColor.background,
    this.color=Colors.black,
    this.actions,
    this.leading,
    this.height = kToolbarHeight,
    this.size,
    this.automaticallyImplyLeading = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: color,
            fontSize: size ?? 20,
          ),
        ),
      ),
      centerTitle: true,
      backgroundColor: backgroundColor,
      actions: actions,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);
}
