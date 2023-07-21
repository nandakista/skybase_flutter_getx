import 'package:json_annotation/json_annotation.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';

bool typeEqual<S, T>() => S == T;

bool typeEqualN<S, T>() {
  return typeEqual<S, T>() || typeEqual<S?, T?>();
}

class CacheModelConverter<T> implements JsonConverter<T, Object> {
  const CacheModelConverter();

  @override
  T fromJson(Object? json) {
    json = json as Map<String, dynamic>;
    if (typeEqualN<T, SampleFeature>()) {
      return SampleFeature.fromJson(json) as T;
    }
    throw UnimplementedError('`$T` fromJson factory unimplemented.');
  }

  @override
  Map<String, dynamic> toJson(T obj) {
    if (typeEqualN<T, SampleFeature>()) {
      return (obj as SampleFeature).toJson();
    }

    throw UnimplementedError('`$T` toJson factory unimplemented.');
  }
}
