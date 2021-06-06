import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'api_key.dart';

class Auth with ChangeNotifier {
  static const firebaseHostName = 'identitytoolkit.googleapis.com';

  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> signup(String email, String password) async {
    final url = Uri.https(
      firebaseHostName,
      'v1/accounts:signUp',
      {'key': API_KEY},
    );

    final response = await http.post(
      url,
      body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    print('response: $extractedData');
  }
}
