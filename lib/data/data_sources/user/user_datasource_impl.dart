import 'package:varcore_flutter_base/core/network/api_request.dart';
import 'package:varcore_flutter_base/data/data_sources/user/user_datasource.dart';
import 'package:varcore_flutter_base/data/models/user.dart';

class UserDatasourceImpl extends UserDatasource {
  @override
  Future<List<User>> getUsers({
    int page = 1,
    int perPage = 20,
  }) async {
    try {
      var url = 'users?';
      url += 'page=$page&';
      url += 'per_page=$perPage';
      final res = await sendRequest(
        url: url,
        requestMethod: RequestMethod.GET,
      );
      return (res.data['data'])
          .map((data) => User.fromJson(data))
          .toList()
          .cast<User>();
    } catch (e) {
      rethrow;
    }
  }
}
