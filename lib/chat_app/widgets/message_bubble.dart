import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  static const users_collection = 'users';

  final String message;
  final bool isMe;
  final String userId;

  const MessageBubble(
    this.message,
    this.userId,
    this.isMe, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _fireStore = FirebaseFirestore.instance;
    var _users = _fireStore.collection(users_collection);

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe
                ? Colors.grey[300]
                : Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
              bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
            ),
          ),
          width: 140,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              FutureBuilder<DocumentSnapshot>(
                  future: _users.doc(userId).get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something went wrong");
                    }
                    if (snapshot.hasData && !snapshot.data!.exists) {
                      return Text("User name does not exist");
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading...");
                    }

                    var data = snapshot.data!.data() as Map<String, dynamic>;
                    return Text(
                      data['username'],
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: isMe
                                ? Colors.black
                                : Theme.of(context).colorScheme.onSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                    );
                  }),
              Text(
                message,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: isMe
                          ? Colors.black
                          : Theme.of(context).colorScheme.onSecondary,
                    ),
                textAlign: isMe ? TextAlign.end : TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
