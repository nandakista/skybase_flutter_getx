import 'package:get/get.dart';
import 'package:skybase/ui/views/utils/utils_controller.dart';

class UtilsBinding implements Binding {
  @override
  List<Bind> dependencies() => [
        Bind.put(UtilsController()),
      ];
}
