import 'package:get/get.dart';
import 'package:skybase/core/base/base_controller.dart';
import 'package:skybase/data/repositories/{{name}}/{{name}}_repository.dart';

class {{name.pascalCase()}}Controller extends BaseController {
  final {{name.pascalCase()}}Repository repository;
  {{name.pascalCase()}}Controller({required this.repository});
  String tag = '{{name.pascalCase()}}Controller :';

}