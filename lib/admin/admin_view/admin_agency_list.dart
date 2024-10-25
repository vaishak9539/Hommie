import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hommie/admin/admin_view/admin_agency_details.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/widgets/custom_card.dart';
import 'package:hommie/widgets/custom_text.dart';

class AdminAgencyList extends StatefulWidget {
  const AdminAgencyList({super.key});

  @override
  State<AdminAgencyList> createState() => _AdminAgencyListState();
}

class _AdminAgencyListState extends State<AdminAgencyList> {

   

  Future<void> deleteAgencyAndItems(String agencyId,) async {
  try {
    // Step 1: Delete the agency document from Firestore
    await FirebaseFirestore.instance.collection('Agencies').doc(agencyId).delete();

    // Step 2: Delete all items associated with the agency
    var itemListQuery = await FirebaseFirestore.instance
        .collectionGroup('item_List')
        .where('agencyId', isEqualTo: agencyId)
        .get();

    for (var item in itemListQuery.docs) {
      await item.reference.delete(); // Delete each item in the item_List
    }

      final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.uid == agencyId) {
      
      await currentUser.delete();
    } else {
      print('Unable to delete user account, user not found');
    }

    print('Agency, corresponding user, and all items deleted successfully');
  } catch (e) {
    print('Error deleting agency and items: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Agencies").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          Center(child: Text("Error: ${snapshot.error}"));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No items found"));
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var agencydata = snapshot.data!.docs[index];
            print("agencydata : $agencydata");
            var docid = agencydata.id;
            print(" docid : $docid");
            // var userid = userdata.id;
            var name = agencydata["Name"];
            var agencyImageUrl = agencydata.data().containsKey("ImageUrl")
                ? agencydata["ImageUrl"]
                : null;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomCard(
                  child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[400],
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AdminAgencyDetails(agencydata : agencydata, docid : docid)
                        ));
                  },
                 leading: CircleAvatar(
                  
                      backgroundImage: (agencyImageUrl != null && agencyImageUrl.isNotEmpty)
                          ? NetworkImage(agencyImageUrl)
                          : AssetImage("assets/images/User 1.png"),
                    
                    ),
                  title: CustomText(
                      text: name,
                      size: 15,
                      weight: FontWeight.w500,
                      color: myColor.textcolor),

                      trailing: IconButton(onPressed: ()async {
                         await deleteAgencyAndItems(docid);
                      }, icon: Icon(CupertinoIcons.delete),)
                ),
                
              )
              ),
            );
          },
        );
      },
    ));
  }
}