import 'package:skybase/data/models/repo/repo.dart';
import 'package:skybase/data/models/user/user.dart';

abstract class UserApi {
  Future<List<User>> getUsers({int page=1, int perPage=20});
  Future<User> getDetailUser({required String username});
  Future<List<User>> getFollowers({required String username});
  Future<List<User>> getFollowings({required String username});
  Future<List<Repo>> getRepos({required String username});
}