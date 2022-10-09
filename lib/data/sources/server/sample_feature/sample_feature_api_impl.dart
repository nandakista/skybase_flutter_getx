import 'dart:developer';

import 'package:skybase/core/network/api_request.dart';
import 'package:skybase/data/sources/server/sample_feature/sample_feature_api.dart';
import 'package:skybase/data/models/repo/repo.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';

class SampleFeatureApiImpl extends SampleFeatureApi {
  String tag = 'User Api';

  @override
  Future<List<SampleFeature>> getUsers({
    required int page,
    required int perPage,
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
          .map((data) => SampleFeature.fromJson(data))
          .toList()
          .cast<SampleFeature>();
    } catch (e) {
      log('$tag Error = $e');
      rethrow;
    }
  }

  @override
  Future<SampleFeature> getDetailUser({required String username}) async {
    try {
      final _res = await sendRequest(
        url: '/users/$username',
        requestMethod: RequestMethod.GET,
        useToken: true,
      );
      return SampleFeature.fromJson(_res.data);
    } catch (e) {
      log('$tag Error = $e');
      rethrow;
    }
  }

  @override
  Future<List<SampleFeature>> getFollowers({required String username}) async {
    try {
      final _res = await sendRequest(
        url: '/users/$username/followers',
        requestMethod: RequestMethod.GET,
        useToken: true,
      );
      return (_res.data)
          .map((data) => SampleFeature.fromJson(data))
          .toList()
          .cast<SampleFeature>();
    } catch (e) {
      log('$tag Error = $e');
      rethrow;
    }
  }

  @override
  Future<List<SampleFeature>> getFollowings({required String username}) async {
    try {
      final _res = await sendRequest(
        url: '/users/$username/following',
        requestMethod: RequestMethod.GET,
        useToken: true,
      );
      return (_res.data)
          .map((data) => SampleFeature.fromJson(data))
          .toList()
          .cast<SampleFeature>();
    } catch (e) {
      log('$tag Error = $e');
      rethrow;
    }
  }

  @override
  Future<List<Repo>> getRepos({required String username}) async {
    try {
      final _res = await sendRequest(
        url: '/users/$username/repos?type=all',
        requestMethod: RequestMethod.GET,
        useToken: true,
      );
      return (_res.data)
          .map((data) => Repo.fromJson(data))
          .toList()
          .cast<Repo>();
      // return List<Repo>.from(_res.data.map((data) => Repo.fromJson(data)));
    } catch (e) {
      log('$tag Error = $e');
      rethrow;
    }
  }
}
