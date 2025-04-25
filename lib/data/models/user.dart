import 'package:skybase/domain/entities/user/user.dart';

class UserModel extends User {
  UserModel({
    super.id,
    super.token,
    super.refreshToken,
    super.username,
    super.name,
    super.location,
    super.company,
    super.gitUrl,
    super.bio,
    super.avatarUrl,
    super.repository,
    super.followers,
    super.following,
  });

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
