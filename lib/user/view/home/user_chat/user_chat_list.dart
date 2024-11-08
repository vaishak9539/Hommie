// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:hommie/agency/new/agency_chat.dart';
// import 'package:hommie/model/utils/style/color.dart';
// import 'package:hommie/model/utils/style/img_path.dart';
// import 'package:hommie/widgets/appbar.dart';
// import 'package:hommie/widgets/custom_card.dart';

// class ChatListScreen extends StatefulWidget {
//   const ChatListScreen({super.key});

//   @override
//   State<ChatListScreen> createState() => _ChatListScreenState();
// }

// class _ChatListScreenState extends State<ChatListScreen> {
//   final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: myColor.background,
//       appBar: CustomAppBar(title: "Chats"),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _fetchChatRooms(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Center(child: Text("Error: ${snapshot.error}"));
//           }

//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(child: Text("No chat rooms found."));
//           }

//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               DocumentSnapshot document = snapshot.data!.docs[index];
//               Map<String, dynamic> data = document.data() as Map<String, dynamic>;

//               String agencyId = data['receiverId'];
//               String propertyId = data['propertyId'];
//               bool isUserInitiating = data['isUserMessage'];

//               return Padding(
//                 padding: const EdgeInsets.only(left: 10, right: 10),
//                 child: CustomCard(
//                   child: ListTile(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => AgencyChat(
//                             agencyId: agencyId,
//                             propertyId: propertyId,
//                             isUserInitiating: isUserInitiating,
//                           ),
//                         ),
//                       );
//                     },
//                     leading: CircleAvatar(
//                       backgroundImage: AssetImage(icons[5]),
//                     ),
//                     title: Text(isUserInitiating
//                         ? data['receiverName']
//                         : data['senderName']),
//                     subtitle: Text(data['propertyName']),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   // Fetch all chat rooms where the current user is either the sender or receiver
//   Stream<QuerySnapshot> _fetchChatRooms() {
//     String currentUserId = _firebaseAuth.currentUser!.uid;

//     return _fireStore
//         .collection('ChatRooms')
//         .where('participants', arrayContains: currentUserId)
//         .snapshots()
//         .handleError((error) {
//       if (kDebugMode) {
//         print("Error fetching chat rooms: $error");
//       }
//     });
//   }
// }


import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/user/view/home/user_chat/user_chat.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/custom_card.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColor.background,
      appBar: CustomAppBar(title: "Chats"),
      body: StreamBuilder<QuerySnapshot>(
        stream: _fetchChatRooms(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No chat rooms found."));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              String agencyId = data['receiverId'];
              String propertyId = data['propertyId'];
              bool isUserInitiating = data['isUserMessage'];

              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: CustomCard(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserAgencyChat(
                            agencyId: agencyId,
                            propertyId: propertyId,
                            isUserInitiating: isUserInitiating,
                          ),
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(icons[5]),
                    ),
                    title: Text(isUserInitiating
                        ? data['receiverName']
                        : data['senderName']),
                    subtitle: Text(data['propertyName']),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Fetch all unique chat rooms where the current user is either the sender or receiver
  Stream<QuerySnapshot> _fetchChatRooms() {
    String currentUserId = _firebaseAuth.currentUser!.uid;
    log("Current User ID: $currentUserId"); // Debugging line

    return _fireStore
        .collectionGroup('Messages')
        .where('participants', arrayContains: currentUserId) // Fetch chat rooms where the user is a participant
        .snapshots()
        .handleError((error) {
      log("Error fetching chat rooms: $error");
    });
  }
}

