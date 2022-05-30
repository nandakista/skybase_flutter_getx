import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:varcore_flutter_base/data/models/user.dart';

class KeyBox {
  static const String token = "token";
  static const String refreshToken = "refresh-token";
  static const String user = "user";
}

class LocalStorage {
  static LocalStorage get to => Get.find<LocalStorage>();

  final userBox = GetStorage("userBox");
  final authBox = GetStorage("authBox");

  // -------<Credential Storage>-------
  void saveToken(String token) => authBox.write(KeyBox.token, token);
  void saveRefreshToken(String token) => authBox.write(KeyBox.refreshToken, token);
  String? getToken() => authBox.read(KeyBox.token);
  String? getRefreshToken() => authBox.read(KeyBox.refreshToken);
  bool isLoggedIn() => authBox.hasData(KeyBox.token);

  // -------<User Data Storage>-------
  void saveUser(User user) => userBox.write(KeyBox.user, user.toJson());
  bool isEmptyUser() => !(userBox.hasData(KeyBox.user));
  User? getUser() {
    final user = userBox.read(KeyBox.user);
    if (user != null) {
      return User.fromJson(userBox.read(KeyBox.user));
    }
    return null;
  }

  logout() async => clearAllBox();

  void clearAllBox() async {
    try {
      await authBox.erase();
      await userBox.erase();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
