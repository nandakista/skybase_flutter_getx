import 'package:skybase/data/repositories/{{name}}/{{name}}_repository.dart';
import 'package:skybase/data/data_sources/server/{{name}}/{{name}}_api.dart';

class {{name.pascalCase()}}RepositoryImpl extends {{name.pascalCase()}}Repository {
  final {{name.pascalCase()}}Api apiService;
  {{name.pascalCase()}}RepositoryImpl({required this.apiService});

  String tag = '{{name.pascalCase()}}Repository : ';

}