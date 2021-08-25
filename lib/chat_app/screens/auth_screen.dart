import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  static const users_collection = 'users';

  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  final _fireStorage = FirebaseStorage.instance;

  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    String username,
    File? userImage,
    bool isLogin,
  ) async {
    print(email);
    print(username);
    print(password);
    print(isLogin);

    UserCredential authResult;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        if (userImage != null) {
          final ref = _fireStorage
              .ref()
              .child('user_image')
              .child('${authResult.user!.uid}.png');

          final metadata = SettableMetadata(
              contentType: 'image/png',
              customMetadata: {'picked-file-path': userImage.path});

          await ref.putFile(userImage, metadata);
        }

        await _fireStore
            .collection(users_collection)
            .doc(authResult.user!.uid)
            .set(
          {
            'username': username,
            'email': email,
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      print('exception: $e');

      var message = 'An error occurred, please check your credentials!';
      message = e.message ?? message;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    } catch (e) {
      print('exception: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, _isLoading),
    );
  }
}
