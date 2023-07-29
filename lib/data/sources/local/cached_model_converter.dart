import 'package:json_annotation/json_annotation.dart';
import 'package:skybase/data/models/repo_model.dart';
import 'package:skybase/data/models/sample_feature_model.dart';
import 'package:skybase/data/models/user.dart';
import 'package:skybase/domain/entities/repo/repo.dart';
import 'package:skybase/domain/entities/sample_feature/sample_feature.dart';
import 'package:skybase/domain/entities/user/user.dart';

bool typeEqual<S, T>() => S == T;

bool typeEqualN<S, T>() {
  return typeEqual<S, T>() || typeEqual<S?, T?>();
}

///
/// Every cache model must be registered here
///
class CachedModelConverter<T> implements JsonConverter<T, Object> {
  const CachedModelConverter();

  @override
  T fromJson(Object? json) {
    json = json as Map<String, dynamic>;
    if (typeEqualN<T, SampleFeature>()) {
      return SampleFeatureModel.fromJson(json) as T;
    } else if (typeEqualN<T, User>()) {
      return UserModel.fromJson(json) as T;
    } else if (typeEqualN<T, Repo>()) {
      return RepoModel.fromJson(json) as T;
    }
    ///
    /// Add other models
    ///
    ///
    throw UnimplementedError('`$T` fromJson factory unimplemented.');
  }

  @override
  Map<String, dynamic> toJson(T obj) {
    if (typeEqualN<T, SampleFeature>()) {
      return (obj as SampleFeatureModel).toJson();
    } else if (typeEqualN<T, User>()) {
      return (obj as UserModel).toJson();
    } else if (typeEqualN<T, Repo>()) {
      return (obj as RepoModel).toJson();
    }
    ///
    /// Add other models
    ///

    throw UnimplementedError('`$T` toJson factory unimplemented.');
  }
}
