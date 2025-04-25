import 'package:skybase/data/models/sample_feature_model.dart';
import 'package:skybase/domain/entities/repo/repo.dart';

class RepoModel extends Repo {
  RepoModel({
    required super.name,
    required SampleFeatureModel super.owner,
    super.description,
    super.language,
    super.totalWatch,
    super.totalFork,
    super.totalStar,
  });

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
