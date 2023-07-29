import 'package:skybase/data/models/user.dart';

class User {
  int? id;
  String? token;
  String? refreshToken;
  String? username;
  String? name;
  String? location;
  String? company;
  String? gitUrl;
  String? bio;
  String? avatarUrl;
  int? repository;
  int? followers;
  int? following;

  User({
    this.id,
    this.token,
    this.refreshToken,
    this.username,
    this.name,
    this.location,
    this.company,
    this.gitUrl,
    this.bio,
    this.avatarUrl,
    this.repository,
    this.followers,
    this.following,
  });

  UserModel toModel() {
    return UserModel(
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
  }
}
