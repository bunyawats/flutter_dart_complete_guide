import 'package:flutter/material.dart';

import 'screens/auth_screen.dart';
import 'screens/chat_screen.dart';

void main() => runApp(ChatApp());

class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = ThemeData(
      primarySwatch: Colors.indigo,
    );

    return MaterialApp(
      title: 'Chat App',
      theme: themeData.copyWith(
        colorScheme: themeData.colorScheme.copyWith(secondary: Colors.amber),
      ),
      home: ChatScreen(),
      routes: {
        ChatScreen.routeName: (ctx) => ChatScreen(),
        AuthScreen.routeName: (ctx) => AuthScreen(),
      },
    );
  }
}
