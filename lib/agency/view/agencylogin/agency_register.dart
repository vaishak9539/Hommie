import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/agency/controller/agencycopntroller.dart';
import 'package:hommie/agency/model/agencymodel.dart';
import 'package:hommie/agency/view/agencyhome/agency_bottomnav.dart';
import 'package:hommie/agency/view/agencyhome/agencyaccount/agency_terms_conditions.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/widgets/cu_inkwell_button.dart';
import 'package:hommie/widgets/custom_text.dart';
import 'package:hommie/widgets/custom_textfield.dart';
import 'package:hommie/widgets/dropdown.dart';
import 'package:provider/provider.dart';

class AgencyRegister extends StatefulWidget {
  const AgencyRegister({super.key});

  @override
  State<AgencyRegister> createState() => _AgencyRegisterState();
}

class _AgencyRegisterState extends State<AgencyRegister> {
  final formkey = GlobalKey<FormState>();

  final agencynameController = TextEditingController();

  final agencycontactNoController = TextEditingController();

  final agencyemailController = TextEditingController();

  final agencypasswordController = TextEditingController();

  final agencylicenceController = TextEditingController();

  bool ischecked = false;

  final List<String> agencystate = ["Kerala"];
  String agencyStateValue = "";

  final List<String> agencyCity = [
    "Kozhikode",
    "Wayanad",
    "Palakkad",
    "Malappuram",
    "Kannur",
  ];
  String agencyCityValue = "";

 


  @override
  Widget build(BuildContext context) {
    final agencyController = Provider.of<AgencyController>(context);

    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6),
                BlendMode.darken,
              ),
              image: AssetImage('assets/images/unsplash_yHg6p8vW_Is.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  SizedBox(height: 50.h),
                  CustomText(
                    text: "Register",
                    size: 30,
                    weight: FontWeight.w500,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                  CustomText(
                    text: "Create your account",
                    size: 12,
                    weight: FontWeight.w500,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(18),
                  ),
                  CustomTextField(
                    hintText: "Name",
                    cursorColor: myColor.background,
                    controller: agencynameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(18),
                  ),
                  CustomTextField(
                    cursorColor: myColor.background,
                    hintText: "Contact No",
                    controller: agencycontactNoController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your number";
                      }
                      if (value.length < 10) {
                        return "Contact number must be at least 10 digits";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(18),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CuDropdown(
                        items: agencystate,
                        onChanged: (String? value) {
                          setState(() {
                            agencyStateValue = value!;
                                print("Agency State is : $agencyStateValue");

                          });
                        },
                        hintText: "State",
                        backgroundColor: myColor.background,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please select a state";
                          }
                          return null;
                        },
                      ),
                      CuDropdown(
                        items: agencyCity,
                        onChanged: (String? value) {
                          setState(() {
                            agencyCityValue = value!;
                                print("Agency City is : $agencyCityValue");

                          });
                        },
                        hintText: "City",
                        backgroundColor: myColor.background,
                        
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please select a state";
                          }
                          return null;
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(18),
                  ),
                  CustomTextField(
                    hintText: "Licence or aadhaar No",
                    cursorColor: myColor.background,
                    controller: agencylicenceController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(18),
                  ),
                  CustomTextField(
                    hintText: "Email",
                    cursorColor: myColor.background,
                    controller: agencyemailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return "Please enter a valid email";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(18),
                  ),
                  CustomTextField(
                    hintText: "Password",
                    cursorColor: myColor.background,
                    controller: agencypasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your Password";
                      }
                      if (!RegExp((r'[A-Z]')).hasMatch(value)) {
                        return 'Uppercase letter is missing';
                      }
                      if (!RegExp((r'[a-z]')).hasMatch(value)) {
                        return 'Lowercase letter is missing';
                      }
                      if (!RegExp((r'[0-9]')).hasMatch(value)) {
                        return 'Digit is missing';
                      }
                      if (value.length < 8) {
                        return "Password must have at least 8 characters";
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Checkbox(
                          value: ischecked,
                          onChanged: (bool? value) {
                            setState(() {
                              ischecked = value!;
                                  print("Agency Checkbox value is : $ischecked");

                            });
                          },
                          activeColor: Color(0xff3FA2F6),
                        ),
                      ),
                      CustomText(
                          text: "I Agree with ",
                          size: 11,
                          weight: FontWeight.w400,
                          color: Colors.white),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AgencyTermsConditions()));
                        },
                        child: CustomText(
                            text: "Terms & conditions",
                            size: 11,
                            weight: FontWeight.w400,
                            color: Color(0xff3FA2F6)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(13),
                  ),
                  CustomInkwellButton(
                      onTap: () {
                        if (formkey.currentState!.validate()) {
                          if (ischecked == true) {


                            final agency = AgencyRegModel(
                              name: agencynameController.text,
                              contactNo: agencycontactNoController.text,
                              state: agencyStateValue,
                              city: agencyCityValue,
                              licence: agencylicenceController.text,
                              email: agencyemailController.text,
                              password: agencypasswordController.text,
                              terms: ischecked,
                              createdAt: DateTime.now(),
                              
                            );
                            agencyController.registerAgency(
                              agency: agency,
                              onSuccess: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AgencyBottomNav(),
                                  ),
                                );
                              },
                              onError: (e) {
                                print(e);
                              },
                            );
                          }
                        }
                      
                      },
                      text: "Register"),
                  SizedBox(
                    height: ScreenUtil().setHeight(15),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                          text: "Already have an account ?",
                          size: 12,
                          weight: FontWeight.w400,
                          color: Colors.white),
                      InkWell(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => UserLogin(),
                            //     ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: CustomText(
                                text: "Login",
                                size: 12,
                                weight: FontWeight.w400,
                                color: Color(0xff3FA2F6)),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(15),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: ScreenUtil().setHeight(2),
                        width: ScreenUtil().setWidth(100),
                        color: Colors.white,
                      ),
                      CustomText(
                          text: " Or Sign with",
                          size: 12,
                          weight: FontWeight.w500,
                          color: Colors.white),
                      Container(
                        height: ScreenUtil().setHeight(2),
                        width: ScreenUtil().setWidth(100),
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: ScreenUtil().setHeight(42),
                          width: ScreenUtil().setWidth(250),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(31),
                              color: Color(0xffFFFFFF)),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 23),
                                child: Image.asset(
                                  "assets/images/google.png",
                                  height: 28,
                                  width: 28,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: CustomText(
                                    text: "continue with google",
                                    size: 14,
                                    weight: FontWeight.w400,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
