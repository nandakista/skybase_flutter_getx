import 'package:hive/hive.dart';
import 'package:varcore_flutter_base/core/database/hive/entity/repo_entity.dart';
import 'package:varcore_flutter_base/core/database/hive/hive_adapters.dart';
import 'package:varcore_flutter_base/core/database/hive/hive_box.dart';
import 'package:varcore_flutter_base/data/models/user/user.dart';

part 'repo.g.dart';

@HiveType(typeId: HiveBox.REPO, adapterName: HiveAdapters.REPO)
class Repo {
  @HiveField(RepoEntity.name)
  String name;

  @HiveField(RepoEntity.owner)
  User owner;

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
      owner: User.fromJson(json['owner']),
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
