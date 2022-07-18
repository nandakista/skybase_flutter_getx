import 'package:varcore_flutter_base/core/helper/safe_request_api_helper.dart';
import 'package:varcore_flutter_base/data/data_sources/local/user/user_dao.dart';
import 'package:varcore_flutter_base/data/data_sources/server/user/user_api.dart';
import 'package:varcore_flutter_base/data/models/user/user.dart';
import 'package:varcore_flutter_base/data/repositories/user/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserApi apiService;
  UserRepositoryImpl({required this.apiService});

  final _userDao = UserDao.to;

  @override
  Future<List<User>> getUsers() async {
    try {
      if (_userDao.box.isNotEmpty) {
        List<User> _cache = _userDao.getAll();
        SafeRequestAPI.call(() => _getListUserApi());
        // await _getListUserApi();
        return _cache;
      } else {
        final _res = await _getListUserApi();
        return _res;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> getDetailUser({required User user}) async {
    try {
      if (_userDao.containData(user)) {
        User _cache = _userDao.get(user.id);
        SafeRequestAPI.call(() => _getDetailApi(_cache.username));
        // _getDetailApi(user.username);
        return _cache;
      } else {
        final _res = await _getDetailApi(user.username);
        return _res;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<User> _getDetailApi(String username) async {
    final User _res = await apiService.getDetailUser(username: username);
    _res.followersList = await apiService.getFollowers(username: username);
    _res.followingList = await apiService.getFollowings(username: username);
    _res.repositoryList = await apiService.getRepos(username: username);
    _userDao.insert(_res);
    return _res;
  }

  Future<List<User>> _getListUserApi() async {
    final _res = await apiService.getUsers();
    _userDao.insertAll(_res);
    return _res;
  }
}