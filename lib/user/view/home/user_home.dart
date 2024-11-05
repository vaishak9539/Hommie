// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/user/view/home/filterd_property.dart';
import 'package:hommie/user/view/home/model/filtermodel.dart';
import 'package:hommie/user/view/home/user_category/user_property_view.dart';
import 'package:hommie/user/view/home/user_category/user_view_home.dart';
import 'package:hommie/user/view/home/user_chat/user_chat_list.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/custom_text.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final currentUserId;
  var userId;
  Stream<QuerySnapshot>? itemStream ;
   Stream<DocumentSnapshot>? savedStream;
    String? _selectedType;
  RangeValues _priceRange = RangeValues(0, 1000000);
  // final TextEditingController _searchController = TextEditingController();
  PropertyFilter currentFilter = PropertyFilter();

  Future<void> _fetchUserId() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        // Fetch the agency document associated with this user
        final userDoc = await FirebaseFirestore.instance
            .collection('Users')
            .where('AuthUid', isEqualTo: user.uid).limit(1)
            .get();

        if (userDoc.docs.isNotEmpty) {
          setState(() {
            userId = userDoc.docs.first.id;
             savedStream = _firestore.collection('userSaved').doc(userId).snapshots();
            log("Home $userId");
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No agency found for this user')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching agency details: $e')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
 itemStream = _firestore.collectionGroup("item_List").snapshots();
   _fetchUserId();
     
   
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColor.background,
      appBar: CustomAppBar(
        automaticallyImplyLeading: false,
        title: "Home",
        actions: [
           Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.chat),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: () {
              return _showFilterDialog(context);
            }, icon: Icon(Icons.filter_list)),
          )
        ],
      ),
      endDrawer: Drawer(
        width: double.infinity,
        child: ChatListScreen()
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

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
                  print(itemSnapshot.error);
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
             return    
                     GridView.builder(
                      // itemCount: saved.length,
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
                                                    "${property.setPrice ?? "N/A"} ",
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
  Future<void> _toggleSaved(String itemId, bool currentStatus) async {
    if (userId == null) {
      // Show a message to user that they need to login
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please login to save items')),
      );
      return;
    }

    try {
      await _firestore.collection('userSaved').doc(userId).set({
        itemId: !currentStatus,
      }, SetOptions(merge: true));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving item: $e')),
      );
    }
  }


   Future<List<DocumentSnapshot>> _getItemSuggestions(String query) async {
    if (query.isEmpty) {
      return [];
    }

    try {
      String lowercaseQuery = query.toLowerCase();

      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collectionGroup("item_List").get();

      List<DocumentSnapshot> filteredResults = querySnapshot.docs.where((doc) {
        String title =
            (doc.data() as Map<String, dynamic>)['typ'] as String? ?? '';
        return title.toLowerCase().contains(lowercaseQuery);
      }).toList();

      return filteredResults;
    } catch (e) {
      print("Error occurred during search: $e");
      return [];
    }
  }



   void _showFilterDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Filter Properties",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),

                // Filter by type dropdown
                DropdownButton<String>(
                  value: _selectedType,
                  hint: Text("Select Type"),
                  onChanged: (String? newValue) {
                    setModalState(() {
                      _selectedType = newValue;
                    });
                  },
                  items: ['Home', 'Villa', 'Apartment'].map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                ),

                SizedBox(height: 16),

                // Filter by price range slider
                RangeSlider(
                  values: _priceRange,
                  min: 0,
                  max: 1000000,
                  divisions: 100,
                  labels: RangeLabels(
                    _priceRange.start.round().toString(),
                    _priceRange.end.round().toString(),
                  ),
                  onChanged: (values) {
                    setModalState(() {
                      _priceRange = values;
                    });
                  },
                ),

                SizedBox(height: 16),

                // Apply Filters button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the bottom sheet
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FilteredPropertyListScreen(
                          type: _selectedType,
                          priceRange: _priceRange,
                        ),
                      ),
                    );
                  },
                  child: Text("Apply Filters"),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}


}



