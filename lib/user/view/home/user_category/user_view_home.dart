import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/user/view/home/user_category/user_property_view.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/custom_text.dart';

class UserViewHome extends StatefulWidget {
  const UserViewHome({Key? key}) : super(key: key);

  @override
  State<UserViewHome> createState() => _UserViewHomeState();
}

class _UserViewHomeState extends State<UserViewHome> {
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
            return data['typ'] == 'Home';
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
                  mainAxisExtent: 240,
                  
                  
                ),
                itemBuilder: (context, index) {
                  var itemData = homeProperties[index].data() as Map<String, dynamic>;
                  var property = Property.fromFirestore(itemData);
                  bool isSaved = saved[property.id] ?? false;
                  // var homeid=property.id;

                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                             Navigator.push(context,MaterialPageRoute(builder: (context) => UserPropertyView(homedetails:property, villadetails: null, apartmentdetails: null, ),));
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
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
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
  final String userId;
  final String? agencyId;

  Property({
    required this.id,
    required this.typ,
    required this.name,
    required this.bedroom,
    required this.bathroom,
    required this.furnishing,
    required this.sqft,
    required this.totalFloors,
    required this.imageUrls,
    this.carParking,
    this.fullAddress,
    this.roadName,
    this.landmark,
    this.pincode,
    this.setPrice,
    this.description,
    required this.timestamp,
    required this.userId,
     this.agencyId,
  });

  factory Property.fromFirestore(Map<String, dynamic> data) {
    return Property(
      id: data['id'] ?? '',
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
      userId: data['userId'] ?? '',
      agencyId: data['agencyId'],
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
      'userId': userId,
      'agencyId': agencyId,
    };
  }
}