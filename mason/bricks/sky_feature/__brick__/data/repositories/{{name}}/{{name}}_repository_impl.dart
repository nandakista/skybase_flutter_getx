import 'package:skybase/data/repositories/{{name}}/{{name}}_repository.dart';
import 'package:skybase/data/sources/server/{{api}}/{{api}}_api.dart';
import 'package:skybase/data/sources/local/{{dao}}/{{dao}}_dao.dart';

class {{name.pascalCase()}}RepositoryImpl implements {{name.pascalCase()}}Repository {
  final {{api.pascalCase()}}Api apiService;
  final {{dao.pascalCase()}}Dao dao;
  {{name.pascalCase()}}RepositoryImpl({required this.apiService, required this.dao});

  String tag = '{{name.pascalCase()}}Repository : ';

}