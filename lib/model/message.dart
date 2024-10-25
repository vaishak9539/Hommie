
// import 'package:cloud_firestore/cloud_firestore.dart';

// class Message {
//   final String senderId;
//   final String senderEmail;
//   final String receiverId;
//   final String message;
//   final Timestamp timestamp;

//   // Constructor
//   Message({
//     required this.senderId,
//     required this.senderEmail,
//     required this.receiverId,
//     required this.message,
//     required this.timestamp,
//   });

//   // Convert Message object to a map (for Firestore)
//   Map<String, dynamic> toMap() {
//     return {
//       'senderId': senderId,
//       'senderEmail': senderEmail,
//       'receiverId': receiverId,
//       'message': message,
//       'timestamp': timestamp,
//     };
//   }

 
// }

 // factory Message.fromDocument(DocumentSnapshot doc) {
  //   Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //   return Message(
  //     senderId: data['senderId'],
  //     senderEmail: data['senderEmail'],
  //     receiverId: data['receiverId'],
  //     message: data['message'],
  //     timestamp: data['timestamp'],
  //   );
  // }