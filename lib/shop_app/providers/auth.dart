import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import 'api_key.dart';

class Auth with ChangeNotifier {
  static const firebaseHostName = 'identitytoolkit.googleapis.com';

  String _token;
  DateTime _expiryDate;
  String _userId;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> _authenticate(
    String email,
    String password,
    String urlSegment,
  ) async {
    final url = Uri.https(
      firebaseHostName,
      'v1/$urlSegment',
      {'key': API_KEY},
    );

    try {
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

      if (extractedData['error'] != null) {
        String errorMsg = extractedData['error']['message'];
        throw HttpException(errorMsg);
      }
      _token = extractedData['idToken'];
      _userId = extractedData['localId'];

      var seconds = int.parse(extractedData['expiresIn']);
      _expiryDate = DateTime.now().add(
        Duration(seconds: seconds),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'accounts:signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'accounts:signInWithPassword');
  }
}