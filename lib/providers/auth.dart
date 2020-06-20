import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterwebinar/utils/http_exception.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;
  String _username;

  String get token {
    return _token;
  }

  String get username {
    return _username;
  }

  bool get isAuth {
    return token != null;
  }

  Future<void> login(Map<String, String> data) async {
    final url = 'https://api-linking.herokuapp.com/users/login';
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        final resBody = json.decode(response.body);
        _token = 'JWT ' + resBody['token'];
        final prefs = await SharedPreferences.getInstance();
        final _prefsData = json.encode({
          'token': _token,
          'username': _username,
        });
        await prefs.setString('userData', _prefsData);
        notifyListeners();
      } else {
        throw HttpException('Login Failed');
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> register(Map<String, String> data) async {
    final url = 'https://api-linking.herokuapp.com/users';
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 201) {
      } else {
        throw HttpException('Signup could not be completed');
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    _token = extractedUserData['token'];
    _username = extractedUserData['username'];
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _token = null;
    _username = null;
    notifyListeners();
  }
}
