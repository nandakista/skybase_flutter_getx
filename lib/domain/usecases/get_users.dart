import 'package:skybase/domain/entities/sample_feature/sample_feature.dart';
import 'package:skybase/domain/repositories/sample_feature_repository.dart';

class GetUsers {
  final SampleFeatureRepository repository;

  GetUsers({required this.repository});

  Future<List<SampleFeature>> call({
    required int page,
    required int perPage,
  }) async {
    return await repository.getUsers(page: page, perPage: perPage);
  }
}
