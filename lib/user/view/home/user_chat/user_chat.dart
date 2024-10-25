import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/widgets/custom_textfield.dart';

class UserChat extends StatefulWidget {
  final  agencyId;
  final String propertyId; // New property ID to distinguish between properties

  const UserChat({super.key, required this.agencyId, required this.propertyId});

  @override
  State<UserChat> createState() => _UserChatState();
}

class _UserChatState extends State<UserChat> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String? agencyName;
  String? propertyName;
  String? userName;











Future<void> fetchAgencyAndPropertyNames() async {
  try {
    // Fetch agency name
    DocumentSnapshot agencyDoc =
        await _fireStore.collection('Agencies').doc(widget.agencyId).get();
    if (agencyDoc.exists) {
      setState(() {
        agencyName = agencyDoc.get('Name');
        print("Agency Name : $agencyName");
      });
    }

    // Fetch property name directly from the agency's item_List
    DocumentSnapshot propertyDoc = await _fireStore
        .collection('items')
        .doc(widget.agencyId)
        .collection('item_List')
        .doc(widget.propertyId)
        .get();

    if (propertyDoc.exists) {
      setState(() {
       
        propertyName = propertyDoc.get("name");
         print(widget.agencyId);
        print(widget.propertyId);
        print(propertyName);
      });
    } else {
      //  print(widget.agencyId);
      //   print(widget.propertyId);
      print("Property not found");
    }

    // Fetch user name
    String currentUserId = _firebaseAuth.currentUser!.uid;
    print(currentUserId);
    DocumentSnapshot userDoc =
        await _fireStore.collection('Users').doc(currentUserId).get();
    if (userDoc.exists) {
      setState(() {
        userName = userDoc.get('name');
      });
    }
  } catch (e) {
    print("Error fetching data: $e");
  }
}

  @override
  void initState() {
    super.initState();
    
    fetchAgencyAndPropertyNames();
  }

  // Send message to the Firestore
Future<void> sendMessage() async {
  if (_messageController.text.isEmpty) return;

  try {
    // 1. Get current user
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      print("Error: No user logged in");
      return;
    }

    // 2. Get required user data
    final currentUserId = currentUser.uid;
    print(currentUser);
    print(currentUserId);
    final currentUserEmail = currentUser.email ?? '';

    // 3. Fetch user name if not already available
    String? userNameToUse = userName;
    if (userNameToUse == null) {
      final userDoc = await _fireStore.collection('Users').doc(currentUserId).get();
      if (userDoc.exists) {
        userNameToUse = userDoc.get('name');
      }
    }

    // 4. Fetch property name if not already available
    String? propertyNameToUse = propertyName;
    if (propertyNameToUse == null) {
      // First try to get from Agencies collection
      final propertyDoc = await _fireStore
          .collection('Agencies')
          .doc(widget.agencyId)
          .collection('item_List')
          .doc(widget.propertyId)
          .get();

      if (propertyDoc.exists) {
        propertyNameToUse = propertyDoc.get('name');
      }
    }

    // 5. Create chat room ID
    final chatRoomId = "${widget.agencyId}_${widget.propertyId}";

    // 6. Create message data
    final messageData = {
      'senderId': currentUserId,
      'senderEmail': currentUserEmail,
      'senderName': userNameToUse ?? 'Unknown User',
      'receiverId': widget.agencyId,
      'message': _messageController.text.trim(),
      'timestamp': Timestamp.now(),
      'propertyId': widget.propertyId,
      'propertyName': propertyNameToUse ?? 'Unknown Property',
    };

    // 7. Save to Firestore
    await _fireStore
        .collection("ChatRooms")
        .doc(chatRoomId)
        .collection("Messages")
        .add(messageData);

    // 8. Clear the input field
    _messageController.clear();

  } catch (e) {
    print("Error sending message: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to send message. Please try again.')),
    );
  }
}
  // Fetch messages between user and agency for a specific property
  Stream<QuerySnapshot> getMessages() {
    String chatRoomId = "${widget.agencyId}_${widget.propertyId}";

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
        title: Text(agencyName != null && propertyName != null
            ? '$agencyName - $propertyName'
            : 'Property Chat'),
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

  // Message list UI
  Widget _buildMessageList() {
    return StreamBuilder<QuerySnapshot>(
      stream: getMessages(),
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

  // Individual message item UI
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
              isCurrentUser ? "You" : data['senderName'] ?? 'Agency',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: myColor.textcolor),
            ),
            SizedBox(height: 5),
            Text(data['message']),
            if (data['propertyName'] != null) ...[
              SizedBox(height: 5),
              Text('Property: ${data['propertyName']}', style: TextStyle(color: Colors.grey)),
            ],
          ],
        ),
      ),
    );
  }

  // Message input UI
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
            onPressed: sendMessage,
            icon: Icon(Icons.send, color: myColor.textcolor),
          ),
        ],
      ),
    );
  }
}






  // String? agencyName;
  // String? propertyName;

  // // Fetch agency name and property name from Firestore
  // Future<void> fetchAgencyAndPropertyNames() async {
  //   // Fetch agency name
  //   DocumentSnapshot agencyDoc = await _fireStore
  //       .collection('Agencies')
  //       .doc(widget.agencyId)
  //       .get();

  //   if (agencyDoc.exists) {
  //     setState(() {
  //       agencyName = agencyDoc.get("Name");
  //     });
  //   }

  //   // Fetch property name
  //   DocumentSnapshot propertyDoc = await _fireStore
  //       .collection('Properties') // Assuming you have a collection for properties
  //       .doc(widget.propertyId)
  //       .get();

  //   if (propertyDoc.exists) {
  //     setState(() {
  //       propertyName = propertyDoc.get("Name");
  //       print(propertyName);
  //     });
  //   }
  // }


// *******************************************************************************
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:hommie/model/utils/style/color.dart';
// import 'package:hommie/widgets/custom_textfield.dart';

// class UserChat extends StatefulWidget {
//   final  agencyId;

//   const UserChat({super.key, required this.agencyId,});

//   @override
//   State<UserChat> createState() => _UserChatState();
// }

// class _UserChatState extends State<UserChat> {
//   final TextEditingController _messageController = TextEditingController();
//   final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   String? agencyName;

//   // Fetch agency name from Firestore
//   Future<void> fetchAgencyName() async {
//     DocumentSnapshot agencyDoc = await _fireStore
//         .collection('Agencies')
//         .doc(widget.agencyId)
//         .get();

//     if (agencyDoc.exists) {
//       setState(() {
//         agencyName = agencyDoc.get("Name");
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchAgencyName();
//   }

//   // Send message to the Firestore
//   Future<void> sendMessage() async {
//     if (_messageController.text.isNotEmpty) {
//       String currentUserId = _firebaseAuth.currentUser!.uid;
//       String currentUserEmail = _firebaseAuth.currentUser!.email ?? '';
//       String message = _messageController.text.trim();

//       Timestamp timestamp = Timestamp.now();
//       List<String> ids = [currentUserId, widget.agencyId];
//       ids.sort();
//       String chatRoomId = ids.join("_");

//       // Create message map
//       Map<String, dynamic> messageData = {
//         'senderId': currentUserId,
//         'senderEmail': currentUserEmail,
//         'receiverId': widget.agencyId,
//         'message': message,
//         'timestamp': timestamp,
//       };

//       // Save message in Firestore
//       await _fireStore
//           .collection("ChatRooms")
//           .doc(chatRoomId)
//           .collection("Messages")
//           .add(messageData);

//       _messageController.clear();
//     }
//   }

//   // Fetch messages between user and agency
//   Stream<QuerySnapshot> getMessages() {
//     String currentUserId = _firebaseAuth.currentUser!.uid;
//     List<String> ids = [currentUserId, widget.agencyId];
//     ids.sort();
//     String chatRoomId = ids.join("_");

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
//         title: Text(agencyName ?? 'Agency Chat'),
//         backgroundColor: Colors.white,
//       ),
//       body: Column(
//         children: [
//           Expanded(child: _buildMessageList()),
//           _buildMessageInput(),
//         ],
//       ),
//     );
//   }

//   // Message list UI
//   Widget _buildMessageList() {
//     return StreamBuilder<QuerySnapshot>(
//       stream: getMessages(),
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

//   // Individual message item UI
//   Widget _buildMessageItem(DocumentSnapshot document) {
//     Map<String, dynamic> data = document.data() as Map<String, dynamic>;
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
//               isCurrentUser ? "You" : agencyName ?? 'Agency',
//               style: TextStyle(
//                   fontWeight: FontWeight.bold, color: myColor.textcolor),
//             ),
//             SizedBox(height: 5),
//             Text(data['message']),
//           ],
//         ),
//       ),
//     );
//   }

//   // Message input UI
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
//             onPressed: sendMessage,
//             icon: Icon(Icons.send, color: myColor.textcolor),
//           ),
//         ],
//       ),
//     );
//   }
// }









// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:hommie/model/utils/style/color.dart';
// import 'package:hommie/user/chat/chat_service.dart';
// import 'package:hommie/widgets/custom_textfield.dart';

// class UserChat extends StatefulWidget {
//   final  agencyid;

//   const UserChat({super.key, required this.agencyid});

//   @override
//   State<UserChat> createState() => _UserChatState();
// }

// class _UserChatState extends State<UserChat> {
//   String? agencyName;
//   final _messageController = TextEditingController();
//   final ChatService _chatService = ChatService();
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // @override
  // void initState() {
  //   super.initState();
  //   fetchAgencyName();
  // }

  // Future<void> fetchAgencyName() async {
  //   DocumentSnapshot agencyDoc = await FirebaseFirestore.instance
  //       .collection('Agencies')
  //       .doc(widget.agencyid)
  //       .get();

  //   if (agencyDoc.exists) {
  //     setState(() {
  //       agencyName = agencyDoc.get("Name");
  //     });
  //   }
  // }

//   void sendMessage() async {
//     if (_messageController.text.isNotEmpty) {
//       await _chatService.sendMessage(widget.agencyid, _messageController.text);
//       _messageController.clear();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(agencyName ?? "Agency Chat"),
//       ),
//       body: Column(
//         children: [
//           Expanded(child: _buildMessageList()),

//           // User input
//           _buildMessageInput(),
//         ],
//       ),
//     );
//   }

//   Widget _buildMessageList() {
//     return StreamBuilder(
//       stream: _chatService.getMessages(_firebaseAuth.currentUser!.uid, widget.agencyid),
//       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Center(child: Text("Error: ${snapshot.error}"));
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }
//         return ListView(
//           children: snapshot.data!.docs.map((document) => _buildMessageItem(document)).toList(),
//         );
//       },
//     );
//   }

//   Widget _buildMessageItem(DocumentSnapshot document) {
//     Map<String, dynamic> data = document.data() as Map<String, dynamic>;
//     bool isCurrentUser = data['senderId'] == _firebaseAuth.currentUser!.uid;
    

//     var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
//     var messageColor = isCurrentUser ? Colors.blue[100] : Colors.grey[300];

//     return Container(
//       alignment: alignment,
//       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//       child: Container(
//         padding: EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: messageColor,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Column(
//           crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//           children: [
//             Text(data['message']),
//             SizedBox(height: 5),
//             Text(
//               data['senderEmail'],
//               style: TextStyle(fontSize: 12, color: Colors.grey),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Build message input field
//   Widget _buildMessageInput() {
//     return Row(
//       children: [
//         Expanded(
//           child: CustomTextField(
//             borderColor: myColor.textcolor,
//             controller: _messageController,
//             textColor: Colors.black,
//           ),
//         ),
//         IconButton(
//           onPressed: sendMessage,
//           icon: Icon(Icons.arrow_upward),
//         ),
//       ],
//     );
//   }
// }
