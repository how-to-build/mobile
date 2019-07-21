import 'package:flutter/material.dart';

class Token with ChangeNotifier {
  String _token;

  Token(this._token);

  getToken() => _token;
  setToken(String token) => _token = token;

}