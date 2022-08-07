import 'package:hive/hive.dart';
import 'package:skybase/data/models/repo/repo.dart';
import 'package:skybase/data/models/user/user.dart';

class HiveAdapters {
  static const String USER = 'UserAdapter';
  static const String REPO = 'RepoAdapter';

  static register() {
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(RepoAdapter());
  }
}
