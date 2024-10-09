// import 'package:cloud_firestore/cloud_firestore.dart';

// class AgencyItemModel {
//   Stream<List<AgencyItem>> getAgencyItems() {
//     return FirebaseFirestore.instance
//         .collection('items')
//         .snapshots()
//         .map((snapshot) {
//       return snapshot.docs.map((doc) {
//         return AgencyItem(
//           documentId: doc.id, // Get the document ID
//           name: doc['Name'],
//           roadName: doc['RoadName'],
//           imageUrl: doc.data().containsKey('ImageUrl') 
//               ? doc['ImageUrl'] 
//               : '', // Default to empty string if imageUrl is not available
//         );
//       }).toList();
//     });
//   }
// }

// class AgencyItem {
//   final String documentId; // New field for document ID
//   final String name;
//   final String roadName;
//   final String imageUrl;

//   AgencyItem({
//     required this.documentId,
//     required this.name,
//     required this.roadName,
//     required this.imageUrl,
//   });
// }

