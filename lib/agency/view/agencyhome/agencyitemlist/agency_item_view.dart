import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/agency/view/agencyhome/agencyitemlist/agency_add_item.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/user/view/home/user_category/user_agency_profile_view.dart';
import 'package:hommie/widgets/custom_text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AgencyItemView extends StatefulWidget {
  final  documentId;
  final itemData; 

  const AgencyItemView({super.key, required this.documentId, required this. itemData});

  @override
  State<AgencyItemView> createState() => _AgencyItemViewState();
}

class _AgencyItemViewState extends State<AgencyItemView> {
  int activeIndex = 0;
  

  @override
  Widget build(BuildContext context) {
    var name = widget.itemData['Name'] ?? 'No Name';
    var description = widget.itemData['Description'] ?? 'No description available';
    var roadName = widget.itemData['RoadName'];
    var price = widget.itemData['SetPrize'] ?? 'Price not available';
    var imageUrls = widget.itemData['imageUrls'] ?? [backgroundimage[1]];
    return Scaffold(
      body: Stack(
        children: [
          
           CarouselSlider.builder(
            itemCount: imageUrls.length,
            itemBuilder: (context, index, realIndex) {
              String imageUrl = imageUrls[index];
              return SizedBox(
                width: double.infinity,
                child: imageUrl.startsWith('http')
                    ? Image.network(imageUrl, height: 390.h, fit: BoxFit.cover)
                    : Image.asset(imageUrl, height: 390.h, fit: BoxFit.cover),
              );
            },
            options: CarouselOptions(
              height: 390.h,
              onPageChanged: (index, reason) {
                setState(() {
                  activeIndex = index;
                });
              },
            ),
          ),
          
          Positioned(
            top: 30,
            left: 10,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: myColor.background,
                size: 30,
              ),
            ),
          ),
          
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 320.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: myColor.background,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: AnimatedSmoothIndicator(
                        activeIndex: activeIndex,
                        count: imageUrls.length,
                        effect: JumpingDotEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          activeDotColor: Colors.red,
                          dotColor: Colors.grey,
                          spacing: 8,
                        ),
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "₹ $price",
                            size: 18,
                            weight: FontWeight.w500,
                            color: myColor.textcolor,
                          ),
                         
                        ],
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Row(
                        children: [
                          Image.asset(
                            icons[4],
                            width: 15,
                          ),
                          SizedBox(width: 8),
                          SizedBox(
                            width: 180,
                            child: Expanded(
                              child: Text(
                                roadName,
                                style: TextStyle(fontSize: 13, height: 1.4),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    Divider(),
                    
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Description",
                            size: 15,
                            weight: FontWeight.w500,
                            color: myColor.textcolor,
                          ),
                          SizedBox(height: 10),
                         
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                     Padding(
                       padding: const EdgeInsets.only(left: 20,right: 20),
                       child: Row(
                         children: [
                           Expanded(
                             child: CustomText(
                                  text: description,
                                  size: 13,
                                  weight: FontWeight.normal,
                                  letterSpacing: 1,
                                  color: myColor.textcolor,
                                ),
                           ),
                         ],
                       ),
                     ),
                     SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Details",
                            size: 15,
                            weight: FontWeight.w500,
                            color: myColor.textcolor,
                          ),
                          
                        Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 21),
                              child: CustomText(
                                  text: "Type",
                                  size: 13,
                                  weight: FontWeight.w400,
                                  color: myColor.textcolor),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: CustomText(
                                  text: "Bedroom",
                                  size: 13,
                                  weight: FontWeight.w400,
                                  color: myColor.textcolor),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: CustomText(
                                  text: "Bathrooms",
                                  size: 13,
                                  weight: FontWeight.w400,
                                  color: myColor.textcolor),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: CustomText(
                                  text: "Furnishing",
                                  size: 13,
                                  weight: FontWeight.w400,
                                  color: myColor.textcolor),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: CustomText(
                                  text: "Sqft",
                                  size: 13,
                                  weight: FontWeight.w400,
                                  color: myColor.textcolor),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: CustomText(
                                  text: "Total Floors",
                                  size: 13,
                                  weight: FontWeight.w400,
                                  color: myColor.textcolor),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              child: CustomText(
                                  text: "Car Parking",
                                  size: 13,
                                  weight: FontWeight.w400,
                                  color: myColor.textcolor),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          children: [
                            CustomText(
                                text: ":",
                                size: 15,
                                weight: FontWeight.w500,
                                color: myColor.textcolor),
                            Padding(
                              padding: const EdgeInsets.only(top: 18),
                              child: CustomText(
                                  text: ":",
                                  size: 15,
                                  weight: FontWeight.w500,
                                  color: myColor.textcolor),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 18),
                              child: CustomText(
                                  text: ":",
                                  size: 15,
                                  weight: FontWeight.w500,
                                  color: myColor.textcolor),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 18),
                              child: CustomText(
                                  text: ":",
                                  size: 15,
                                  weight: FontWeight.w500,
                                  color: myColor.textcolor),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 18),
                              child: CustomText(
                                  text: ":",
                                  size: 15,
                                  weight: FontWeight.w500,
                                  color: myColor.textcolor),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 18),
                              child: CustomText(
                                  text: ":",
                                  size: 15,
                                  weight: FontWeight.w500,
                                  color: myColor.textcolor),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 18),
                              child: CustomText(
                                  text: ":",
                                  size: 15,
                                  weight: FontWeight.w500,
                                  color: myColor.textcolor),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 21),
                              child: CustomText(
                                  text: widget.itemData["Typ"],
                                  size: 13,
                                  weight: FontWeight.w400,
                                  color: myColor.textcolor),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: CustomText(
                                  text: "4",
                                  size: 13,
                                  weight: FontWeight.w400,
                                  color: myColor.textcolor),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: CustomText(
                                  text: "4",
                                  size: 13,
                                  weight: FontWeight.w400,
                                  color: myColor.textcolor),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: CustomText(
                                  text: "Furnished",
                                  size: 13,
                                  weight: FontWeight.w400,
                                  color: myColor.textcolor),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: CustomText(
                                  text: "2000",
                                  size: 13,
                                  weight: FontWeight.w400,
                                  color: myColor.textcolor),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: CustomText(
                                  text: "2",
                                  size: 13,
                                  weight: FontWeight.w400,
                                  color: myColor.textcolor),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 19),
                              child: CustomText(
                                  text: "3",
                                  size: 13,
                                  weight: FontWeight.w400,
                                  color: myColor.textcolor),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                        ],
                      ),
                    ),
                    // SizedBox(height: 50.h),
                    
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      
    );
  }

  
}
