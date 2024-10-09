import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hommie/agency/controller/agencyhomecontroller.dart';
import 'package:hommie/agency/view/agencyhome/agencyitemlist/agency_added_successfully.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/cu_inkwell_button.dart';
import 'package:hommie/widgets/custom_textfield.dart';
import 'package:hommie/widgets/dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AgencyAddHomeDetails extends StatefulWidget {
  final String typ;
  const AgencyAddHomeDetails({super.key, required this.typ});

  @override
  State<AgencyAddHomeDetails> createState() => _AgencyAddHomeDetailsState();
}

class _AgencyAddHomeDetailsState extends State<AgencyAddHomeDetails> {
  final formKey = GlobalKey<FormState>();

  List<String> furnishingList = ["Furnished", "Semi-Furnished", "Unfurnished"];
  String furnishingTyp = "";
  final Agencyhomecontroller _uploadController = Agencyhomecontroller();

  late final TextEditingController typController;
  final nameController = TextEditingController();
  final bedroomController = TextEditingController();
  final bathroomController = TextEditingController();
  final sqftController = TextEditingController();
  final totalFloorsController = TextEditingController();
  final carParkingController = TextEditingController();
  final fullAddressController = TextEditingController();
  final roadNameController = TextEditingController();
  final landmarkController = TextEditingController();
  final pincodeController = TextEditingController();
  final setPriceController = TextEditingController();
  final descriptionController = TextEditingController();

  bool isLoading = false; 

  @override
  void initState() {
    super.initState();
    typController = TextEditingController(text: widget.typ);
  }

  @override
  void dispose() {
    typController.dispose();
    super.dispose();
  }

  
  void _selectImages() async {
    await _uploadController.pickImages();
    setState(() {});
  }

  
  void _upload() async {
    if (!formKey.currentState!.validate()) {
      Fluttertoast.showToast(msg: "Please enter all required fields");
      return;
    }

    if (furnishingTyp.isEmpty) {
      Fluttertoast.showToast(msg: "Please select furnishing type");
      return;
    }


    setState(() {
      isLoading = true; 
    });

    try {
      await _uploadController.uploadData(
        nameController.text,
        descriptionController.text,
        bedroomController.text,
        bathroomController.text,
        sqftController.text,
        totalFloorsController.text,
        carParkingController.text,
        fullAddressController.text,
        roadNameController.text,
        landmarkController.text,
        pincodeController.text,
        setPriceController.text,
        furnishingTyp,
        widget.typ,
      );

      Fluttertoast.showToast(msg: "Upload successful");

      setState(() {
        isLoading = false; 
      });

      
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AgencyAddedSuccessfully()),
      );
    } catch (e) {
      Fluttertoast.showToast(msg: "Upload failed: $e");

      setState(() {
        isLoading = false; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColor.background,
      appBar: CustomAppBar(title: "Add Details"),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: GestureDetector(
                      onTap: _selectImages, 
                      child: Container(
                        height: 250.h,
                        width: double.infinity,
                        color: Colors.grey[350],
                        child: _uploadController.selectedImages.isNotEmpty
                            ? CarouselSlider.builder(
                                itemCount: _uploadController.selectedImages.length,
                                itemBuilder: (context, index, realIndex) {
                                  return SizedBox(
                                    child: Image.file(
                                      File(_uploadController.selectedImages[index].path),
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                                options: CarouselOptions(
                                  height: 250.h,
                                  enlargeCenterPage: true,
                                  enableInfiniteScroll: false,
                                ),
                              )
                            : Center(
                                child: Image.asset(
                                  "assets/images/add-image.png", 
                                  width: 170,
                                  color: Colors.black,
                                ),
                              ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: CuTextField(
                      controller: typController,
                      readOnly: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the type";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: CuTextField(
                      hintText: "Name",
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the name";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: CuTextField(
                      hintText: "Bedroom",
                      controller: bedroomController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter number of bedrooms";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: CuTextField(
                      hintText: "Bathroom",
                      controller: bathroomController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter number of bathrooms";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: CuDropdown1(
                      items: furnishingList,
                      validator: (value) {
                        if (furnishingTyp.isEmpty) {
                          return "Please select furnishing type";
                        }
                        return null;
                      },
                      onChanged: (String? value) {
                        setState(() {
                          furnishingTyp = value!;
                        });
                      },
                      hintText: "Furnishing",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: CuTextField(
                      hintText: "SqFt",
                      controller: sqftController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter square feet";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: CuTextField(
                      hintText: "Total Floors",
                      controller: totalFloorsController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter total floors";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: CuTextField(
                      hintText: "Car Parking",
                      controller: carParkingController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter number of car parking spaces";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: CuTextField(
                      hintText: "Full Address",
                      controller: fullAddressController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the full address";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: CuTextField(
                      hintText: "Road Name",
                      controller: roadNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the road name";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: CuTextField(
                      hintText: "Landmark",
                      controller: landmarkController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a landmark";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: CuTextField(
                      hintText: "City / Pincode",
                      controller: pincodeController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the city or pincode";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: CuTextField(
                      hintText: "Set Price",
                      controller: setPriceController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the price";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5, top: 30),
                      child: CustomTextField(
                        borderColor: Colors.black45,
                        controller: descriptionController,
                        hintText: "Description",
                        maxLines: 5,
                        textColor: myColor.textcolor,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a description";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  CustomInkwellButton(
                    height: 40.h,
                    width: 300.w,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        _upload();
                      }
                    },
                    text: "Next",
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
          if (isLoading) 
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
