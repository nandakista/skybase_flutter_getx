import 'package:hive/hive.dart';
import 'package:skybase/core/database/hive/entity/repo_entity.dart';
import 'package:skybase/core/database/hive/hive_adapters.dart';
import 'package:skybase/core/database/hive/hive_box.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';

part 'repo.g.dart';

@HiveType(typeId: HiveBox.repoId, adapterName: HiveAdapters.repo)
class Repo {
  @HiveField(RepoEntity.name)
  String name;

  @HiveField(RepoEntity.owner)
  SampleFeature owner;

  @HiveField(RepoEntity.description)
  String? description;

  @HiveField(RepoEntity.language)
  String? language;

  @HiveField(RepoEntity.totalWatch)
  int? totalWatch;

  @HiveField(RepoEntity.totalFork)
  int? totalFork;

  @HiveField(RepoEntity.totalStar)
  int? totalStar;

  Repo({
    required this.name,
    required this.owner,
    this.description,
    this.language,
    this.totalWatch,
    this.totalFork,
    this.totalStar,
  });

  factory Repo.fromJson(Map<dynamic, dynamic> json) {
    return Repo(
      name: json['full_name'],
      owner: SampleFeature.fromJson(json['owner']),
      description: json['description'],
      language: json['language'],
      totalWatch: json['watchers_count'],
      totalFork: json['forks_count'],
      totalStar: json['stargazers_count'],
    );
  }

  Map<String, dynamic> toJson() => {
    'full_name': name,
    'owner': owner,
    'description': description,
    'language': language,
    'watchers_count': totalWatch,
    'forks_count': totalFork,
    'stargazers_count': totalStar,
  };
}
