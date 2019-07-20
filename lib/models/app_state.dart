import 'package:meta/meta.dart';

@immutable
class AppState {
  final dynamic token;
  final List<dynamic> howtos;

  AppState({@required this.token, @required this.howtos});

//below will set the default value
  factory AppState.initial() {
    return AppState(token: null, howtos: []);
  }
}
