// import 'package:cloud_firestore/cloud_firestore.dart';

// class Message {
//   final String senderId;
//   final String senderName;
//   final String receiverId;
//   final String message;
//   final Timestamp timestamp;
//   final String propertyId;
//   final String propertyName;
//   final bool isUserMessage;
//   final String formattedTime;
//   final List? participants;

//   // Constructor
//   Message({
//     required this.senderId,
//     required this.senderName,
//     required this.receiverId,
//     required this.message,
//     required this.timestamp,
//     required this.propertyId,
//     required this.propertyName,
//     required this.isUserMessage,
//     required this.formattedTime,
//     this.participants,
//   });

//   // Convert Message object to a map (for Firestore)
//   Map<String, dynamic> toMap() {
//     return {
//       'senderId': senderId,
//       'senderName': senderName,
//       'receiverId': receiverId,
//       'message': message,
//       'timestamp': timestamp,
//       'propertyId': propertyId,
//       'propertyName': propertyName,
//       'isUserMessage': isUserMessage,
//       'formattedTime': formattedTime,
//       'participants' : participants
//     };
//   }

//   // Factory to create Message from Firestore document
//   factory Message.fromDocument(DocumentSnapshot doc) {
//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//     return Message(
//       senderId: data['senderId'],
//       senderName: data['senderName'],
//       receiverId: data['receiverId'],
//       message: data['message'],
//       timestamp: data['timestamp'],
//       propertyId: data['propertyId'],
//       propertyName: data['propertyName'],
//       isUserMessage: data['isUserMessage'],
//       formattedTime: data['formattedTime'],
//       participants : data ['participants']
//     );
//   }
// }
