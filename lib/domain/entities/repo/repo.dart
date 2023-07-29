import 'package:skybase/data/models/repo_model.dart';
import 'package:skybase/domain/entities/sample_feature/sample_feature.dart';

class Repo {
  String name;
  SampleFeature owner;
  String? description;
  String? language;
  int? totalWatch;
  int? totalFork;
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

  RepoModel toModel() {
    return RepoModel(
      name: name,
      owner: owner.toModel(),
      totalWatch: totalWatch,
      totalStar: totalStar,
      totalFork: totalFork,
      language: language,
      description: description,
    );
  }
}
