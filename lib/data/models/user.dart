import 'package:skybase/domain/entities/user/user.dart';

class UserModel extends User {
  UserModel({
    int? id,
    String? token,
    String? refreshToken,
  });

  factory UserModel.fromJson(Map<dynamic, dynamic> json) {
    return UserModel(
      id: json['id'],
      token: json['token'],
      refreshToken: json['refresh_token'],
    );
  }

  Map<String, dynamic> toJson() => {
    'token': token,
    'refresh_token': refreshToken,
  };
}
