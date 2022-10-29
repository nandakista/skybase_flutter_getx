import 'package:get/get.dart';
import 'package:skybase/ui/views/{{name}}/{{name}}_controller.dart';
import 'package:skybase/data/repositories/{{name}}/{{name}}_repository_impl.dart';
import 'package:skybase/data/sources/server/{{api}}/{{api}}_api_impl.dart';
import 'package:skybase/data/sources/local/{{dao}}/{{dao}}_dao_impl.dart';

class {{name.pascalCase()}}Binding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => {{name.pascalCase()}}Controller(
        repository: {{name.pascalCase()}}RepositoryImpl(
          apiService: {{api.pascalCase()}}ApiImpl(),
          dao: {{dao.pascalCase()}}DaoImpl(),
        ),
      ),
    );
  }
}