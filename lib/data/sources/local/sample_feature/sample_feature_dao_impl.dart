import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:skybase/core/database/hive/hive_box.dart';
import 'package:skybase/data/sources/local/sample_feature/sample_feature_dao.dart';
import 'package:skybase/domain/entities/sample_feature/sample_feature.dart';

class SampleFeatureDaoImpl implements SampleFeatureDao {
  final box = Hive.box(HiveBox.user);

  @override
  bool boxIsEmpty() => box.isNotEmpty;

  @override
  bool containData(SampleFeature user) {
    SampleFeature _data = box.get(user.id);
    return (box.containsKey(user.id) && _data.repository != null);
  }

  @override
  SampleFeature get(int id) => box.get(id);

  @override
  void insert(SampleFeature user) => box.put(user.id, user);

  @override
  void insertAll(List<SampleFeature> users) {
    users.asMap().forEach((i, value) {
      box.put(users[i].id, users[i]);
    });
  }

  @override
  List<SampleFeature> getAll() {
    List<SampleFeature> _users = [];
    for (var i = 0; i < box.length; i++) {
      _users.add(box.getAt(i));
    }
    return _users;
  }

  @override
  void deleteAll(List<SampleFeature> users) {
    box.deleteAll(users);
  }

  @override
  void clear() => box.clear();

  @override
  void delete(SampleFeature user) {
    box.delete(user);
  }
}
