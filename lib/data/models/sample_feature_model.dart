import 'package:skybase/data/models/repo_model.dart';
import 'package:skybase/domain/entities/sample_feature/sample_feature.dart';

class SampleFeatureModel extends SampleFeature {
  SampleFeatureModel({
    required super.id,
    required super.username,
    super.name,
    super.location,
    super.company,
    super.gitUrl,
    super.bio,
    super.avatarUrl,
    super.repository,
    super.followers,
    super.following,
    List<RepoModel>? super.repositoryList,
    List<SampleFeatureModel>? super.followersList,
    List<SampleFeatureModel>? super.followingList,
  });

  factory SampleFeatureModel.fromJson(Map<dynamic, dynamic> json) {
    return SampleFeatureModel(
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
      repositoryList: (json['repository_list'] as List?)
          ?.map((e) => RepoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      followersList: (json['followers_list'] as List?)
          ?.map((e) => SampleFeatureModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      followingList: (json['following_list'] as List?)
          ?.map((e) => SampleFeatureModel.fromJson(e as Map<String, dynamic>))
          .toList(),
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
        'repository_list': List<dynamic>.from(
            repositoryList?.map((e) => e.toModel().toJson()) ?? []),
        'following_list': List<dynamic>.from(
            followingList?.map((e) => e.toModel().toJson()) ?? []),
        'followers_list': List<dynamic>.from(
            followersList?.map((e) => e.toModel().toJson()) ?? []),
      };
}
