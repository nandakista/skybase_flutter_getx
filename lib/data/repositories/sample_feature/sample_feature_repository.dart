import 'package:skybase/data/models/sample_feature/sample_feature.dart';

abstract class SampleFeatureRepository {
  Future<List<SampleFeature>> getUsers({
    required int page,
    required int perPage,
    bool isRefresh = false,
  });

  Future<SampleFeature> getDetailUser({
    required int id,
    required String username,
  });
}
