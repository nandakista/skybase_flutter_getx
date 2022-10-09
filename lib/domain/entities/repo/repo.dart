import 'package:hive/hive.dart';
import 'package:skybase/core/database/hive/entity/repo_entity.dart';
import 'package:skybase/core/database/hive/hive_adapters.dart';
import 'package:skybase/core/database/hive/hive_box.dart';
import 'package:skybase/domain/entities/sample_feature/sample_feature.dart';

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
}
