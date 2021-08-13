import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  static const chat_collection = 'chat';

  @override
  Widget build(BuildContext context) {
    //final _auth = FirebaseAuth.instance;
    final _fireStore = FirebaseFirestore.instance;

    return StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection(chat_collection).snapshots(),
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
              return Text(_message['text']);
            },
          );
        });
  }
}
