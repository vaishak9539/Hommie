// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hommie/agency/new/agency_chat_list.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/user/view/home/user_category/user_property_view.dart';
import 'package:hommie/user/view/home/user_category/user_view_home.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/custom_text.dart';
import 'package:hommie/widgets/custom_textfield.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? _userId = FirebaseAuth.instance.currentUser?.uid;
  late Stream<QuerySnapshot> itemStream;
  late Stream<DocumentSnapshot> savedStream;
  final TextEditingController _searchController = TextEditingController();

 

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
      appBar: CustomAppBar(
        automaticallyImplyLeading: false,
        title: "Home",
        actions: [],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
 
          SizedBox(
            height: 33.h,
            child: CustomTextField(
              controller: _searchController,
              contentPadding: EdgeInsets.all(10),
              prefixIcon: Icon(Icons.search_rounded),
              fillColor: myColor.tabcolor,
              filled: true,
              borderWidth: 0,

            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 15),
            child: CustomText(
                text: "Recomented",
                size: 17,
                weight: FontWeight.w500,
                color: myColor.textcolor),
          ),

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
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
                  return const Center(
                      child: Text(
                          "No properties found in the 'items' collection"));
                }

                // Debug: Print all documents
                print("Number of documents: ${propertyDocs.length}");
                for (var doc in propertyDocs) {
                  print("Document ID: ${doc.id}, Data: ${doc.data()}");
                }

                // Filter for "Home" type here
                final homeProperties = propertyDocs.where((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  return data['typ'] == 'Home';
                }).toList();

                if (homeProperties.isEmpty) {
                  return const Center(
                      child: Text("No 'Home' type properties found"));
                }

                return StreamBuilder<DocumentSnapshot>(
                  stream: savedStream,
                  builder: (context, savedSnapshot) {
                    Map<String, dynamic> saved =
                        savedSnapshot.data?.data() as Map<String, dynamic>? ??
                            {};

                    return GridView.builder(
                      itemCount: 4,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 2.0,
                        crossAxisSpacing: 0.0,
                        childAspectRatio: 9 / 12,
                      ),
                      itemBuilder: (context, index) {
                        var itemData = homeProperties[index].data()
                            as Map<String, dynamic>;
                        var property = Property.fromFirestore(itemData);
                        bool isSaved = saved[property.id] ?? false;
                        // var homeid=property.id;

                        return Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UserPropertyView(
                                          homedetails: property,
                                          villadetails: null,
                                          apartmentdetails: null,
                                        ),
                                      ));
                                },
                                child: Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                              padding:
                                                  const EdgeInsets.only(top: 8),
                                              child: CustomText(
                                                text:
                                                    "${property.setPrice ?? "N/A"} L",
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
                                onPressed: () =>
                                    _toggleSaved(property.id, isSaved),
                                icon: Icon(
                                  isSaved
                                      ? Icons.favorite
                                      : Icons.favorite_border,
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
          ),
        ],
      ),
    );
  }
}

//  Future<List<DocumentSnapshot>> _getitemSuggestions(String query) async {
//     if (query.isEmpty) {
//       return [];
//     }

//     try {
//       String lowercaseQuery = query.toLowerCase();

//       QuerySnapshot querySnapshot =
//           await FirebaseFirestore.instance.collectionGroup('item_List').get();

//       List<DocumentSnapshot> filteredResults = querySnapshot.docs.where((doc) {
//         String typ =
//             (doc.data() as Map<String, dynamic>)['typ'] as String? ?? '';
//         return typ.toLowerCase().contains(lowercaseQuery);
//       }).toList();

//       return filteredResults;
//     } catch (e) {
//       print("Error occurred during search: $e");
//       return [];
//     }
//   }

// Padding(
//            padding: const EdgeInsets.only(left: 20),
//            child:
//             SizedBox(
//              height: 45,
//              width: 300,
//              child: Container(
//                decoration: BoxDecoration(
//                  border: Border.all(
//                    color: Colors.grey, // Border color
//                    width: 2.0, // Border width
//                  ),
//                  borderRadius: BorderRadius.circular(8), // Rounded corners
//                ),
//                child: TypeAheadField<DocumentSnapshot>(
                 
//            suggestionsCallback: (pattern) async {
//                    return await _getitemSuggestions(pattern);
//                  },
//                  itemBuilder: (context, DocumentSnapshot suggestion) {
//                    Map<String, dynamic> data =
//               suggestion.data() as Map<String, dynamic>;
//                    return ListTile(
//             tileColor: Colors.black,
//             leading: CircleAvatar(
//               backgroundImage: NetworkImage(data['imageUrls'][0]),
//             ),
//             title: CustomText(
//               text: data['name'] ?? 'No name',
//               size: 15,
//               weight: FontWeight.normal,
//               color: myColor.textcolor,
//             ),
//             subtitle: CustomText(
//               text: data['setPrice'] ?? 'No setPrice',
//               size: 12,
//               weight: FontWeight.normal,
//               color: myColor.textcolor,
//             ),
//                    );
//                  },
//                  onSelected: (DocumentSnapshot suggestion) {
//                    Map<String, dynamic> data =
//               suggestion.data() as Map<String, dynamic>;
//                    Property property = Property.fromFirestore(data);
//                    Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => AgencyChatList(
//                 recipe: property,
//                 recipeId: suggestion.id,
//               ),
//             ),
//                    );
//                  },
                 
//                ),
//              ),
//            ),
//          ),
