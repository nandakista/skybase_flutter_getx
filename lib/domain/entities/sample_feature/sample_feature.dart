import 'package:skybase/data/models/sample_feature_model.dart';
import 'package:skybase/domain/entities/repo/repo.dart';

class SampleFeature {
  int id;
  String username;
  String? name;
  String? location;
  String? company;
  String? gitUrl;
  String? bio;
  String? avatarUrl;
  int? repository;
  int? followers;
  int? following;
  List<Repo>? repositoryList;
  List<SampleFeature>? followersList;
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

  SampleFeatureModel toModel() {
    return SampleFeatureModel(
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
      repositoryList: repositoryList?.map((e) => e.toModel()).toList(),
      followersList: followersList?.map((e) => e.toModel()).toList(),
      followingList: followingList?.map((e) => e.toModel()).toList(),
    );
  }
}
