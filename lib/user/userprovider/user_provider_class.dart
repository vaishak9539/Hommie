// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

//* USER OBSCURETEXT PROVIDER

class ObscuretextProvider with ChangeNotifier {
  bool _secureText = false;

  bool get secureText => _secureText;

  void checkvisibility() {
    _secureText = !_secureText;
    notifyListeners();
    print("ObscureText is Working: $secureText");
  }
}

//* USER CHECKEDBOX PROVIDER

class RegistrationProvider with ChangeNotifier {
  bool _ischecked = false;

  bool get ischecked => _ischecked;

  void toggleCheckbox(value) {
    _ischecked = value;
    notifyListeners();
    print("Checkbox is working: $ischecked");
  }
}

//* USER STATE SELECTION PROVIDER

class UserStateDropdownProvider with ChangeNotifier {
  String _userstateValue = "";

  String get userstateValue => _userstateValue;

  final List<String> userstates = [
    "Kerala",
  ];

  void userSelectedState(newValue) {
    _userstateValue = newValue;
    notifyListeners();
    print("user State selected : $userstateValue");
  }
}

class UserCityDropdownProvider with ChangeNotifier {
  String _userCityValue = "Kozhikode";

  String get userCityValue => _userCityValue;

  final List<String> usercity = [
    "Kozhikode",
    "Wayanad",
    "Palakkad",
    "Malappuram",
    "Kannur",
  ];

  void userSelectedCity(value) {
    _userCityValue = value;
    notifyListeners();
    print("User City Selected : $userCityValue");
  }
}

//* USER HOME SAVED PROVIDER

class UserHomeSavedProvider with ChangeNotifier {
  final List<bool> _userhomeSavedList = List.generate(8, (_) => false);

  bool isHomeSaved(int index) => _userhomeSavedList[index];

  void usercheckSaved(int index) {
    _userhomeSavedList[index] = !_userhomeSavedList[index];
    notifyListeners();
    print("Home Saved :${isHomeSaved(index)}");
  }
}

//* USER NAVIGATION PROVIDER

class UserNavigationProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void userNavigationCurrentIndex(index) {
    _currentIndex = index;
    notifyListeners();
  }
}

//* USER VILLA SAVED PROVIDER

class UserVillaSavedProvider with ChangeNotifier {
  final List<bool> _userVillaSavedList = List.generate(
    8,
    (index) => false,
  );

  bool isvillaSaved(int index) => _userVillaSavedList[index];

  void userVillaSaved(int index) {
    _userVillaSavedList[index] = !_userVillaSavedList[index];
    notifyListeners();
    print("Villa Saved :${isvillaSaved(index)}");
  }
}

class SmoothIndicatorProvider with ChangeNotifier {
  int _activeIndex = 0;

  int get activeIndex => _activeIndex;

  void currentActiveIndex(index) {
    _activeIndex = index;
    notifyListeners();
    print("Slider Indicator : $activeIndex");
  }
}
