import 'package:dio/dio.dart';
import 'package:skybase/data/sources/server/sample_feature/sample_feature_sources.dart';
import 'package:skybase/domain/entities/sample_feature/sample_feature.dart';
import 'package:skybase/domain/repositories/sample_feature_repository.dart';

class SampleFeatureRepositoryImpl extends SampleFeatureRepository {
  final SampleFeatureSources apiService;
  SampleFeatureRepositoryImpl({required this.apiService});

  String tag = 'SampleFeatureRepository::->';

  @override
  Future<List<SampleFeature>> getUsers({
    required int page,
    required int perPage,
    required CancelToken cancelToken,
  }) async {
    return await apiService.getUsers(page: page, perPage: perPage, cancelToken: cancelToken);
  }

  @override
  Future<SampleFeature> getDetailUser({
    required int id,
    required String username,
    required CancelToken cancelToken,
  }) async {
    final SampleFeature res = await apiService.getDetailUser(username: username, cancelToken: cancelToken);
    res.followersList = await apiService.getFollowers(username: username, cancelToken: cancelToken);
    res.followingList = await apiService.getFollowings(username: username, cancelToken: cancelToken);
    res.repositoryList = await apiService.getRepos(username: username, cancelToken: cancelToken);
    return res;
  }
}
