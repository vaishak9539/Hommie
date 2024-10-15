import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/user/view/home/user_category/user_view_home.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/custom_card.dart';
import 'package:hommie/widgets/custom_text.dart';
import 'package:hommie/user/view/home/user_category/user_property_view.dart';

class UserViewVilla extends StatefulWidget {
  const UserViewVilla({super.key});

  @override
  State<UserViewVilla> createState() => _UserViewVillaState();
}

class _UserViewVillaState extends State<UserViewVilla> {
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? _userId = FirebaseAuth.instance.currentUser?.uid;
  late Stream<QuerySnapshot> itemStream;
  late Stream<DocumentSnapshot> savedStream;

  @override
  void initState() {
    super.initState();
    // Stream for all properties from the main 'items' collection
    itemStream = _firestore.collectionGroup("item_List").snapshots();
    // Stream for the current user's saved properties
    savedStream = _firestore.collection('userSaved').doc(_userId).snapshots();
  }

  Future<void> _toggleSaved(String itemId, bool currentStatus) async {
    if (_userId == null) return;
    await _firestore.collection('userSaved').doc(_userId).set({
      itemId: !currentStatus,
    }, SetOptions(merge: true));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColor.background,
      appBar: CustomAppBar(title: "Home"),
      body: StreamBuilder<QuerySnapshot>(
        stream: itemStream,
        builder: (context, itemSnapshot) {
          if (itemSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (itemSnapshot.hasError) {
            return Center(child: Text("Error: ${itemSnapshot.error}"));
          }

          final propertyDocs = itemSnapshot.data?.docs ?? [];

          if (propertyDocs.isEmpty) {
            return const Center(child: Text("No properties found in the 'items' collection"));
          }

          // Debug: Print all documents
          print("Number of documents: ${propertyDocs.length}");
          for (var doc in propertyDocs) {
            print("Document ID: ${doc.id}, Data: ${doc.data()}");
          }

          // Filter for "Home" type here
          final homeProperties = propertyDocs.where((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return data['typ'] == 'Villa';
          }).toList();

          if (homeProperties.isEmpty) {
            return const Center(child: Text("No 'Home' type properties found"));
          }

          return StreamBuilder<DocumentSnapshot>(
            stream: savedStream,
            builder: (context, savedSnapshot) {
              Map<String, dynamic> saved =
                  savedSnapshot.data?.data() as Map<String, dynamic>? ?? {};

              return GridView.builder(
                itemCount: homeProperties.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 9 / 12,
                ),
                itemBuilder: (context, index) {
                  var itemData = homeProperties[index].data() as Map<String, dynamic>;
                  var property = Property.fromFirestore(itemData);
                  bool isSaved = saved[property.id] ?? false;

                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            // Navigate to property details
                          },
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    property.imageUrls.isNotEmpty
                                        ? property.imageUrls[0]
                                        : 'https://via.placeholder.com/150',
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: property.name,
                                        size: 14,
                                        weight: FontWeight.w500,
                                        color: myColor.textcolor,
                                      ),
                                      CustomText(
                                        text: property.fullAddress ?? "",
                                        size: 12,
                                        weight: FontWeight.w400,
                                        color: myColor.textcolor,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: CustomText(
                                          text: "${property.setPrice ?? "N/A"} L",
                                          size: 17,
                                          weight: FontWeight.w600,
                                          color: myColor.textcolor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 30,
                        right: 16,
                        child: IconButton(
                          onPressed: () => _toggleSaved(property.id, isSaved),
                          icon: Icon(
                            isSaved ? Icons.favorite : Icons.favorite_border,
                            color: isSaved ? Colors.red : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
    // final userVillaSavedProvider = Provider.of<UserVillaSavedProvider>(context);
    // return Scaffold(
    //   backgroundColor: myColor.background,
    //   appBar: CustomAppBar(title: "Villa"),
    //   body:  Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
        
    //     Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: InkWell(
    //           onTap: () {
    //               Navigator.push(context, MaterialPageRoute(builder: (context) => UserPropertyView(),));
    //           },
    //           child: CustomCard(
    //             color: Color.fromARGB(255, 231, 246, 245),
    //             elevation: 4,
    //             child: SizedBox(
    //               height: 200.h,
    //               width: 160.w,
    //               child:  Column(
                  
    //               crossAxisAlignment: CrossAxisAlignment.stretch,
    //               children: [
    //                 ClipRRect(
    //                   borderRadius:
    //                       BorderRadius.vertical(top: Radius.circular(8)),
    //                   child: Image.asset(
    //                     backgroundimage[2],
    //                     height: 100.h,
    //                     width: double.infinity,
    //                     fit: BoxFit.cover,
    //                   ),
    //                 ),
    //                 Padding(
    //                   padding: const EdgeInsets.only(top: 8, left: 8),
    //                   child: Row(
    //                     children: [
    //                       Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           CustomText(
    //                               text: "New Home",
    //                               size: 14,
    //                               weight: FontWeight.w500,
    //                               color: myColor.textcolor),
    //                           CustomText(
    //                               text: "nova auditorium\npalazhi",
    //                               size: 12,
    //                               weight: FontWeight.w400,
    //                               color: myColor.textcolor),
    //                           Row(
    //                             children: [
    //                               Padding(
    //                                 padding: const EdgeInsets.only(top: 8),
    //                                 child: CustomText(
    //                                     text: "35 L",
    //                                     size: 17,
    //                                     weight: FontWeight.w600,
    //                                     color: myColor.textcolor),
    //                               ),
    //                                Padding(
    //                                  padding: const EdgeInsets.only(left: 72),
    //                                  child: IconButton(onPressed: () {
                                       
    //                                  }, icon: Image.asset(icons[3],width: 20,)),
    //                                )
    //                             ],
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             )
    //           ),
    //         )),
      // ],
            // ),
            //  );
  }
}
      // body: GridView.builder(
      //   itemCount: 4,
      //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 2,
      //     mainAxisSpacing: 8.0,
      //     crossAxisSpacing: 8.0,
      //     childAspectRatio: 9 / 12,
      //   ),
      //   itemBuilder: (context, index) {
      //     return Stack(
      //       children: [
      //         Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: Card(
      //             elevation: 4,
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(8),
      //             ),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.stretch,
      //               children: [
      //                 ClipRRect(
      //                   borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
      //                   child: Image.asset(
      //                     backgroundimage[2],
      //                     height: 100.h,
      //                     width: double.infinity,
      //                     fit: BoxFit.cover,
      //                   ),
      //                 ),
      //                 Padding(
      //                   padding: const EdgeInsets.only(top: 8, left: 8),
      //                   child: Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       CustomText(
      //                         text: "Hilite Villa",
      //                         size: 14,
      //                         weight: FontWeight.w500,
      //                         color: myColor.textcolor,
      //                       ),
      //                       CustomText(
      //                         text: "nova auditorium\npalazhi",
      //                         size: 12,
      //                         weight: FontWeight.w400,
      //                         color: myColor.textcolor,
      //                       ),
      //                       Padding(
      //                         padding: const EdgeInsets.only(top: 8),
      //                         child: CustomText(
      //                           text: "35 L",
      //                           size: 17,
      //                           weight: FontWeight.w600,
      //                           color: myColor.textcolor,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //         Align(
      //           alignment: Alignment.bottomRight,
      //           child: Padding(
      //             padding: const EdgeInsets.only(bottom: 10, right: 8),
      //             child: IconButton(
      //               onPressed: () {
      //                 userVillaSavedProvider.userVillaSaved(index);
      //               },
      //               icon: userVillaSavedProvider.isvillaSaved(index)
      //                   ? Image.asset(
      //                       icons[2],
      //                       width: 20,
      //                     )
      //                   : Image.asset(
      //                       icons[3],
      //                       width: 20,
      //                     ),
      //             ),
      //           ),
      //         ),
      //       ],
      //     );
      //   },
      // ),
   
