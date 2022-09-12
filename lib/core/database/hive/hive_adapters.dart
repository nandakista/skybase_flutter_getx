import 'package:hive/hive.dart';
import 'package:skybase/data/models/repo/repo.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';

class HiveAdapters {
  static const String PERSON = 'PersonAdapter';
  static const String REPO = 'RepoAdapter';

  static register() {
    Hive.registerAdapter(PersonAdapter());
    Hive.registerAdapter(RepoAdapter());
  }
}
