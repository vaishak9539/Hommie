import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hommie/model/utils/style/color.dart';
import 'package:hommie/widgets/custom_textfield.dart';

class AgencyChat extends StatefulWidget {
  var userId;
  final String propertyId;
  final bool isUserInitiating;

  AgencyChat({
    super.key,
    required this.userId,
    required this.propertyId,
    this.isUserInitiating = true,
  });

  @override
  State<AgencyChat> createState() => _AgencyChatState();
}

class _AgencyChatState extends State<AgencyChat> {
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
          .collection('Agencies')
          .doc(currentUserId)
          .get();

      DocumentSnapshot agencyDoc = await _fireStore
          .collection('Users')
          .doc(widget.userId)
          .get();

          

      DocumentSnapshot propertyDoc = await _fireStore
          .collection('items')
          .doc(widget.userId)
          .collection('item_List')
          .doc(widget.propertyId)
          .get();

      setState(() {
        senderName = widget.isUserInitiating 
            ? agencyDoc.get('Name')
            : agencyDoc.get('Name');
        
        receiverName = widget.isUserInitiating 
            ? userDoc.get('Name')
            : userDoc.get('Name');
        
        propertyName = propertyDoc.get('name');

        log("send $senderName");
        log("rec $receiverName");
        log("pro $propertyName");
      });
    } catch (e) {
      print("Error fetching chat participant info: $e");
    }
  }

  String _generateChatRoomId() {
    String currentUserId = _firebaseAuth.currentUser!.uid;
    List<String> ids = [currentUserId, widget.userId];
    ids.sort();
    return "${ids[0]}_${ids[1]}_${widget.propertyId}";
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
        'receiverId': widget.userId,
        'receiverName': receiverName ?? 'Unknown Receiver',
        'message': _messageController.text.trim(),
        'timestamp': now,
        'formattedTime': formattedTime,
        'propertyId': widget.propertyId,
        'propertyName': propertyName ?? 'Unknown Property',
        'participants': [currentUser.uid, widget.userId],
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