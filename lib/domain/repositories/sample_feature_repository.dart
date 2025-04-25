import 'package:skybase/config/base/request_param.dart';
import 'package:skybase/domain/entities/sample_feature/sample_feature.dart';

abstract class SampleFeatureRepository {
  Future<List<SampleFeature>> getUsers({
    required int page,
    required int perPage,
    required RequestParams requestParams,
  });

  Future<SampleFeature> getDetailUser({
    required int id,
    required String username,
    required RequestParams requestParams,
  });
}
