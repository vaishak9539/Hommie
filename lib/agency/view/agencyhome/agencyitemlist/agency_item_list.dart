import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hommie/agency/view/agencyhome/agencyitemlist/agency_add_item.dart';
import 'package:hommie/agency/view/agencyhome/agencyitemlist/agency_item_view.dart';
import 'package:hommie/agency/view/agencyhome/agencyitemlist/agency_list_update.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/custom_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AgencyItemList extends StatefulWidget {
  const AgencyItemList({super.key});

  @override
  State<AgencyItemList> createState() => _AgencyItemListState();
}

class _AgencyItemListState extends State<AgencyItemList> {
  String? userId;

  @override
  void initState() {
    super.initState();
    _getUserId().then((_) {
      setState(() {}); // Trigger a rebuild with the updated userId
    });
  }

  Future<void> _getUserId() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userId = user.uid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColor.background,
      appBar: CustomAppBar(
        title: "Home",
        automaticallyImplyLeading: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('items')
            .doc(userId)
            .collection("item_List")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No items found"));
          }
        
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var itemData = snapshot.data!.docs[index];
                var documentId = itemData.id;
                var name = itemData["name"] ?? "No Name";
                var roadName = itemData["roadName"] ?? "Unknown road";

                List<dynamic> imageUrls = itemData["imageUrls"] ?? [];
                var imageUrl =
                    imageUrls.isNotEmpty ? imageUrls[0] : backgroundimage[1];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Row(
                      children: [
                        SizedBox(
                          height: 85,
                          width: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: imageUrl.startsWith('http')
                                ? Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AgencyItemView(
                                    itemData:
                                        itemData.data() as Map<String, dynamic>,
                                    documentId: documentId,
                                  ),
                                ),
                              );
                            },
                            title: CustomText(
                              text: name,
                              size: 16,
                              weight: FontWeight.w500,
                              color: myColor.textcolor,
                            ),
                            subtitle: CustomText(
                              text: roadName,
                              size: 12,
                              weight: FontWeight.w400,
                              color: myColor.textcolor,
                            ),
                            trailing: PopupMenuButton<String>(
                              color: myColor.background,
                              onSelected: (value) {
                                if (value == 'Delete') {
                                  // deleteItem(
                                  //     documentId);
                                }
                                if (value == "Edit") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AgencyListUpdate(
                                        documentId: documentId,
                                      ),
                                    ),
                                  );
                                }
                              },
                              itemBuilder: (context) {
                                return [
                                  const PopupMenuItem(
                                    value: 'Edit',
                                    child: Text("Edit"),
                                  ),
                                  const PopupMenuItem(
                                    value: 'Delete',
                                    child: Text("Delete"),
                                  ),
                                ];
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: myColor.maincolor,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AgencyaddItem()),
            );
          },
          child: Icon(
            Icons.add,
            size: 40,
            color: myColor.background,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
