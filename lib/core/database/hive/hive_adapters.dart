import 'package:hive/hive.dart';
import 'package:varcore_flutter_base/data/models/repo/repo.dart';
import 'package:varcore_flutter_base/data/models/user/user.dart';

class HiveAdapters {
  static const String USER = 'UserAdapter';
  static const String REPO = 'RepoAdapter';

  static register() {
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(RepoAdapter());
  }
}
