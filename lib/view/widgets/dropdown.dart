import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hommie/model/utils/style/color.dart';

class CuDropdown extends StatelessWidget {
  final List<String> items;
  final String? selectedItem;
  final ValueChanged<String?> onChanged;
  final String hintText;
  final Color backgroundColor;
  final String? Function(String?)? validator;

  const CuDropdown(
      {super.key,
      required this.items,
      this.selectedItem,
      required this.onChanged,
      required this.hintText,
      required this.backgroundColor,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: DropdownSearch<String>(
        popupProps: PopupProps.menu(
            showSelectedItems: true,
            fit: FlexFit.loose,
            menuProps: MenuProps(backgroundColor: backgroundColor),
            constraints: BoxConstraints(maxHeight: 200.h, maxWidth: 200.w)),
        items: items,
        dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle: GoogleFonts.poppins(color: myColor.background),
            dropdownSearchDecoration: InputDecoration(
                contentPadding: EdgeInsets.all(8),
                suffixIconColor: myColor.background.withOpacity(0.8),
                fillColor: Colors.transparent,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: myColor.background, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: myColor.background, width: 2),
                ),
                hintText: hintText,
                hintStyle:
                    TextStyle(color: myColor.background.withOpacity(0.6)))),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}

class CuDropdown1 extends StatelessWidget {
  final List<String> items;
  final String? selectedItem;
  final ValueChanged<String?> onChanged;
  final String hintText;
  final String? Function(String?)? validator;
  const CuDropdown1(
      {super.key,
      required this.items,
      this.selectedItem,
      required this.onChanged,
      required this.hintText,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 30),
      child: SizedBox(
        // width: 150.h,
        child: DropdownSearch<String>(
          popupProps: PopupProps.menu(
              showSelectedItems: true,
              fit: FlexFit.loose,
              menuProps: MenuProps(backgroundColor: myColor.background),
              constraints: BoxConstraints(maxHeight: 200.h, maxWidth: 200.w)),
          items: items,
          dropdownDecoratorProps: DropDownDecoratorProps(
              baseStyle: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.normal),
              dropdownSearchDecoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 8, top: 18),
                  suffixIconColor: myColor.textcolor,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black)),
                  hintText: hintText,
                  hintStyle: TextStyle(color: myColor.textcolor.withOpacity(0.5)))),
          onChanged: onChanged,
          validator: validator,
        ),
      ),
    );
  }
}
