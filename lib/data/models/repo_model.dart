import 'package:skybase/data/models/sample_feature_model.dart';
import 'package:skybase/domain/entities/repo/repo.dart';

class RepoModel extends Repo {
  RepoModel({
    required String name,
    required SampleFeatureModel owner,
    String? description,
    String? language,
    int? totalWatch,
    int? totalFork,
    int? totalStar,
  }) : super(
          name: name,
          owner: owner,
          description: description,
          language: language,
          totalWatch: totalWatch,
          totalFork: totalFork,
          totalStar: totalStar,
        );

  factory RepoModel.fromJson(Map<dynamic, dynamic> json) {
    return RepoModel(
      name: json['full_name'],
      owner: SampleFeatureModel.fromJson(json['owner']),
      description: json['description'],
      language: json['language'],
      totalWatch: json['watchers_count'],
      totalFork: json['forks_count'],
      totalStar: json['stargazers_count'],
    );
  }

  Map<String, dynamic> toJson() => {
        'full_name': name,
        'owner': owner.toModel().toJson(),
        'description': description,
        'language': language,
        'watchers_count': totalWatch,
        'forks_count': totalFork,
        'stargazers_count': totalStar,
      };
}
