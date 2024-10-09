import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hommie/model/utils/style/color.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Color? textColor;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final EdgeInsets contentPadding;
  final EdgeInsets outlinePadding;
  final FontWeight? fontWeight;
  final double fontSize;
  final IconButton? suffixIcon;
  final Icon? prefixIcon;
  final DropdownButton<String>? dropdownButton;
  final FormFieldValidator<String>? validator;
  final int maxLines;
  final bool filled;
  final Color? fillColor;
  final Color? cursorColor;
  final TextStyle? hintStyle;

  CustomTextField({
    Key? key,
    this.controller,
    this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.textColor = Colors.white,
    this.borderColor = Colors.white,
    this.borderWidth = 2.0,
    this.borderRadius = 8.0,
    this.contentPadding = const EdgeInsets.all(10.0),
    this.outlinePadding = const EdgeInsets.only(left: 20, right: 20),
    this.fontWeight = FontWeight.normal,
    this.fontSize = 16.0,
    this.dropdownButton,
    this.suffixIcon,
    this.prefixIcon,
    this.filled = false,
    this.fillColor,
    // this.onChanged,
    this.validator,
    this.maxLines = 1,
    this.cursorColor,
    this.hintStyle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: outlinePadding,
      child: TextFormField(
        cursorColor: cursorColor,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLines: maxLines,
        // onChanged: onChanged,
        validator: validator,
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: textColor,
            fontWeight: fontWeight,
            fontSize: fontSize,
          ),
        ),
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: textColor!.withOpacity(0.6),
                fontWeight: fontWeight,
                fontSize: fontSize,
              ),
            ),
            prefixIcon: prefixIcon,
            suffixIcon: dropdownButton != null ? dropdownButton : suffixIcon,
            contentPadding: contentPadding,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor,
                width: borderWidth,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: myColor.errortext)
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor,
                width: borderWidth,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            filled: filled,
            fillColor: fillColor),
      ),
    );
  }
}

class CuTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Color? textColor;
  final Color? cursorColor;
  final Color borderColor;
  final double borderWidth;
  final EdgeInsets contentPadding;
  final EdgeInsets outlinePadding;
  final FontWeight? fontWeight;
  final double fontSize;
  final FormFieldValidator<String>? validator;
  final int maxLines;
  final Color? hintStyle;
  final IconButton? suffixIcon;
  final bool readOnly;

  CuTextField({
    this.controller,
    this.hintText,
    this.keyboardType,
    this.textColor = Colors.black,
    this.borderColor = Colors.black,
    this.borderWidth = 1.0,
    this.cursorColor = Colors.black54,
    this.contentPadding = const EdgeInsets.only(left: 8,top: 15),
    this.outlinePadding = const EdgeInsets.only(left: 25, right: 30),
    this.fontWeight = FontWeight.normal,
    this.fontSize = 16.0,
    super.key,
    this.validator,
    this.maxLines = 1,
    this.hintStyle,
    this.suffixIcon,
    this.readOnly=false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: outlinePadding,
      child: TextFormField(
        readOnly: readOnly,
        keyboardType: keyboardType,
        controller: controller,
        maxLines: maxLines,
        cursorColor: cursorColor,
        style: TextStyle(
          color: textColor,
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
          suffixIcon: suffixIcon,
          contentPadding: contentPadding,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: borderWidth)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: borderWidth)),
        ),
      ),
    );
  }
}