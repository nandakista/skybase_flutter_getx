import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:varcore_flutter_base/core/database/hive/hive_box.dart';
import 'package:varcore_flutter_base/data/models/user/user.dart';

class UserDao {
  static UserDao get to => Get.find<UserDao>();
  final box = Hive.box(HiveBox.USER.toString());

  bool containData(User user) {
    User _data = box.get(user.id);
    return (box.containsKey(user.id) && _data.repository != null);
  }

  User get(int id) {
    return box.get(id);
  }

  void insert(User user) {
    box.put(user.id, user);
    debugPrint('Successfully added product');
    debugPrint('============================');
  }

  void insertAll(List<User> users) {
    users.asMap().forEach((i, value) {
      box.put(users[i].id, users[i]);
    });
    debugPrint('Successfully added list users');
    debugPrint('============================');
  }

  List<User> getAll() {
    List<User> _users = [];
    for (var i = 0; i < box.length; i++) {
      _users.add(box.getAt(i));
    }
    debugPrint('Successfully get list user');
    debugPrint('============================');
    return _users;
  }

  void deleteAll() {
    box.clear();
    debugPrint('Successfully clear user box');
    debugPrint('================================');
  }
}
