import 'package:flutter/material.dart';
import 'package:hommie/model/agency_reg_model.dart';

class AgencyRegController{
  final formkey = GlobalKey<FormState>();
  AgencyRegModel agencyReg = AgencyRegModel();

  Future submitAgencyRegForm()async{
    if (formkey.currentState!.validate()) {
      
    }
  } 
}