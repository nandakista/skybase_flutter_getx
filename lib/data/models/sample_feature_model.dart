import 'package:skybase/data/models/repo_model.dart';
import 'package:skybase/domain/entities/repo/repo.dart';
import 'package:skybase/domain/entities/sample_feature/sample_feature.dart';

class SampleFeatureModel extends SampleFeature {
  SampleFeatureModel({
    required int id,
    required String username,
    String? name,
    String? location,
    String? company,
    String? gitUrl,
    String? bio,
    String? avatarUrl,
    int? repository,
    int? followers,
    int? following,
    List<Repo>? repositoryList,
    List<SampleFeature>? followersList,
    List<SampleFeature>? followingList,
  }) : super(
          id: id,
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
          repositoryList: repositoryList,
          followersList: followersList,
          followingList: followingList,
        );

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
      repositoryList: (json['repository_list'])
          ?.map((e) => RepoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      followersList: (json['followers_list'])
          ?.map((e) => SampleFeatureModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      followingList: (json['following_list'])
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
        'repository_list': repositoryList,
        'following_list': followingList,
        'followers_list': followersList,
        // 'token': token,
        // 'refresh_token': refreshToken,
      };
}
