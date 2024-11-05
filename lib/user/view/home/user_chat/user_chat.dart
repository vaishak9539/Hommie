// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:hommie/model/utils/style/color.dart';
// import 'package:hommie/widgets/custom_textfield.dart';

// class UserAgencyChat extends StatefulWidget {
//   var agencyId;
//   var propertyId;
//   final bool isUserInitiating; // Determines who initiated the chat

//   UserAgencyChat({
//     super.key,
//     required this.agencyId,
//     required this.propertyId,
//     this.isUserInitiating = true,
//   });

//   @override
//   State<UserAgencyChat> createState() => _UserAgencyChatState();
// }

// class _UserAgencyChatState extends State<UserAgencyChat> {
//   final TextEditingController _messageController = TextEditingController();
//   final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   String? senderName;
//   String? receiverName;
//   String? propertyName;

//   @override
//   void initState() {
//     super.initState();
//     _fetchChatParticipantsInfo();
//   }

//   // Fetch information about chat participants and property
//   Future<void> _fetchChatParticipantsInfo() async {
//     try {
//       // Fetch current user's information
//       String currentUserId = _firebaseAuth.currentUser!.uid;
//       DocumentSnapshot userDoc =
//           await _fireStore.collection('Users').doc(currentUserId).get();

//       // Fetch agency information
//       DocumentSnapshot agencyDoc =
//           await _fireStore.collection('Agencies').doc(widget.agencyId).get();

//       // Fetch property information
//       DocumentSnapshot propertyDoc = await _fireStore
//           .collection('items')
//           .doc(widget.agencyId)
//           .collection('item_List')
//           .doc(widget.propertyId)
//           .get();

//       setState(() {
//         // Set sender name based on who initiated the chat
//         senderName = widget.isUserInitiating
//             ? userDoc.get('Name')
//             : agencyDoc.get('Name');

//         // Set receiver name based on who initiated the chat
//         receiverName = widget.isUserInitiating
//             ? agencyDoc.get('Name')
//             : userDoc.get('Name');

//         // Set property name
//         propertyName = propertyDoc.get('name');
//       });
//     } catch (e) {
//       print("Error fetching chat participant info: $e");
//     }
//   }

//   // Generate unique chat room ID
//   String _generateChatRoomId() {
//     String currentUserId = _firebaseAuth.currentUser!.uid;
//     List<String> ids = [currentUserId, widget.agencyId];
//     ids.sort();
//     return "${ids[0]}_${ids[1]}_${widget.propertyId}";
//   }

//   // Send message to Firestore
//   Future<void> _sendMessage() async {
//     if (_messageController.text.isEmpty) return;

//     try {
//       final currentUser = _firebaseAuth.currentUser;
//       if (currentUser == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Please log in to send messages')),
//         );
//         return;
//       }

//       // Prepare message data
//       final messageData = {
//         'senderId': currentUser.uid,
//         'senderName': senderName ?? 'Unknown Sender',
//         'receiverId': widget.agencyId,
//         'receiverName': receiverName ?? 'Unknown Receiver',
//         'message': _messageController.text.trim(),
//         'timestamp': Timestamp.now(),
//         'propertyId': widget.propertyId,
//         'propertyName': propertyName ?? 'Unknown Property',
//         'isUserMessage': widget.isUserInitiating,
//       };

//       // Generate unique chat room ID
//       final chatRoomId = _generateChatRoomId();

//       // Save message to Firestore
//       await _fireStore
//           .collection("ChatRooms")
//           .doc(chatRoomId)
//           .collection("Messages")
//           .add(messageData);

//       // Clear message input
//       _messageController.clear();
//     } catch (e) {
//       print("Error sending message: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to send message. Please try again.')),
//       );
//     }
//   }

//   // Fetch messages for this specific chat room
//   Stream<QuerySnapshot> _getMessages() {
//     final chatRoomId = _generateChatRoomId();

//     return _fireStore
//         .collection("ChatRooms")
//         .doc(chatRoomId)
//         .collection("Messages")
//         .orderBy("timestamp", descending: false)
//         .snapshots();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           receiverName != null && propertyName != null
//               ? '$receiverName - $propertyName'
//               : 'Property Chat',
//           style: TextStyle(color: myColor.textcolor),
//         ),
//         backgroundColor: myColor.background,
//       ),
//       body: Column(
//         children: [
//           Expanded(child: _buildMessageList()),
//           _buildMessageInput(),
//         ],
//       ),
//     );
//   }

//   // Build message list
//   Widget _buildMessageList() {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _getMessages(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Center(child: Text("Error: ${snapshot.error}"));
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }

//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return Center(child: Text("No messages yet."));
//         }

//         return ListView(
//           children: snapshot.data!.docs
//               .map((document) => _buildMessageItem(document))
//               .toList(),
//         );
//       },
//     );
//   }

//   // Build individual message item
//   Widget _buildMessageItem(DocumentSnapshot document) {
//     Map<String, dynamic> data = document.data() as Map<String, dynamic>;

//     // Determine if the message is from the current user
//     bool isCurrentUser = data['senderId'] == _firebaseAuth.currentUser!.uid;

//     return Align(
//       alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//         padding: EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: isCurrentUser ? Colors.blue[100] : Colors.grey[300],
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Column(
//           crossAxisAlignment:
//               isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//           children: [
//             Text(
//               isCurrentUser ? "You" : data['senderName'],
//               style: TextStyle(
//                   fontWeight: FontWeight.bold, color: myColor.textcolor),
//             ),
//             SizedBox(height: 5),
//             Text(data['message']),
//             if (data['propertyName'] != null) ...[
//               SizedBox(height: 5),
//             ],
//           ],
//         ),
//       ),
//     );
//   }

//   // Build message input field
//   Widget _buildMessageInput() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: CustomTextField(
//               borderColor: myColor.textcolor,
//               controller: _messageController,
//               textColor: Colors.black,
//               hintText: 'Enter your message',
//             ),
//           ),
//           IconButton(
//             onPressed: _sendMessage,
//             icon: Icon(Icons.send, color: myColor.textcolor),
//           ),
//         ],
//       ),
//     );
//   }
// }

// *****************************************************************************************************************


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/widgets/custom_textfield.dart';

class UserAgencyChat extends StatefulWidget {
  var agencyId;
  final String propertyId;
  final bool isUserInitiating;

  UserAgencyChat({
    super.key,
    required this.agencyId,
    required this.propertyId,
    this.isUserInitiating = true,
  });

  @override
  State<UserAgencyChat> createState() => _UserAgencyChatState();
}

class _UserAgencyChatState extends State<UserAgencyChat> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String? senderName;
  String? receiverName;
  String? propertyName;

  @override
  void initState() {
    super.initState();
    _fetchChatParticipantsInfo();
  }

  Future<void> _fetchChatParticipantsInfo() async {
    try {
      String currentUserId = _firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc = await _fireStore
          .collection('Users')
          .doc(currentUserId)
          .get();

      DocumentSnapshot agencyDoc = await _fireStore
          .collection('Agencies')
          .doc(widget.agencyId)
          .get();

      DocumentSnapshot propertyDoc = await _fireStore
          .collection('items')
          .doc(widget.agencyId)
          .collection('item_List')
          .doc(widget.propertyId)
          .get();

      setState(() {
        senderName = widget.isUserInitiating 
            ? userDoc.get('Name') 
            : agencyDoc.get('Name');
        
        receiverName = widget.isUserInitiating 
            ? agencyDoc.get('Name') 
            : userDoc.get('Name');
        
        propertyName = propertyDoc.get('name');
      });
    } catch (e) {
      print("Error fetching chat participant info: $e");
    }
  }

  String _generateChatRoomId() {
    String currentUserId = _firebaseAuth.currentUser!.uid;
    List<String> ids = [currentUserId, widget.agencyId];
    ids.sort();
    return "${ids[0]}_${ids[1]}";
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.isEmpty) return;

    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please log in to send messages')),
        );
        return;
      }

      final now = Timestamp.now();
      final formattedTime = DateFormat('HH:mm a').format(now.toDate());

      final messageData = {
        'senderId': currentUser.uid,
        'senderName': senderName ?? 'Unknown Sender',
        'receiverId': widget.agencyId,
        'receiverName': receiverName ?? 'Unknown Receiver',
        'message': _messageController.text.trim(),
        'timestamp': now,
        'formattedTime': formattedTime,
        'propertyId': widget.propertyId,
        'propertyName': propertyName ?? 'Unknown Property',
        'participants': [currentUser.uid, widget.agencyId],
        'isUserMessage': widget.isUserInitiating,
      };

      final chatRoomId = _generateChatRoomId();

      await _fireStore
          .collection("ChatRooms")
          .doc(chatRoomId)
          .collection("Messages")
          .add(messageData);

      _messageController.clear();
    } catch (e) {
      print("Error sending message: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send message. Please try again.')),
      );
    }
  }

  Stream<QuerySnapshot> _getMessages() {
    final chatRoomId = _generateChatRoomId();

    return _fireStore
        .collection("ChatRooms")
        .doc(chatRoomId)
        .collection("Messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          receiverName != null && propertyName != null
              ? '$receiverName - $propertyName'
              : 'Property Chat',
          style: TextStyle(color: myColor.textcolor),
        ),
        backgroundColor: myColor.background,
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _getMessages(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("No messages yet."));
        }

        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    
    bool isCurrentUser = data['senderId'] == _firebaseAuth.currentUser!.uid;

    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isCurrentUser ? Colors.blue[100] : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: 
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              isCurrentUser ? "You" : data['senderName'],
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                color: myColor.textcolor
              ),
            ),
            SizedBox(height: 5),
            Text(data['message']),
            SizedBox(height: 5),
            Text(
              data['formattedTime'] ?? '',
              style: TextStyle(color: Colors.grey, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
              borderColor: myColor.textcolor,
              controller: _messageController,
              textColor: Colors.black,
              hintText: 'Enter your message',
            ),
          ),
          IconButton(
            onPressed: _sendMessage,
            icon: Icon(Icons.send, color: myColor.textcolor),
          ),
        ],
      ),
    );
  }
}
