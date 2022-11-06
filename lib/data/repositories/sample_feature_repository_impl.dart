import 'package:flutter/foundation.dart';
import 'package:skybase/data/sources/local/sample_feature/sample_feature_dao.dart';
import 'package:skybase/data/sources/server/sample_feature/sample_feature_api.dart';
import 'package:skybase/domain/entities/sample_feature/sample_feature.dart';
import 'package:skybase/domain/repositories/sample_feature_repository.dart';

class SampleFeatureRepositoryImpl extends SampleFeatureRepository {
  final SampleFeatureApi apiService;
  final SampleFeatureDao dao;
  SampleFeatureRepositoryImpl({required this.apiService, required this.dao});

  String tag = 'User Repository';

  @override
  Future<List<SampleFeature>> getUsers({
    required int page,
    required int perPage,
    bool isRefresh = false,
  }) async {
    try {
      if (page == 1 && !isRefresh && dao.boxIsNotEmpty()) {
        List<SampleFeature> _cache = dao.getAll();
        _getListUserApi(page: page, perPage: perPage);
        _cache.sort((a,b) => a.username.compareTo(b.username));
        return _cache;
      } else {
        final _res = await _getListUserApi(page: page, perPage: perPage);
        return _res;
      }
    } catch (e) {
      debugPrint('$tag Error = $e');
      rethrow;
    }
  }

  @override
  Future<SampleFeature?> getDetailUser({required SampleFeature user}) async {
    try {
      if (dao.containData(user)) {
        SampleFeature? _cache = dao.get(user.id);
        _getDetailApi(user.username);
        return _cache;
      } else {
        final _res = await _getDetailApi(user.username);
        return _res;
      }
    } catch (e) {
      debugPrint('$tag Error = $e');
      rethrow;
    }
  }

  Future<SampleFeature> _getDetailApi(String username) async {
    final SampleFeature _res = await apiService.getDetailUser(username: username);
    _res.followersList = await apiService.getFollowers(username: username);
    _res.followingList = await apiService.getFollowings(username: username);
    _res.repositoryList = await apiService.getRepos(username: username);
    dao.insert(_res);
    return _res;
  }

  Future<List<SampleFeature>> _getListUserApi({
    required int page,
    required int perPage,
  }) async {
    final _res = await apiService.getUsers(page: page, perPage: perPage);
    _res.sort((a,b) => a.username.compareTo(b.username));
    if(page == 1) {
      await dao.clear();
      dao.insertAll(_res);
    }
    return _res;
  }
}