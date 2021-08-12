import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/auth_screen.dart';
import 'screens/chat_screen.dart';

/// Requires that a Firestore emulator is running locally.
/// See https://firebase.flutter.dev/docs/firestore/usage#emulator-usage
bool USE_FIRESTORE_EMULATOR = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (USE_FIRESTORE_EMULATOR) {
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  }
  runApp(ChatApp());
}

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
