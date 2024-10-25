// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:hommie/model/message.dart';

// class ChatService extends ChangeNotifier {
//   final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   Future<void> sendMessage(String receiverId, String message)async{
//     final String currentUserId = _firebaseAuth.currentUser!.uid;
//     final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
//     final Timestamp timestamp = Timestamp.now();

//     Message newMessage = Message(
//         senderId: currentUserId,
//         senderEmail: currentUserEmail,
//         receiverId: receiverId,
//         message: message,
//         timestamp: timestamp);

//     List<String> ids = [currentUserId, receiverId];
//     ids.sort();
//     String chatRoomId = ids.join("_");

// //Add new messages to database
//     await _fireStore
//         .collection("ChatRooms")
//         .doc(chatRoomId)
//         .collection("Messages")
//         .add(newMessage.toMap());
//   }

//   Stream <QuerySnapshot> getMessages(String userId, String otherUserId){
//     List <String> ids = [userId,otherUserId];
//     ids.sort();
//     String chatRoomId = ids.join("_");
//     return _fireStore.collection("ChatRooms").doc(chatRoomId).collection("Messages").orderBy("timestamp", descending: false).snapshots();
//   }
// }
