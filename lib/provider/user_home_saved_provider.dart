import 'package:flutter/material.dart';

class UserHomeSavedProvider with ChangeNotifier {
 final List<bool> _userhomeSavedList = List.generate(8, (_) => false);

    bool   isHomeSaved(int index) => _userhomeSavedList[index];

  void usercheckSaved(int index) {
    _userhomeSavedList[index] = !_userhomeSavedList[index];
    notifyListeners();
    print("Home Saved :${isHomeSaved(index)}");
  }
}
