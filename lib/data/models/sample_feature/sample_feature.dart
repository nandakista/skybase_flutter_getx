import 'package:hive/hive.dart';
import 'package:skybase/core/database/hive/entity/user_entity.dart';
import 'package:skybase/core/database/hive/hive_adapters.dart';
import 'package:skybase/core/database/hive/hive_box.dart';
import 'package:skybase/data/models/repo/repo.dart';

part 'sample_feature.g.dart';

@HiveType(typeId: HiveBox.userId, adapterName: HiveAdapters.person)
class SampleFeature {
  @HiveField(UserEntity.id)
  int id;

  @HiveField(UserEntity.username)
  String username;

  @HiveField(UserEntity.name)
  String? name;

  @HiveField(UserEntity.location)
  String? location;

  @HiveField(UserEntity.company)
  String? company;

  @HiveField(UserEntity.gitUrl)
  String? gitUrl;

  @HiveField(UserEntity.bio)
  String? bio;

  @HiveField(UserEntity.avatarUrl)
  String? avatarUrl;

  @HiveField(UserEntity.repository)
  int? repository;

  @HiveField(UserEntity.followers)
  int? followers;

  @HiveField(UserEntity.following)
  int? following;

  @HiveField(UserEntity.repositoryList)
  List<Repo>? repositoryList;

  @HiveField(UserEntity.followersList)
  List<SampleFeature>? followersList;

  @HiveField(UserEntity.followingList)
  List<SampleFeature>? followingList;


  SampleFeature({
    required this.id,
    required this.username,
    this.name,
    this.location,
    this.company,
    this.gitUrl,
    this.bio,
    this.avatarUrl,
    this.repository,
    this.followers,
    this.following,
    this.repositoryList,
    this.followersList,
    this.followingList,
  });

  factory SampleFeature.fromJson(Map<dynamic, dynamic> json) {
    return SampleFeature(
      id: json['id'],
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
      repositoryList: (json['repository_list'])
          ?.map((e) => Repo.fromJson(e as Map<String, dynamic>))
          .toList(),
      followersList: (json['followers_list'])
          ?.map((e) => SampleFeature.fromJson(e as Map<String, dynamic>))
          .toList(),
      followingList: (json['following_list'])
          ?.map((e) => SampleFeature.fromJson(e as Map<String, dynamic>))
          .toList(),
      // token: json['token'],
      // refreshToken: json['refresh_token'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
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
        'repository_list': repositoryList,
        'following_list': followingList,
        'followers_list': followersList,
        // 'token': token,
        // 'refresh_token': refreshToken,
      };
}
