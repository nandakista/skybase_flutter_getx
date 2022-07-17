import 'package:varcore_flutter_base/core/network/api_request.dart';
import 'package:varcore_flutter_base/data/data_sources/server/user/user_api.dart';
import 'package:varcore_flutter_base/data/models/repo/repo.dart';
import 'package:varcore_flutter_base/data/models/user/user.dart';

class UserApiImpl extends UserApi {
  @override
  Future<List<User>> getUsers({
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      var _url = '/search/users?';
      _url += 'q=nanda&';
      _url += 'page=$page&';
      _url += 'per_page=$perPage';
      final _res = await sendRequest(
        url: _url,
        requestMethod: RequestMethod.GET,
        useToken: true,
      );
      return (_res.data['items'])
          .map((data) => User.fromJson(data))
          .toList()
          .cast<User>();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> getDetailUser({required String username}) async {
    try {
      final _res = await sendRequest(
        url: '/users/$username',
        requestMethod: RequestMethod.GET,
      );
      return User.fromJson(_res.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<User>> getFollowers({required String username}) async {
    try {
      final _res = await sendRequest(
        url: '/users/$username/followers',
        requestMethod: RequestMethod.GET,
      );
      return (_res.data)
          .map((data) => User.fromJson(data))
          .toList()
          .cast<User>();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<User>> getFollowings({required String username}) async {
    try {
      final _res = await sendRequest(
        url: '/users/$username/following',
        requestMethod: RequestMethod.GET,
      );
      return (_res.data)
          .map((data) => User.fromJson(data))
          .toList()
          .cast<User>();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Repo>> getRepos({required String username}) async {
    try {
      final _res = await sendRequest(
        url: '/users/$username/repos?type=all',
        requestMethod: RequestMethod.GET,
      );
      return (_res.data)
          .map((data) => Repo.fromJson(data))
          .toList()
          .cast<Repo>();
      // return List<Repo>.from(_res.data.map((data) => Repo.fromJson(data)));
    } catch (e) {
      rethrow;
    }
  }
}
