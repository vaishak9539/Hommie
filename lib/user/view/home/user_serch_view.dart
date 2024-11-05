// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:hommie/model/utils/style/color.dart';
// import 'package:hommie/model/utils/style/img_path.dart';
// import 'package:hommie/user/view/home/user_category/user_agency_profile_view.dart';
// import 'package:hommie/user/view/home/user_category/user_view_home.dart';
// import 'package:hommie/widgets/cu_inkwell_button.dart';
// import 'package:hommie/widgets/custom_text.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:url_launcher/url_launcher.dart';

// class UserSerchView extends StatefulWidget {
//   final Property? property;
//   final String? agid;
//   const UserSerchView({super.key, this.property, this.agid});

//   @override
//   State<UserSerchView> createState() => _UserSerchViewState();
// }

// class _UserSerchViewState extends State<UserSerchView> {
//   var activeIndex = 0;
//   var agencyContactNumber;
//   var errorMessage;
//   Future<void> fetchAgencyContactNumber(agencyId) async {
//     try {
//       DocumentSnapshot agencyDoc = await FirebaseFirestore.instance
//           .collection(
//               'Agencies') // Adjust this to your actual agency collection
//           .doc(widget.agid)
//           .get();

//       if (agencyDoc.exists) {
//         setState(() {
//           agencyContactNumber = agencyDoc.get('ContactNo');
//         });
//       } else {
//         setState(() {
//           errorMessage = 'Agency not found';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = 'Error fetching agency contact: $e';
//       });
//     }
//   }

//   Future<void> _makePhoneCall(String phoneNumber) async {
//     final Uri launchUri = Uri(
//       scheme: 'tel',
//       path: phoneNumber,
//     );
//     await launchUrl(launchUri);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           if (widget.property!.imageUrls.isNotEmpty)
//             CarouselSlider.builder(
//               itemCount: widget.property!.imageUrls.length,
//               itemBuilder: (context, index, realIndex) {
//                 return SizedBox(
//                   width: double.infinity,
//                   child: Image.network(
//                     widget.property!.imageUrls[index],
//                     height: 390.h,
//                     fit: BoxFit.cover,
//                   ),
//                 );
//               },
//               options: CarouselOptions(
//                 height: 390.h,
//                 onPageChanged: (index, reason) {
//                   setState(() {
//                     activeIndex = index;
//                   });
//                 },
//               ),
//             )
//           else
//             Center(
//               child: Text("No images available"),
//             ),
//           Padding(
//             padding: const EdgeInsets.only(top: 30, left: 10),
//             child: IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: Icon(
//                 Icons.arrow_back,
//                 color: myColor.background,
//                 size: 30,
//               ),
//             ),
//           ),
//           if (widget.property!.imageUrls.isNotEmpty)
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 10),
//                 child: AnimatedSmoothIndicator(
//                   activeIndex: activeIndex,
//                   count: widget.property!.imageUrls.length,
//                   effect: JumpingDotEffect(
//                     dotHeight: 8,
//                     dotWidth: 8,
//                     activeDotColor: Colors.red,
//                     dotColor: Colors.grey,
//                     spacing: 8,
//                   ),
//                 ),
//               ),
//             ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               height: 320.h,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: myColor.background,
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
//               ),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 10),
//                       child: AnimatedSmoothIndicator(
//                         activeIndex: activeIndex,
//                         count: widget.property!.imageUrls.length,
//                         effect: JumpingDotEffect(
//                           dotHeight: 8,
//                           dotWidth: 8,
//                           activeDotColor: Colors.red,
//                           dotColor: Colors.grey,
//                           spacing: 8,
//                         ),
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(left: 23, top: 5),
//                               child: CustomText(
//                                   text:
//                                       "₹${widget.property!.setPrice ?? 'N/A'}",
//                                   size: 18,
//                                   weight: FontWeight.w500,
//                                   color: myColor.textcolor),
//                             ),
//                           ],
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(right: 25),
//                           child: InkWell(
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                           UserAgencyProfileView(
//                                         agencyid: widget.agid,
//                                       ),
//                                     ));
//                               },
//                               child: CircleAvatar(
//                                 backgroundImage: AssetImage(icons[5]),
//                               )),
//                         )
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 15),
//                           child: Column(
//                             children: [
//                               Image.asset(
//                                 icons[4],
//                                 width: 15,
//                               )
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 8, top: 5),
//                           child: Column(
//                             children: [
//                               CustomText(
//                                   text: widget.property!.fullAddress ?? 'N/A',
//                                   size: 12,
//                                   weight: FontWeight.w300,
//                                   color: myColor.textcolor)
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     Divider(),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 20, top: 20),
//                           child: CustomText(
//                               text: "Description",
//                               size: 15,
//                               weight: FontWeight.w500,
//                               color: myColor.textcolor),
//                         )
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Expanded(
//                             child: Padding(
//                           padding: const EdgeInsets.only(
//                               left: 20, top: 10, right: 15),
//                           child: CustomText(
//                               text: widget.property!.description ?? 'N/A',
//                               size: 11,
//                               weight: FontWeight.normal,
//                               letterSpacing: 1,
//                               color: myColor.textcolor),
//                         ))
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(top: 30, left: 20),
//                           child: CustomText(
//                               text: "Details",
//                               size: 15,
//                               weight: FontWeight.w500,
//                               color: myColor.textcolor),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 30),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 21),
//                                 child: CustomText(
//                                     text: "Type",
//                                     size: 13,
//                                     weight: FontWeight.w400,
//                                     color: myColor.textcolor),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 20),
//                                 child: CustomText(
//                                     text: "Bedroom",
//                                     size: 13,
//                                     weight: FontWeight.w400,
//                                     color: myColor.textcolor),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 20),
//                                 child: CustomText(
//                                     text: "Bathrooms",
//                                     size: 13,
//                                     weight: FontWeight.w400,
//                                     color: myColor.textcolor),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 20),
//                                 child: CustomText(
//                                     text: "Furnishing",
//                                     size: 13,
//                                     weight: FontWeight.w400,
//                                     color: myColor.textcolor),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 20),
//                                 child: CustomText(
//                                     text: "Sqft",
//                                     size: 13,
//                                     weight: FontWeight.w400,
//                                     color: myColor.textcolor),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 20),
//                                 child: CustomText(
//                                     text: "Total Floors",
//                                     size: 13,
//                                     weight: FontWeight.w400,
//                                     color: myColor.textcolor),
//                               ),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.only(top: 20, bottom: 20),
//                                 child: CustomText(
//                                     text: "Car Parking",
//                                     size: 13,
//                                     weight: FontWeight.w400,
//                                     color: myColor.textcolor),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 20),
//                           child: Column(
//                             children: [
//                               CustomText(
//                                   text: ":",
//                                   size: 15,
//                                   weight: FontWeight.w500,
//                                   color: myColor.textcolor),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 18),
//                                 child: CustomText(
//                                     text: ":",
//                                     size: 15,
//                                     weight: FontWeight.w500,
//                                     color: myColor.textcolor),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 18),
//                                 child: CustomText(
//                                     text: ":",
//                                     size: 15,
//                                     weight: FontWeight.w500,
//                                     color: myColor.textcolor),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 18),
//                                 child: CustomText(
//                                     text: ":",
//                                     size: 15,
//                                     weight: FontWeight.w500,
//                                     color: myColor.textcolor),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 18),
//                                 child: CustomText(
//                                     text: ":",
//                                     size: 15,
//                                     weight: FontWeight.w500,
//                                     color: myColor.textcolor),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 18),
//                                 child: CustomText(
//                                     text: ":",
//                                     size: 15,
//                                     weight: FontWeight.w500,
//                                     color: myColor.textcolor),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 18),
//                                 child: CustomText(
//                                     text: ":",
//                                     size: 15,
//                                     weight: FontWeight.w500,
//                                     color: myColor.textcolor),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 20),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 21),
//                                 child: CustomText(
//                                     text: widget.property!.typ,
//                                     size: 13,
//                                     weight: FontWeight.w400,
//                                     color: myColor.textcolor),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 20),
//                                 child: CustomText(
//                                     text: widget.property!.bedroom,
//                                     size: 13,
//                                     weight: FontWeight.w400,
//                                     color: myColor.textcolor),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 20),
//                                 child: CustomText(
//                                     text: widget.property!.bathroom,
//                                     size: 13,
//                                     weight: FontWeight.w400,
//                                     color: myColor.textcolor),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 20),
//                                 child: CustomText(
//                                     text: widget.property!.furnishing,
//                                     size: 13,
//                                     weight: FontWeight.w400,
//                                     color: myColor.textcolor),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 20),
//                                 child: CustomText(
//                                     text: widget.property!.sqft,
//                                     size: 13,
//                                     weight: FontWeight.w400,
//                                     color: myColor.textcolor),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 20),
//                                 child: CustomText(
//                                     text: widget.property!.totalFloors,
//                                     size: 13,
//                                     weight: FontWeight.w400,
//                                     color: myColor.textcolor),
//                               ),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.only(top: 20, bottom: 19),
//                                 child: CustomText(
//                                     text: widget.property!.agencyId ?? 'N/A',
//                                     size: 13,
//                                     weight: FontWeight.w400,
//                                     color: myColor.textcolor),
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 20),
//                           child: CustomText(
//                               text: "Adderss",
//                               size: 15,
//                               weight: FontWeight.w500,
//                               color: myColor.textcolor),
//                         )
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           width: 220,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 30, top: 10),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 CustomText(
//                                     text: widget.property!.fullAddress ?? 'N/A',
//                                     size: 13,
//                                     weight: FontWeight.w400,
//                                     color: myColor.textcolor),
//                                 CustomText(
//                                     text: widget.property!.landmark ?? 'N/A',
//                                     size: 13,
//                                     weight: FontWeight.w400,
//                                     color: myColor.textcolor),
//                                 CustomText(
//                                     text: widget.property!.roadName ?? 'N/A',
//                                     size: 13,
//                                     weight: FontWeight.w400,
//                                     color: myColor.textcolor),
//                                 CustomText(
//                                     text: widget.property!.pincode ?? 'N/A',
//                                     size: 13,
//                                     weight: FontWeight.w400,
//                                     color: myColor.textcolor),
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                     SizedBox(
//                       height: 60.h,
//                     ),
//                     Column(
//                       children: const [],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   // CustomInkwellButton(onTap: () {
//                   //   Navigator.push(context, MaterialPageRoute(builder: (context) => UserChat(agencyId : propertyDetails.agencyId,propertyId : propertyDetails.id),));
//                   // }, text: "Chat"),
//                   CustomInkwellButton(
//                     width: 150.w,
//                     height: 45.h,
//                     onTap: () {
//                       // Make a phone call
//                       if (agencyContactNumber != null) {
//                         _makePhoneCall(agencyContactNumber!);
//                       } else {
//                         print("Agency ID: ${widget.agid}");
//                         // Handle the case when the contact number is not available
//                         print('Agency contact number is not available.');
//                       }
//                     },
//                     text: "Contact Now",
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
