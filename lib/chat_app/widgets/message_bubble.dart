import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  static const users_collection = 'users';

  final String message;
  final bool isMe;
  final String username;
  final String userImage;

  const MessageBubble(
    this.message,
    this.username,
    this.userImage,
    this.isMe, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _fireStore = FirebaseFirestore.instance;

    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
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
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 8,
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    username,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: isMe
                              ? Colors.black
                              : Theme.of(context).colorScheme.onSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
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
        ),
        Positioned(
          top: -1,
          right: !isMe ? null : 120,
          left: isMe ? null : 120,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
          ),
        ),
      ],
      clipBehavior: Clip.none,
    );
  }
}
