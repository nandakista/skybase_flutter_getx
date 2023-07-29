import 'package:skybase/domain/entities/user/user.dart';

class UserModel extends User {
  UserModel({
    int? id,
    String? token,
    String? refreshToken,
    String? username,
    String? name,
    String? location,
    String? company,
    String? gitUrl,
    String? bio,
    String? avatarUrl,
    int? repository,
    int? followers,
    int? following,
  }) : super(
          id: id,
          token: token,
          refreshToken: refreshToken,
          username: username,
          name: name,
          location: location,
          company: company,
          gitUrl: gitUrl,
          bio: bio,
          avatarUrl: avatarUrl,
          repository: repository,
          followers: followers,
          following: following,
        );

  factory UserModel.fromJson(Map<dynamic, dynamic> json) {
    return UserModel(
      id: json['id'],
      token: json['token'],
      refreshToken: json['refresh_token'],
      username: json['login'],
      name: json['name'],
      location: json['location'],
      company: json['company'],
      gitUrl: json['html_url'],
      bio: json['bio'],
      avatarUrl: json['avatar_url'],
      repository: json['public_repos'],
      followers: json['followers'],
      following: json['following'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'token': token,
        'refresh_token': refreshToken,
        'login': username,
        'name': name,
        'location': location,
        'company': company,
        'html_url': gitUrl,
        'bio': bio,
        'avatar_url': avatarUrl,
        'public_repos': repository,
        'followers': followers,
        'following': following,
      };
}
