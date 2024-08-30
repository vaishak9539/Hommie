// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class AgencyObscuretextOProvider with ChangeNotifier{
  bool _agencysecureText = false;

  bool get agencySecureText => _agencysecureText;

  agencyCheckVisibility(){
    _agencysecureText =! _agencysecureText;
    notifyListeners();
    print("Agency ObscureText is $agencySecureText");
  }
}


class AgencyCheckboxProvider with ChangeNotifier{
    bool _ischecked=false;

    bool get checkvalue => _ischecked;

   void checkbox(value){
      _ischecked = value;
      notifyListeners();
      print("Agency Checkbox is $checkvalue");
    }
}

class AgencyNavigationProvider with ChangeNotifier{

   int _currentIndex=0;

    int get currentIndex=>_currentIndex;

  void agencyNavigationCurrentIndex(index){
    _currentIndex=index;
    notifyListeners();
    print("Agency Bottom Navigation Index is $currentIndex");
  }
}