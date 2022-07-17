import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:varcore_flutter_base/core/database/hive/hive_adapters.dart';
import 'package:varcore_flutter_base/core/database/hive/hive_box.dart';


class HiveDb {
  static Future init() async {
    HiveAdapters.register();

    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    await Hive.openBox(HiveBox.USER.toString());
    await Hive.openBox(HiveBox.REPO.toString());
  }
}