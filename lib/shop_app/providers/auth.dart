import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';
import 'api_key.dart';

class Auth with ChangeNotifier {
  static const firebaseHostName = 'identitytoolkit.googleapis.com';

  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

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

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate.toIso8601String(),
      });

      print('save userdata to shared preference');
      await prefs.setString('userData', userData);

      _autoLogout();
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

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    print('get userdata from shared preference');

    if (!prefs.containsKey('userData')) {
      return false;
    }

    final userDataString = prefs.getString('userData');

    final extractedUserData =
        json.decode(userDataString) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);
    print('expiryDate: $expiryDate');

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = expiryDate;

    _autoLogout();
    notifyListeners();

    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;

    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }

    final prefs = await SharedPreferences.getInstance();
    print('clear userdata in shared preference');
    await prefs.clear();

    notifyListeners();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }

    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
