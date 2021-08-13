import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = '/chat';

  static const collection_name = '/chats/kNXm2wWvslN6OuRijeYY/messages';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _fireStore = FirebaseFirestore.instance;
    final _auth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
        actions: <Widget>[
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 8),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                _auth.signOut();
              }
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _fireStore.collection(collection_name).snapshots(),
          builder: (ctx, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final docs = snapshot.requireData.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (ctx, index) {
                final _message = docs[index];
                return Container(
                  padding: EdgeInsets.all(8),
                  child: Text(_message['text']),
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _fireStore.collection(collection_name).add({
              'text': 'This was addes by click the button',
            });
          }),
    );
  }
}
