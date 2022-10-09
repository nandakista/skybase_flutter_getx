import 'package:skybase/domain/entities/repo/repo.dart';
import 'package:skybase/domain/entities/sample_feature/sample_feature.dart';

abstract class SampleFeatureApi {
  Future<List<SampleFeature>> getUsers({required int page, required int perPage});
  Future<SampleFeature> getDetailUser({required String username});
  Future<List<SampleFeature>> getFollowers({required String username});
  Future<List<SampleFeature>> getFollowings({required String username});
  Future<List<Repo>> getRepos({required String username});
}