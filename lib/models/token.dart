import 'package:meta/meta.dart';

class Token {
  String token;

  Token({@required this.token});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(token: json['token']);
  }
}
