import 'package:flutter/foundation.dart';
import 'package:skybase/core/network/api_request.dart';
import 'package:skybase/data/models/repo_model.dart';
import 'package:skybase/data/models/sample_feature_model.dart';
import 'package:skybase/data/sources/server/sample_feature/sample_feature_api.dart';
import 'package:skybase/domain/entities/repo/repo.dart';
import 'package:skybase/domain/entities/sample_feature/sample_feature.dart';

class SampleFeatureApiImpl extends SampleFeatureApi {
  String tag = 'User Api';

  @override
  Future<List<SampleFeature>> getUsers({
    required int page,
    required int perPage,
  }) async {
    try {
      var url = '/search/users?';
      url += 'q=nanda&';
      url += 'page=$page&';
      url += 'per_page=$perPage';
      final res = await sendRequest(
        url: url,
        requestMethod: RequestMethod.GET,
        useToken: true,
      );
      return (res.data['items'])
          .map((data) => SampleFeatureModel.fromJson(data))
          .toList()
          .cast<SampleFeature>();
    } catch (e) {
      debugPrint('$tag Error = $e');
      rethrow;
    }
  }

  @override
  Future<SampleFeature> getDetailUser({required String username}) async {
    try {
      final res = await sendRequest(
        url: '/users/$username',
        requestMethod: RequestMethod.GET,
        useToken: true,
      );
      return SampleFeatureModel.fromJson(res.data);
    } catch (e) {
      debugPrint('$tag Error = $e');
      rethrow;
    }
  }

  @override
  Future<List<SampleFeature>> getFollowers({required String username}) async {
    try {
      final res = await sendRequest(
        url: '/users/$username/followers',
        requestMethod: RequestMethod.GET,
        useToken: true,
      );
      return (res.data)
          .map((data) => SampleFeatureModel.fromJson(data))
          .toList()
          .cast<SampleFeature>();
    } catch (e) {
      debugPrint('$tag Error = $e');
      rethrow;
    }
  }

  @override
  Future<List<SampleFeature>> getFollowings({required String username}) async {
    try {
      final res = await sendRequest(
        url: '/users/$username/following',
        requestMethod: RequestMethod.GET,
        useToken: true,
      );
      return (res.data)
          .map((data) => SampleFeatureModel.fromJson(data))
          .toList()
          .cast<SampleFeature>();
    } catch (e) {
      debugPrint('$tag Error = $e');
      rethrow;
    }
  }

  @override
  Future<List<Repo>> getRepos({required String username}) async {
    try {
      final res = await sendRequest(
        url: '/users/$username/repos?type=all',
        requestMethod: RequestMethod.GET,
        useToken: true,
      );
      return (res.data)
          .map((data) => RepoModel.fromJson(data))
          .toList()
          .cast<Repo>();
      // return List<Repo>.from(_res.data.map((data) => Repo.fromJson(data)));
    } catch (e) {
      debugPrint('$tag Error = $e');
      rethrow;
    }
  }
}
