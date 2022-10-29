import 'package:{{package}}/domain/entities/{{name}}/{{name}}.dart';

class {{name.pascalCase()}}Model extends {{name.pascalCase()}} {
  {{name.pascalCase()}}Model({ {{#variables}}
    {{type}} {{name.camelCase()}},{{/variables}}
  });

  factory {{name.pascalCase()}}Model.fromJson(Map<dynamic, dynamic> json) {
    return {{name.pascalCase()}}Model({{#variables}}
      {{name.camelCase()}}: json['{{key}}'],{{/variables}}
    );
  }
  Map<String, dynamic> toJson() => { {{#variables}}
   '{{key}}': {{name.camelCase()}},{{/variables}}
  }
}