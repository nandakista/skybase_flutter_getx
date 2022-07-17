import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

FlutterSecureStorage secureStorage = Get.find<FlutterSecureStorage>();
class SecureStorageManager {
  static SecureStorageManager get to => Get.find<SecureStorageManager>();

  final String _tokenKey = "token";
  final String _refreshTokenKey = "token";

  Future<bool> isLoggedIn() async {
    return await secureStorage.containsKey(key: _tokenKey);
  }


  Future<String?> getToken() async {
    return await secureStorage.read(key: _tokenKey);
  }

  Future setToken({required String? value}) async {
    return await secureStorage.write(key: _tokenKey, value: value);
  }

  Future<String?> getRefreshToken() async {
    return await secureStorage.read(key: _refreshTokenKey);
  }

  Future setRefreshToken({required String? value}) async {
    return await secureStorage.write(key: _refreshTokenKey, value: value);
  }

  Future logout() async {
    await secureStorage.deleteAll();
  }
}
