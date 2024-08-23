import 'package:flutter/material.dart';

class UserVillaSavedProvider with ChangeNotifier{

final List <bool> _userVillaSavedList = List.generate(8, (index) => false,);

bool isvillaSaved(int index)=> _userVillaSavedList [index];

void userVillaSaved(int index){
  _userVillaSavedList[index] =! _userVillaSavedList[index];
  notifyListeners();
  print("Villa Saved :${isvillaSaved(index)}");
}
}