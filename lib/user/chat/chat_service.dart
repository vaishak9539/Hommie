// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:hommie/model/message.dart';
// import 'package:intl/intl.dart';

// class ChatService {
//   final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   // Method to send a message
//   Future<void> sendMessage({
//     required String agencyId,
//     required String propertyId,
//     required String propertyName,
//     required bool isUserInitiating,
//     required String message,
//   }) async {
//     final currentUser = _firebaseAuth.currentUser;
//     if (currentUser == null) throw Exception('User is not logged in.');

//     final senderId = currentUser.uid;
//     final senderName = currentUser.email ?? "Unknown Sender";
//     final timestamp = Timestamp.now();
//     final formattedTime = DateFormat('HH:mm a').format(timestamp.toDate());

//     final chatRoomId = _generateChatRoomId(senderId, agencyId, propertyId);

//     final newMessage = Message(
//       senderId: senderId,
//       senderName: senderName,
//       receiverId: agencyId,
//       message: message,
//       timestamp: timestamp,
//       propertyId: propertyId,
//       propertyName: propertyName,
//       isUserMessage: isUserInitiating,
//       formattedTime: formattedTime,
//       participants: [senderId,agencyId]
//     );

//     // Add message to Firestore
//     await _fireStore
//         .collection("ChatRooms")
//         .doc(chatRoomId)
//         .collection("Messages")
//         .add(newMessage.toMap());
//   }

//   // Method to retrieve messages for a specific chat room
//   Stream<List<Message>> getMessages(String userId, String agencyId, String propertyId) {
//     final chatRoomId = _generateChatRoomId(userId, agencyId, propertyId);

//     return _fireStore
//         .collection("ChatRooms")
//         .doc(chatRoomId)
//         .collection("Messages")
//         .orderBy("timestamp", descending: false)
//         .snapshots()
//         .map((snapshot) {
//       return snapshot.docs.map((doc) => Message.fromDocument(doc)).toList();
//     });
//   }

//   // Helper method to generate chat room ID
//   String _generateChatRoomId(String userId, String agencyId, String propertyId) {
//     List<String> ids = [userId, agencyId];
//     ids.sort();
//     return "${ids[0]}_${ids[1]}_$propertyId";
//   }
// }
