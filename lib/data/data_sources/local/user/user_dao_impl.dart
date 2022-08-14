import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:skybase/core/database/hive/hive_box.dart';
import 'package:skybase/data/data_sources/local/user/user_dao.dart';
import 'package:skybase/data/models/user/user.dart';

class UserDaoImpl implements UserDao {
  static UserDaoImpl get find => Get.find<UserDaoImpl>();
  final box = Hive.box(HiveBox.user);

  @override
  bool boxIsEmpty() => box.isNotEmpty;

  @override
  bool containData(User user) {
    User _data = box.get(user.id);
    return (box.containsKey(user.id) && _data.repository != null);
  }

  @override
  User get(int id) => box.get(id);

  @override
  void insert(User user) => box.put(user.id, user);

  @override
  void insertAll(List<User> users) {
    users.asMap().forEach((i, value) {
      box.put(users[i].id, users[i]);
    });
  }

  @override
  List<User> getAll() {
    List<User> _users = [];
    for (var i = 0; i < box.length; i++) {
      _users.add(box.getAt(i));
    }
    return _users;
  }

  @override
  void deleteAll(List<User> users) {
    box.deleteAll(users);
  }

  @override
  void clear() => box.clear();

  @override
  void delete(User user) {
    box.delete(user);
  }
}
