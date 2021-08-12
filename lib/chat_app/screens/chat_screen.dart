import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = '/chat';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _stream = FirebaseFirestore.instance
        .collection('/chats/kNXm2wWvslN6OuRijeYY/messages')
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _stream,
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
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     FirebaseFirestore.instance
      //         .collection('/chats/kNXm2wWvslN6OuRijeYY/messages')
      //         .snapshots()
      //         .listen((data) {
      //       data.docs.forEach((document) {
      //         print(document['text']);
      //       });
      //     });
      //   },
      // ),
    );
  }
}
