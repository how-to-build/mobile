import 'package:meta/meta.dart';

@immutable
class AppState {
  final dynamic token;

  AppState({@required this.token});

//below will set the default value
  factory AppState.initial() {
    return AppState(token: null);
  }
}
