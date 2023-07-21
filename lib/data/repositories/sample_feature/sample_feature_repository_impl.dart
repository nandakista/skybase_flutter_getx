import 'package:flutter/foundation.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository.dart';
import 'package:skybase/data/sources/local/sample_feature/sample_feature_dao.dart';
import 'package:skybase/data/sources/server/sample_feature/sample_feature_api.dart';

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
    return await apiService.getUsers(page: page, perPage: perPage);
  }

  @override
  Future<SampleFeature?> getDetailUser({required SampleFeature user}) async {
    try {
      if (dao.containData(user)) {
        SampleFeature? cache = dao.get(user.id);
        _getDetailApi(user.username);
        return cache;
      } else {
        final res = await _getDetailApi(user.username);
        return res;
      }
    } catch (e) {
      debugPrint('$tag Error = $e');
      rethrow;
    }
  }

  Future<SampleFeature> _getDetailApi(String username) async {
    final SampleFeature res = await apiService.getDetailUser(username: username);
    res.followersList = await apiService.getFollowers(username: username);
    res.followingList = await apiService.getFollowings(username: username);
    res.repositoryList = await apiService.getRepos(username: username);
    dao.insert(res);
    return res;
  }
}
