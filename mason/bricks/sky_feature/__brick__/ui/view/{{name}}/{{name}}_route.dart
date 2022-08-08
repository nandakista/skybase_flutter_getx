import 'package:get/get.dart';
import 'package:skybase/ui/views/{{name}}/{{name}}_binding.dart';
import 'package:skybase/ui/views/{{name}}/{{name}}_view.dart';

final {{name.camelCase()}}Route = [
  GetPage(
    name: {{name.pascalCase()}}View.route,
    page: () => const {{name.pascalCase()}}View(),
    binding: {{name.pascalCase()}}Binding(),
  ),
];
