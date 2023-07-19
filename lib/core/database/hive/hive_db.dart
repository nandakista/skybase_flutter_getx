import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skybase/core/database/hive/hive_adapters.dart';
import 'package:skybase/core/database/hive/hive_box.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';

class HiveDb {
  static Future init() async {
    HiveAdapters.register();

    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    await Hive.openBox<SampleFeature>(HiveBox.user);
    await Hive.openBox(HiveBox.repo);
  }
}