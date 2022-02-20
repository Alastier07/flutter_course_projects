import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:${urlSegment}?key=AIzaSyBtiKJ0X3S_v8bcNGxvnfGjN3WLdoxuE5c');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      throw error;
    }

    // print(json.decode(response.body));
  }

  Future<void> singup(String email, String password) async {
    return _authenticate(
      email,
      password,
      'signUp',
    );
  }

  Future<void> login(String email, String password) async {
    return _authenticate(
      email,
      password,
      'signInWithPassword',
    );
  }
}
