import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/color.dart';

class CuDropdown extends StatelessWidget {
  final List<String> items;
  final String? selectedItem;
  final ValueChanged<String?> onChanged;
  final String hintText;
  final Color backgroundColor;
  CuDropdown({
    super.key,
    required this.items,
    this.selectedItem,
    required this.onChanged,
    required this.hintText,
    required this.backgroundColor,
  });

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
                    TextStyle(color: myColor.background.withOpacity(0.6)
                    )
                    )
                    ),
        
        onChanged: (newValue) {
          onChanged;
        },
        
      ),
    );
  }
}
