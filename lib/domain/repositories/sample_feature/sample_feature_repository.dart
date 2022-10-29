import 'package:skybase/domain/entities/sample_feature/sample_feature.dart';

abstract class SampleFeatureRepository {
  Future<List<SampleFeature>> getUsers({
    required int page,
    required int perPage,
    bool isRefresh = false,
  });
  Future<SampleFeature?> getDetailUser({required SampleFeature user});
}
