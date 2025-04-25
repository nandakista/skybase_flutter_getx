import 'package:skybase/config/base/request_param.dart';
import 'package:skybase/domain/entities/sample_feature/sample_feature.dart';
import 'package:skybase/domain/repositories/sample_feature_repository.dart';

class GetUsers {
  final SampleFeatureRepository repository;

  GetUsers({required this.repository});

  Future<List<SampleFeature>> call({
    required int page,
    required int perPage,
    required RequestParams requestParams,
  }) async {
    return await repository.getUsers(
      page: page,
      perPage: perPage,
      requestParams: requestParams,
    );
  }
}
