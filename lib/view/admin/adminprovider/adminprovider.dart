// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class AdminObscureTextProvider with ChangeNotifier{
  bool _adminObscureText = false;

  bool get adminObscureText => _adminObscureText;

  checkvisibility(){
    _adminObscureText =! _adminObscureText;
    notifyListeners();
    print("adminObscureText : $adminObscureText");
  }
}

class AdminNavigationProvider with ChangeNotifier{
  int _navigationIndex = 0;

  int get navigationIndex => _navigationIndex;

  void adminNavigationCurrentIndex(int index){
    _navigationIndex = index;
    notifyListeners();
    print("Admin Navigation Index : $navigationIndex");
  }
}