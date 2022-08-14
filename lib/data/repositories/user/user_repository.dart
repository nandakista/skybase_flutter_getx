import 'package:skybase/data/models/user/user.dart';

abstract class UserRepository {
  Future<List<User>> getUsers({required int page, required int perPage});
  Future<User> getDetailUser({required User user});
}