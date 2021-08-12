import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/auth_screen.dart';
import 'screens/chat_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = ThemeData(
      primarySwatch: Colors.pink,
      backgroundColor: Colors.pink,
      buttonTheme: ButtonTheme.of(context).copyWith(
        buttonColor: Colors.pink,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(20.0),
          ),
        ),
      ),
    );

    return MaterialApp(
      title: 'Chat App',
      theme: themeData.copyWith(
        colorScheme: themeData.colorScheme.copyWith(
          secondary: Colors.deepPurple,
        ),
      ),
      home: AuthScreen(),
      routes: {
        ChatScreen.routeName: (ctx) => ChatScreen(),
        AuthScreen.routeName: (ctx) => AuthScreen(),
      },
    );
  }
}
