import 'package:varcore_flutter_base/data/models/user.dart';

abstract class UserDatasource {
  Future<List<User>> getUsers({int page=1, int perPage=20});
}