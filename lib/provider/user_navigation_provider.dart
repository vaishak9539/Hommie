import 'package:flutter/material.dart';

class UserNavigationProvider with ChangeNotifier{
   int _currentIndex=0;

    int get currentIndex=>_currentIndex;

  void userNavigationCurrentIndex(index){
    _currentIndex=index;
    notifyListeners();
  }
}