import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/ui/views/{{name}}/{{name}}_controller.dart';

class {{name.pascalCase()}}View extends GetView<{{name.pascalCase()}}Controller> {
  static const String route = '/{{name.paramCase()}}';
  const {{name.pascalCase()}}View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('{{name.pascalCase()}} View'),
      ),
    );
  }
}
