import 'package:get/get.dart';
import 'package:{{package}}/ui/views/{{name}}/{{name}}_controller.dart';

class {{name.pascalCase()}}Binding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => {{name.pascalCase()}}Controller());
  }
}