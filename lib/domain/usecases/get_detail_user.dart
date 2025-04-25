import 'package:skybase/config/base/request_param.dart';
import 'package:skybase/domain/entities/sample_feature/sample_feature.dart';
import 'package:skybase/domain/repositories/sample_feature_repository.dart';

class GetDetailUser {
  final SampleFeatureRepository repository;

  GetDetailUser({required this.repository});

  Future<SampleFeature> call({
    required int id,
    required String username,
    required RequestParams requestParams,
  }) async {
    return await repository.getDetailUser(
      id: id,
      username: username,
      requestParams: requestParams,
    );
  }
}
