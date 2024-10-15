import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/cu_inkwell_button.dart';
import 'package:hommie/widgets/custom_textfield.dart';
import 'package:hommie/widgets/dropdown.dart';
import 'package:image_picker/image_picker.dart';

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

  final typController = TextEditingController();
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

  List<File> _images = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    typController.text = widget.typ;
  }

  Future<void> _pickImage() async {
    final pickedFiles = await ImagePicker().pickMultiImage();
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      setState(() {
        _images.addAll(
            pickedFiles.map((pickedFile) => File(pickedFile.path)).toList());
      });
    }
  }

  Future<List<String>> _uploadImages() async {
    List<String> imageUrls = [];
    for (var image in _images) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref =
          FirebaseStorage.instance.ref().child('Property_images/$fileName');
      await ref.putFile(image);
      String downloadUrl = await ref.getDownloadURL();
      imageUrls.add(downloadUrl);
    }
    return imageUrls;
  }

  Future<void> _saveItem() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          throw 'User not authenticated';
        }
        String userId = user.uid;

        List<String> imageUrls = await _uploadImages();

        Property newProperty = Property(
          typ: widget.typ,
          name: nameController.text,
          bedroom: bedroomController.text,
          bathroom: bathroomController.text,
          furnishing: furnishingTyp,
          sqft: sqftController.text,
          totalFloors: totalFloorsController.text,
          imageUrls: imageUrls,
          carParking: carParkingController.text,
          fullAddress: fullAddressController.text,
          roadName: roadNameController.text,
          landmark: landmarkController.text,
          pincode: pincodeController.text,
          setPrice: setPriceController.text,
          description: descriptionController.text,
          timestamp: DateTime.now(),
        );

        DocumentReference docRef = await FirebaseFirestore.instance
            .collection('items')
            .doc(userId)
            .collection('item_List')
            .add(newProperty.toMap());

        newProperty.id = docRef.id;
        await docRef.update({'id': docRef.id});

        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Property added successfully!')),
        );

        Navigator.pop(context);
      } catch (e) {
        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding Property: $e')),
        );
      }
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
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 250.h,
                        width: double.infinity,
                        color: Colors.grey[350],
                        child: _images.isNotEmpty
                            ? CarouselSlider.builder(
                                itemCount: _images.length,
                                itemBuilder: (context, index, realIndex) {
                                  return SizedBox(
                                    child: Image.file(
                                      _images[index],
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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: CuTextField(
                      hintText: "name",
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
                      padding:
                          const EdgeInsets.only(left: 5, right: 5, top: 30),
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
                        _saveItem();
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

class Property {
  String id;
  final List<String> imageUrls;
  final String typ;
  final String name;
  final String bedroom;
  final String bathroom;
  final String furnishing;
  final String sqft;
  final String totalFloors;
  final String? carParking;
  final String? fullAddress;
  final String? roadName;
  final String? landmark;
  final String? pincode;
  final String? setPrice;
  final String? description;
  final DateTime timestamp;

  Property({
    this.id = '',
    required this.typ,
    required this.name,
    required this.bedroom,
    required this.bathroom,
    required this.furnishing,
    required this.sqft,
    required this.totalFloors,
    required this.imageUrls,
    required this.carParking,
    required this.fullAddress,
    required this.roadName,
    required this.landmark,
    required this.pincode,
    required this.setPrice,
    required this.description,
    required this.timestamp,
  });

  factory Property.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Property(
      id: doc.id,
      typ: data['typ'] ?? '',
      name: data['name'] ?? '',
      bedroom: data['bedroom'] ?? '',
      bathroom: data['bathroom'] ?? '',
      furnishing: data['furnishing'] ?? '',
      sqft: data['sqft'] ?? '',
      totalFloors: data['totalFloors'] ?? '',
      imageUrls: List<String>.from(data['imageUrls'] ?? []),
      carParking: data['carParking'],
      fullAddress: data['fullAddress'],
      roadName: data['roadName'],
      landmark: data['landmark'],
      pincode: data['pincode'],
      setPrice: data['setPrice'],
      description: data['description'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'typ': typ,
      'name': name,
      'bedroom': bedroom,
      'bathroom': bathroom,
      'furnishing': furnishing,
      'sqft': sqft,
      'totalFloors': totalFloors,
      'imageUrls': imageUrls,
      'carParking': carParking,
      'fullAddress': fullAddress,
      'roadName': roadName,
      'landmark': landmark,
      'pincode': pincode,
      'setPrice': setPrice,
      'description': description,
      'timestamp': FieldValue.serverTimestamp(),
    };
  }
}
