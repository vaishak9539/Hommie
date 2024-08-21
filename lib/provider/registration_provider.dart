import 'package:flutter/material.dart';

class RegistrationProvider with ChangeNotifier{
  bool _ischecked = false;

  bool get ischecked => _ischecked;

  void toggleCheckbox(value){
    _ischecked=value;
    notifyListeners();
    print("Checkbox is working: $ischecked");
  }
}