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
  }) async {
    return await apiService.getUsers(page: page, perPage: perPage);
  }

  @override
  Future<SampleFeature> getDetailUser({
    required int id,
    required String username,
  }) async {
    final SampleFeature res = await apiService.getDetailUser(username: username);
    res.followersList = await apiService.getFollowers(username: username);
    res.followingList = await apiService.getFollowings(username: username);
    res.repositoryList = await apiService.getRepos(username: username);
    return res;
  }
}
