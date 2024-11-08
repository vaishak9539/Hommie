import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hommie/agency/new/agency_chat.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/model/utils/style/img_path.dart';
import 'package:hommie/user/view/home/user_chat/user_chat.dart';
import 'package:hommie/widgets/appbar.dart';
import 'package:hommie/widgets/custom_card.dart';

class AgencyChatList extends StatefulWidget {
  const AgencyChatList({super.key});

  @override
  State<AgencyChatList> createState() => _AgencyChatListState();
}

class _AgencyChatListState extends State<AgencyChatList> {
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
              String agencyId = data['senderId'];
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
                          builder: (context) => AgencyChat(
                            userId: agencyId,
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
                        ? data['senderName']
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