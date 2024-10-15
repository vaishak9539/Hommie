import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/agency/view/agencyhome/agencyitemlist/agency_add_home_details.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/custom_card.dart';
import 'package:hommie/widgets/custom_text.dart';
import 'package:hommie/user/view/home/user_notification.dart';

class UserSaved extends StatelessWidget {
  const UserSaved({super.key});

  @override
  Widget build(BuildContext context) {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;

    return

    Scaffold(
      backgroundColor: myColor.background,
      appBar: CustomAppBar(
        automaticallyImplyLeading: false,
        title: "Saved",
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserNotification()),
                );
              },
              icon: Icon(Icons.notifications, size: 25),
            ),
          ),
        ],
      ),
      body: userId == null
          ? Center(child: Text('Please log in to view saved items'))
          : StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('userSaved')
                  .doc(userId)
                  .snapshots(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (userSnapshot.hasError) {
                  return Center(child: Text('Error: ${userSnapshot.error}'));
                }

                if (!userSnapshot.hasData || userSnapshot.data!.data() == null) {
                  return  Center(
                    child: CustomText(
                      text: 'No saved items yet',
                      size: 15,
                      color: Colors.white,
                      weight: FontWeight.w400,
                    ),
                  );
                }

                // Get the saved item IDs
                Map<String, dynamic> savedData =
                    userSnapshot.data!.data() as Map<String, dynamic>;
                List<String> savedItemIds = savedData.keys
                    .where((key) => savedData[key] == true)
                    .toList();

                if (savedItemIds.isEmpty) {
                  return Center(
                    child: CustomText(
                      text: 'No saved items yet',
                      size: 15,
                      color: Colors.white,
                      weight: FontWeight.w400,
                    ),
                  );
                }

                // Fetch the saved properties from 'item_List' collection
                return FutureBuilder<List<DocumentSnapshot>>(
                   future: _fetchSavedItems(savedItemIds),
                  builder: (context, savedSnapshot) {
                    if (savedSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (savedSnapshot.hasError) {
                      return Center(
                        child: Text('Error: ${savedSnapshot.error}'),
                      );
                    }
                    List<DocumentSnapshot> savedDocs = savedSnapshot.data ?? [];

                     if (savedDocs.isEmpty) {
                      return Center(
                        child: CustomText(
                          text: 'No saved items found',
                          size: 15,
                          color: Colors.white,
                          weight: FontWeight.w400,
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: savedDocs.length,
                      itemBuilder: (context, index) {
                         var itemData = savedDocs[index].data() as Map<String, dynamic>;

                       Property item = Property.fromFirestore(savedDocs[index]);
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Card(
                            elevation: 4,
                            child: Container(
                              height: 280.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(255, 231, 246, 245),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: CustomCard(
                                      child: SizedBox(
                                        height: 160.h,
                                        width: 292.w,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: item.imageUrls.isNotEmpty
                                              ? Image.network(
                                                  item.imageUrls[0],
                                                  fit: BoxFit.cover,
                                                )
                                              : Container(
                                                  color: Colors.grey[800],
                                                  child: const Icon(
                                                    Icons.home,
                                                    size: 60,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18, top: 8),
                                    child: CustomText(
                                      text: item.name,
                                      size: 20,
                                      weight: FontWeight.bold,
                                      color: myColor.textcolor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 18),
                                        child: Icon(Icons.location_on,
                                            color: myColor.textcolor, size: 15),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 6, top: 5),
                                        child: CustomText(
                                          text: item.fullAddress ??
                                              "Address not available",
                                          size: 13,
                                          weight: FontWeight.w400,
                                          color: myColor.textcolor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 25, top: 5),
                                    child: CustomText(
                                      text: "${item.setPrice ?? 'N/A'} L",
                                      size: 23,
                                      weight: FontWeight.bold,
                                      color: myColor.textcolor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );

                    // Display the saved items

                  },
                );
              },
            ),
    );
  }
}

Future<List<DocumentSnapshot>> _fetchSavedItems(List<String> itemIds) async {
  try {
    // Use a query to fetch multiple documents at once

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collectionGroup('item_List') .where(FieldPath.documentId)// Adjust the collection name as necessary
      
        .get();

    return snapshot.docs;
  } catch (e) {
    print('Error fetching saved items: $e');
    return [];
  }
}

// ------------------------now commented ---------------------------



// class Property {
//   String id;
//   final List<String> imageUrls;
//   final String typ;
//   final String name;
//   final String bedroom;
//   final String bathroom;
//   final String furnishing;
//   final String sqft;
//   final String totalFloors;
//   final String? carParking;
//   final String? fullAddress;
//   final String? roadName;
//   final String? landmark;
//   final String? pincode;
//   final String? setPrice;
//   final String? description;
//   final DateTime timestamp;
//   final String userId;

//   Property({
//     required this.id,
//     required this.typ,
//     required this.name,
//     required this.bedroom,
//     required this.bathroom,
//     required this.furnishing,
//     required this.sqft,
//     required this.totalFloors,
//     required this.imageUrls,
//     this.carParking,
//     this.fullAddress,
//     this.roadName,
//     this.landmark,
//     this.pincode,
//     this.setPrice,
//     this.description,
//     required this.timestamp,
//     required this.userId,
//   });

//   // Updated constructor to correctly handle DocumentSnapshot
//   factory Property.fromFirestore(Map<String, dynamic> data) {
//     // Fetch the map data from the document
//     // Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

//     return Property(
//       id:  data['id'] ?? '', // Use the doc ID
//       typ: data['typ'] ?? '',
//       name: data['name'] ?? '',
//       bedroom: data['bedroom'] ?? '',
//       bathroom: data['bathroom'] ?? '',
//       furnishing: data['furnishing'] ?? '',
//       sqft: data['sqft'] ?? '',
//       totalFloors: data['totalFloors'] ?? '',
//       imageUrls: List<String>.from(data['imageUrls'] ?? []),
//       carParking: data['carParking'],
//       fullAddress: data['fullAddress'],
//       roadName: data['roadName'],
//       landmark: data['landmark'],
//       pincode: data['pincode'],
//       setPrice: data['setPrice'],
//       description: data['description'],
//       timestamp: (data['timestamp'] as Timestamp).toDate(),
//       userId: data['userId'] ?? '',
//     );
//   }
// }

// Stack(
//   children: [
//     Padding(
//       padding: const EdgeInsets.only(
//         left: 15,
//         right: 15,
//       ),
//       child: Card(
//         elevation: 4,
//         child: Container(
//           height: 280.h,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: Color.fromARGB(255, 231, 246, 245),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(
//                         left: 10, top: 10, right: 10),
//                     child: CustomCard(
//                         child: SizedBox(
//                       height: 160.h,
//                       width: 292.w,
//                       child: ClipRRect(
//                           borderRadius: BorderRadius.circular(6),
//                           child: Image.asset(
//                             backgroundimage[1],
//                             height: 180.h,
//                             fit: BoxFit.cover,
//                           )),
//                     )),
//                   )
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 18, top: 8),
//                 child: CustomText(
//                     text: "New Home",
//                     size: 20,
//                     weight: FontWeight.bold,
//                     color: myColor.textcolor),
//               ),
//               Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 18),
//                     child: Image.asset(
//                       icons[4],
//                       width: 15,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 6, top: 5),
//                     child: CustomText(
//                         text: "nova  auditorium,\npalazhi",
//                         size: 13,
//                         weight: FontWeight.w400,
//                         color: myColor.textcolor),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 25, top: 5),
//                 child: CustomText(
//                     text: "35,0000",
//                     size: 23,
//                     weight: FontWeight.bold,
//                     color: myColor.textcolor),
//               )
//             ],
//           ),
//         ),
//       ),
//     ),
//     Positioned(
//       bottom: 60,
//       right: 40,
//       child: IconButton(
//           onPressed: () {},
//           icon: Image.asset(
//             icons[2],
//             width: 28,
//           )),
//     ),
//   ],
// )
