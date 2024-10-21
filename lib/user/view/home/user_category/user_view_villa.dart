import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/user/view/home/user_category/user_property_view.dart';
import 'package:hommie/user/view/home/user_category/user_view_home.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/custom_text.dart';

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

    itemStream = _firestore.collectionGroup("item_List").snapshots();

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
            return const Center(
                child: Text("No properties found in the 'items' collection"));
          }

          print("Number of documents: ${propertyDocs.length}");
          for (var doc in propertyDocs) {
            print("Document ID: ${doc.id}, Data: ${doc.data()}");
          }

          final villaProperties = propertyDocs.where((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return data['typ'] == 'Villa';
          }).toList();

          if (villaProperties.isEmpty) {
            return const Center(child: Text("No 'Home' type properties found"));
          }

          return 
          
          
          StreamBuilder<DocumentSnapshot>(
            stream: savedStream,
            builder: (context, savedSnapshot) {
              Map<String, dynamic> saved =
                  savedSnapshot.data?.data() as Map<String, dynamic>? ?? {};

              return GridView.builder(
                itemCount: villaProperties.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 9 / 12,
                  mainAxisExtent: 240,
                ),
                itemBuilder: (context, index) {
                  var itemData =
                      villaProperties[index].data() as Map<String, dynamic>;
                  var property = Property.fromFirestore(itemData);
                  bool isSaved = saved[property.id] ?? false;
                  // var villaid = property.id;

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
                                    villadetails: property ,
                                    homedetails: null,
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
                                        padding: const EdgeInsets.only(top: 8),
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
