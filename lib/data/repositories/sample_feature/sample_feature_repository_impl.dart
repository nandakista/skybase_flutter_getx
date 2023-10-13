import 'package:dio/dio.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository.dart';
import 'package:skybase/data/sources/server/sample_feature/sample_feature_sources.dart';

class SampleFeatureRepositoryImpl implements SampleFeatureRepository {
  final SampleFeatureSources apiService;

  SampleFeatureRepositoryImpl({required this.apiService});

  String tag = 'SampleFeatureRepository::->';

  @override
  Future<List<SampleFeature>> getUsers({
    required CancelToken cancelToken,
    required int page,
    required int perPage,
  }) async {
    return await apiService.getUsers(
      cancelToken: cancelToken,
      page: page,
      perPage: perPage,
    );
  }

  @override
  Future<SampleFeature> getDetailUser({
    required CancelToken cancelToken,
    required int id,
    required String username,
  }) async {
    final SampleFeature res = await apiService.getDetailUser(
      cancelToken: cancelToken,
      username: username,
    );
    res.followersList = await apiService.getFollowers(
      cancelToken: cancelToken,
      username: username,
    );
    res.followingList = await apiService.getFollowings(
      cancelToken: cancelToken,
      username: username,
    );
    res.repositoryList = await apiService.getRepos(
      cancelToken: cancelToken,
      username: username,
    );
    return res;
  }
}
