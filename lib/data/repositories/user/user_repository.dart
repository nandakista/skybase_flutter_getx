import 'package:skybase/data/models/user/user.dart';

abstract class UserRepository {
  Future<List<User>> getUsers();
  Future<User> getDetailUser({required User user});
}