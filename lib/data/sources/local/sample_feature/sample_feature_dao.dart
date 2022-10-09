import 'package:skybase/domain/entities/sample_feature/sample_feature.dart';

abstract class SampleFeatureDao {
  bool boxIsEmpty();
  bool containData(SampleFeature user);
  SampleFeature get(int id);
  void insert(SampleFeature user);
  void insertAll(List<SampleFeature> users);
  List<SampleFeature> getAll();
  void clear();
  void delete(SampleFeature user);
  void deleteAll(List<SampleFeature> users);
}