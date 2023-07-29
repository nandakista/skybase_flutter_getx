import 'package:skybase/domain/entities/sample_feature/sample_feature.dart';

abstract class SampleFeatureRepository {
  Future<List<SampleFeature>> getUsers({
    required int page,
    required int perPage,
  });

  Future<SampleFeature> getDetailUser({
    required int id,
    required String username,
  });
}
