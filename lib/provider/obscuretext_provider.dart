import 'package:flutter/material.dart';

class ObscuretextProvider with ChangeNotifier {
  bool _secureText = false;

  bool get secureText => _secureText;

  void checkvisibility() {
    _secureText =! _secureText;
    notifyListeners();
    print("ObscureText is Working: $secureText");
  }
}
