import 'package:meta/meta.dart';

@immutable
class AppState {
  final dynamic token;
  final List<dynamic> howtos;
  final String username;
  final Map<String, dynamic> userObject;

  AppState(
      {@required this.token,
      @required this.howtos,
      @required this.username,
      @required this.userObject});

//below will set the default value
  factory AppState.initial() {
    return AppState(token: null, howtos: [], username: null, userObject: null);
  }
}
