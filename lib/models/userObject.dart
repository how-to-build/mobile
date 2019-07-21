import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

class UserObject {
  int id;
  String firstName;
  String lastName;
  String email;
  String username;
  String role;
  String avatar;

  UserObject(
      {@required this.id,
      @required this.firstName,
      @required this.lastName,
      @required this.email,
      @required this.username,
      @required this.role,
      @required this.avatar});

  factory UserObject.fromJson(Map<String, dynamic> json) {
    return UserObject(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        username: json['username'],
        role: json['role'],
        avatar: json['avatar']);
  }
}
