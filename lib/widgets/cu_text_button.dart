import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double? size;
  final FontWeight? weight;
  final Color? color;

  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.size=16,
    this.weight=FontWeight.w500,
    this.color=Colors.white
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: size,
          fontWeight: weight,
          color: color
        ),
      )
    );
  }
}
