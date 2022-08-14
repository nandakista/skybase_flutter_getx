import 'package:skybase/data/models/user/user.dart';

abstract class UserDao {
  bool boxIsEmpty();
  bool containData(User user);
  User get(int id);
  void insert(User user);
  void insertAll(List<User> users);
  List<User> getAll();
  void clear();
  void delete(User user);
  void deleteAll(List<User> users);
}