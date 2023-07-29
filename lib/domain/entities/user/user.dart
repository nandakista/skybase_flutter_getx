import 'package:skybase/data/models/user.dart';

class User {
  int? id;
  String? token;
  String? refreshToken;

  User({
    this.id,
    this.token,
    this.refreshToken,
  });

  UserModel toModel() {
    return UserModel(
      id: id,
      token: token,
      refreshToken: refreshToken,
    );
  }
}
