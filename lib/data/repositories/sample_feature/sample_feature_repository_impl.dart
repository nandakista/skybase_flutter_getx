import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository.dart';
import 'package:skybase/data/sources/server/sample_feature/sample_feature_api.dart';

class SampleFeatureRepositoryImpl extends SampleFeatureRepository {
  final SampleFeatureApi apiService;
  SampleFeatureRepositoryImpl({required this.apiService});

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
