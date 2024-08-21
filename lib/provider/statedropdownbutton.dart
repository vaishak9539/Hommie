import 'package:flutter/material.dart';

class StateDropdownButton with ChangeNotifier {
  String _dropdownValue = "Kerala";

  String get dropdownValue => _dropdownValue;

  final List<String> category = [
    "Kerala"
  ];

  void setSelectedValue(String newValue) {
    _dropdownValue = newValue;
    notifyListeners(); 
    print("DropDown Button Working : $dropdownValue");
  }
}
