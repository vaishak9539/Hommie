// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

//* AGENCY OBSCURETEXT PROVIDER
class AgencyObscuretextProvider with ChangeNotifier {
  bool _agencysecureText = false;

  bool get agencySecureText => _agencysecureText;

  agencyCheckVisibility() {
    _agencysecureText = !_agencysecureText;
    notifyListeners();
    print("Agency ObscureText is $agencySecureText");
  }
}

//* AGENCY CHECKBOX PROVIDER
class AgencyCheckboxProvider with ChangeNotifier {
  bool _ischecked = false;

  bool get checkvalue => _ischecked;

  void checkbox(value) {
    _ischecked = value;
    notifyListeners();
    print("Agency Checkbox is $checkvalue");
  }
}

//* AGENCY NAVIGATION PROVIDER
class AgencyNavigationProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void agencyNavigationCurrentIndex(index) {
    _currentIndex = index;
    notifyListeners();
    print("Agency Bottom Navigation Index is $currentIndex");
  }
}

//* AGENCY SELECT STATE PROVIDER
class AgencyStateProvider with ChangeNotifier {
  String _agencyStateValue = "";

  String get agencyStateValue => _agencyStateValue;

  final List<String> agencystate = ["Kerala"];

  void agencySelectedState(value) {
    _agencyStateValue = value;
    notifyListeners();
    print("Agency State is : $agencyStateValue");
  }
}

//* AGENCY SELECT CITY PROVIDER
class AgencyCityProvider with ChangeNotifier {
  String _agencyCityValue = "";

  String get agencyCityValue => _agencyCityValue;

  final List<String> agencyCity = [
    "Kozhikode",
    "Wayanad",
    "Palakkad",
    "Malappuram",
    "Kannur",
  ];

  void agencySelectedCity(value) {
    _agencyCityValue = value;
    notifyListeners();
    print("Agency City is : $agencyCityValue");
  }
}

//* AGENCY PROPERTY TYP PROVIDER
class AgencyPropertyTypProvider with ChangeNotifier {
  String _propertyTyp = "";

  String get propertyTyp => _propertyTyp;

  List<String> propertyList = [
    "House",
    "Villa",
    "Apartment",
  ];

  void selectPropertyList(value) {
    _propertyTyp = value;
    notifyListeners();
    print("Select Property typ is : $propertyTyp");
  }
}

//* AGENCY FURNISHING PROVIDER

 class AgencyFurnishingProvider with ChangeNotifier{

   String _furnishingTyp= "";
  
  String get furnishingTyp => _furnishingTyp;

   List<String> furnishingList = [
    "Furnished",
    "Semi-Furnished",
    "unfurnished"
   ];

   void selectFurnishingTyp(value){
    _furnishingTyp = value;
    notifyListeners();
    print("Select Furnishing Typ is : $_furnishingTyp");
   }
 } 

