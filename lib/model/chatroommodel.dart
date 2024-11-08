// import 'package:cloud_firestore/cloud_firestore.dart';

// class ChatRoom {
//   final String chatRoomId;
//   final String agencyId;
//   final String agencyName;
//   final String propertyId;
//   final String propertyName;
//   final String lastMessage;
//   final Timestamp lastMessageTimestamp;
//   final String lastMessageSenderId;

//   ChatRoom({
//     required this.chatRoomId,
//     required this.agencyId,
//     required this.agencyName,
//     required this.propertyId,
//     required this.propertyName,
//     required this.lastMessage,
//     required this.lastMessageTimestamp,
//     required this.lastMessageSenderId,
//   });

//   // Convert ChatRoom to a map for Firestore
//   Map<String, dynamic> toMap() {
//     return {
//       'agencyId': agencyId,
//       'agencyName': agencyName,
//       'propertyId': propertyId,
//       'propertyName': propertyName,
//       'lastMessage': lastMessage,
//       'lastMessageTimestamp': lastMessageTimestamp,
//       'lastMessageSenderId': lastMessageSenderId,
//     };
//   }

//   // Factory to create ChatRoom from Firestore document
//   factory ChatRoom.fromDocument(DocumentSnapshot doc) {
//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//     return ChatRoom(
//       chatRoomId: doc.id,
//       agencyId: data['agencyId'],
//       agencyName: data['agencyName'],
//       propertyId: data['propertyId'],
//       propertyName: data['propertyName'],
//       lastMessage: data['lastMessage'] ?? '',
//       lastMessageTimestamp: data['lastMessageTimestamp'],
//       lastMessageSenderId: data['lastMessageSenderId'],
//     );
//   }
// }
