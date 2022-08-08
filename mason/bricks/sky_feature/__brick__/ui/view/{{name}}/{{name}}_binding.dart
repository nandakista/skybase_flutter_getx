import 'package:get/get.dart';
import 'package:skybase/ui/views/{{name}}/{{name}}_controller.dart';
import 'package:skybase/data/data_sources/server/{{name}}/{{name}}_api_impl.dart';

class {{name.pascalCase()}}Binding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => {{name.pascalCase()}}Controller(dataSource: {{name.pascalCase()}}ApiImpl()));
  }
}