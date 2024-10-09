import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hommie/agency/view/agencyhome/agencyitemlist/agency_add_item.dart';
import 'package:hommie/agency/view/agencyhome/agencyitemlist/agency_item_view.dart';
import 'package:hommie/agency/view/agencyhome/agencyitemlist/agency_list_update.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/custom_text.dart';

class AgencyItemList extends StatefulWidget {
  const AgencyItemList({super.key});

  @override
  State<AgencyItemList> createState() => _AgencyItemListState();
}

class _AgencyItemListState extends State<AgencyItemList> {
  void itemsdelete(String documentId) {
    FirebaseFirestore.instance
        .collection("items")
        .doc(documentId)
        .delete()
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Item deleted successfully"),
        ),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to delete item: $error"),
        ),
      );
    });
  }

  void itemUpdate(){
    
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
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No items found"));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var itemData = snapshot.data!.docs[index];
              var documentId = itemData.id; 
              var name = itemData["Name"] ?? "No Name"; 
              var roadName = itemData["RoadName"] ?? "Unknown road";

              
              List<dynamic> imageUrls = itemData["imageUrls"] ?? [];
              var imageUrl = imageUrls.isNotEmpty
                  ? imageUrls[0] 
                  : backgroundimage[1]; 

              
              return Padding(
  padding: const EdgeInsets.all(8.0),
  child: Card(
    child: Row(
      children: [
        // Image Section
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
        // ListTile Section
        Expanded(
          child: ListTile(
            onTap: () {
              // Navigate to view item details
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AgencyItemView(
                    itemData: itemData.data() as Map<String, dynamic>,
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
                  itemsdelete(documentId);
                }
                if (value == "Edit") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AgencyListUpdate(),
                    ),
                  );
                }
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 'Edit',
                    child: Text("Edit"),
                  ),
                  PopupMenuItem(
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: myColor.maincolor,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AgencyaddItem()));
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
