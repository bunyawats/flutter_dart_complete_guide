import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  static const chat_collection = 'chat';
  static const users_collection = 'users';

  final _textController = TextEditingController();

  var _enterMessage = '';

  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  void _sendMessage() async {
    FocusScope.of(context).unfocus();

    final user = _auth.currentUser;
    final snapshot =
        await _fireStore.collection(users_collection).doc(user?.uid).get();
    final userData = snapshot.data();
    print('userData: $userData');

    _fireStore.collection(chat_collection).add({
      'text': _enterMessage,
      'createAt': Timestamp.now(),
      if (user != null) 'userId': user.uid,
      if (userData != null) 'username': userData['username'],
      if (userData != null) 'userImage': userData['image_url'],
    });
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Send a message...',
              ),
              onChanged: (value) {
                setState(() {
                  _enterMessage = value;
                });
              },
            ),
          ),
          IconButton(
            onPressed: _enterMessage.trim().isEmpty ? null : _sendMessage,
            color: Theme.of(context).primaryColor,
            icon: Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
