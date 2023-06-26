import 'package:skybase/data/models/user/user.dart';

enum AppType { initial, firstInstall, unauthenticated, authenticated }

class AuthState {
  final User? user;
  final AppType appStatus;

  const AuthState({this.user, this.appStatus = AppType.initial});

  AuthState copyWith({
    User? user,
    AppType? appStatus,
  }) {
    return AuthState(
      user: user ?? this.user,
      appStatus: appStatus ?? this.appStatus,
    );
  }
}
