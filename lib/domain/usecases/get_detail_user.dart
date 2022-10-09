import 'package:skybase/domain/entities/sample_feature/sample_feature.dart';
import 'package:skybase/domain/interfaces/sample_feature/sample_feature_repository.dart';

class GetDetailUser {
  final SampleFeatureRepository repository;
  GetDetailUser({required this.repository});

  Future<SampleFeature> call({required SampleFeature user}) async {
    return await repository.getDetailUser(user: user);
  }
}