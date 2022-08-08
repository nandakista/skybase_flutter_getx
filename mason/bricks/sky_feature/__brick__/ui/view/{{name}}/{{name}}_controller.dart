import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/data/data_sources/server/{{name}}/{{name}}_api.dart';

class {{name.pascalCase()}}Controller extends GetxController {
  final {{name.pascalCase()}}Api dataSource;
  {{name.pascalCase()}}Controller({required this.dataSource});
  String tag = '{{name.pascalCase()}}Controller :';

}