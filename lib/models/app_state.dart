import 'package:meta/meta.dart';

@immutable
class AppState {
  final dynamic token;

  AppState({@required this.token});

  factory AppState.initial() {
    return AppState(token: null);
  }
}
