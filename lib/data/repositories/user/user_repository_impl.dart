import 'dart:developer';

import 'package:skybase/data/data_sources/local/user/user_dao.dart';
import 'package:skybase/data/data_sources/server/user/user_api.dart';
import 'package:skybase/data/models/user/user.dart';
import 'package:skybase/data/repositories/user/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserApi apiService;
  final UserDao dao;
  UserRepositoryImpl({required this.apiService, required this.dao});

  String tag = 'User Repository';

  @override
  Future<List<User>> getUsers({required int page, required int perPage}) async {
    try {
      if (dao.boxIsEmpty()) {
        final _res = await _getListUserApi(page: page, perPage: perPage);
        return _res;
      } else {
        List<User> _cache = dao.getAll();
        await _getListUserApi();
        return _cache;
      }
    } catch (e) {
      log('$tag Error = $e');
      rethrow;
    }
  }

  @override
  Future<User> getDetailUser({required User user}) async {
    try {
      if (dao.containData(user)) {
        User _cache = dao.get(user.id);
        _getDetailApi(user.username);
        return _cache;
      } else {
        final _res = await _getDetailApi(user.username);
        return _res;
      }
    } catch (e) {
      log('$tag Error = $e');
      rethrow;
    }
  }

  Future<User> _getDetailApi(String username) async {
    final User _res = await apiService.getDetailUser(username: username);
    _res.followersList = await apiService.getFollowers(username: username);
    _res.followingList = await apiService.getFollowings(username: username);
    _res.repositoryList = await apiService.getRepos(username: username);
    dao.insert(_res);
    return _res;
  }

  Future<List<User>> _getListUserApi({int page = 1, int perPage = 10}) async {
    final _res = await apiService.getUsers(page: page, perPage: perPage);
    dao.insertAll(_res);
    return _res;
  }
}