import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hommie/admin/admin_view/admin_property_view.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/custom_text.dart';

class AgencyPropertyList extends StatefulWidget {
  final docid;
  const AgencyPropertyList({super.key, required this.docid});

  @override
  State<AgencyPropertyList> createState() => _AgencyPropertyListState();
}

class _AgencyPropertyListState extends State<AgencyPropertyList> {
  
  @override
  Widget build(BuildContext context) {
    var docid= widget.docid;
    return Scaffold(
      appBar: CustomAppBar(title: "Property Details"),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("items")
            .doc(docid)
            .collection("item_List")
            .snapshots(),
        builder: (context, snapshot) {
          
          if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      print("No items found for agency ID: $docid"); // Debugging
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
                        var imageUrl = imageUrls.isNotEmpty
                            ? imageUrls[0]
                            : backgroundimage[1];

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
                                          builder: (context) => AgencyPropertyView(
                                            itemData: itemData.data()
                                                as Map<String, dynamic>,
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
    );
  }
}
