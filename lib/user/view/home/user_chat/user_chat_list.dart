// // import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:hommie/model/utils/style/color.dart';
// import 'package:hommie/model/utils/style/img_path.dart';
// import 'package:hommie/user/view/home/user_chat/user_chat.dart';
// import 'package:hommie/widgets/appbar.dart';
// import 'package:hommie/widgets/custom_card.dart';

// class UserChatList extends StatefulWidget {
//   const UserChatList({super.key});

//   @override
//   State<UserChatList> createState() => _UserChatListState();
// }

// class _UserChatListState extends State<UserChatList> {
//   final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: myColor.background,
//       appBar: CustomAppBar(title: "Chats"),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _fetchUniqueChatRooms(),
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

//           // Create a map to store unique conversations
//           Map<String, DocumentSnapshot> uniqueChats = {};
          
//           // Group messages by unique agency-property combinations
//           for (var doc in snapshot.data!.docs) {
//             Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//             String key = '${data['receiverId']}_${data['propertyId']}';
            
//             // Only keep the most recent message for each unique conversation
//             if (!uniqueChats.containsKey(key) || 
//                 (data['timestamp'] as Timestamp).compareTo(
//                     (uniqueChats[key]!.data() as Map<String, dynamic>)['timestamp']
//                 ) > 0) {
//               uniqueChats[key] = doc;
//             }
//           }

//           // Convert the map values to a list for ListView
//           List<DocumentSnapshot> uniqueChatsList = uniqueChats.values.toList();
          
//           return ListView.builder(
//             itemCount: uniqueChatsList.length,
//             itemBuilder: (context, index) {
//               DocumentSnapshot document = uniqueChatsList[index];
//               Map<String, dynamic> data = document.data() as Map<String, dynamic>;

//               String agencyId = data['receiverId'];
//               String propertyId = data['propertyId'];
//               bool isUserInitiating = data['isUserMessage'];

//               return Padding(
//                 padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
//                 child: CustomCard(
//                   child: ListTile(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => UserAgencyChat(
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
//                     title: Text(
//                       isUserInitiating ? data['receiverName'] : data['senderName'],
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: myColor.textcolor,
//                       ),
//                     ),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(data['propertyName']),
//                         Text(
//                           data['message'],
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                       ],
//                     ),
//                     trailing: Text(
//                       data['formattedTime'] ?? '',
//                       style: TextStyle(color: Colors.grey, fontSize: 12),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   Stream<QuerySnapshot> _fetchUniqueChatRooms() {
//     String currentUserId = _firebaseAuth.currentUser!.uid;
    
//     return _fireStore
//         .collectionGroup('Messages')
//         .where('participants', arrayContains: currentUserId)
//         .orderBy('timestamp', descending: true)
//         .snapshots()
//         .handleError((error) {
//       print("Error fetching chat rooms: $error");
//     });
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/user/view/home/user_chat/user_chat.dart';
import 'package:intl/intl.dart';

class ChatListScreen extends StatelessWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat List', style: TextStyle(color: myColor.textcolor)),
        backgroundColor: myColor.background,
      ),
      body: _buildChatList(),
    );
  }

  Widget _buildChatList() {
    final currentUserId = _firebaseAuth.currentUser?.uid;

    if (currentUserId == null) {
      return Center(
        child: Text('Please log in to view chats.'),
      );
    }

    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore
          .collectionGroup('Messages')
          .where('participants', arrayContains: currentUserId)
          .orderBy('lastMessageTime', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("No chats available."));
        }

        return ListView(
          children: snapshot.data!.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return _buildChatListTile(context, data, doc.id);
          }).toList(),
        );
      },
    );
  }

  Widget _buildChatListTile(
      BuildContext context, Map<String, dynamic> chatData, String chatRoomId) {
    final currentUserId = _firebaseAuth.currentUser!.uid;
    final bool isCurrentUserInitiator = chatData['participants'][0] == currentUserId;
    final String otherParticipantId = isCurrentUserInitiator
        ? chatData['participants'][1]
        : chatData['participants'][0];
    final String lastMessage = chatData['lastMessage'] ?? 'No messages yet';
    final String propertyName = chatData['propertyName'] ?? 'Property Chat';

    return FutureBuilder<DocumentSnapshot>(
      future: _fireStore.collection('Users').doc(otherParticipantId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return SizedBox();

        final receiverName = snapshot.data!.get('Name') ?? 'Unknown User';

        return ListTile(
          title: Text(receiverName),
          subtitle: Text(lastMessage),
          trailing: Text(
            DateFormat('HH:mm a').format(
              (chatData['lastMessageTime'] as Timestamp).toDate(),
            ),
            style: TextStyle(color: Colors.grey),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserAgencyChat(
                  agencyId: otherParticipantId,
                  propertyId: chatData['propertyId'],
                  isUserInitiating: isCurrentUserInitiator,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
