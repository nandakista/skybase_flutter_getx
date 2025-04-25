import 'package:skybase/config/base/request_param.dart';
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
    required RequestParams requestParams,
  }) async {
    return await apiService.getUsers(
        page: page, perPage: perPage, cancelToken: requestParams.cancelToken);
  }

  @override
  Future<SampleFeature> getDetailUser({
    required int id,
    required String username,
    required RequestParams requestParams,
  }) async {
    final SampleFeature res = await apiService.getDetailUser(
      username: username,
      cancelToken: requestParams.cancelToken,
    );
    res.followersList = await apiService.getFollowers(
      username: username,
      cancelToken: requestParams.cancelToken,
    );
    res.followingList = await apiService.getFollowings(
      username: username,
      cancelToken: requestParams.cancelToken,
    );
    res.repositoryList = await apiService.getRepos(
      username: username,
      cancelToken: requestParams.cancelToken,
    );
    return res;
  }
}
