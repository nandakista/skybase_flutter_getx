import 'package:get/get.dart';
import 'package:varcore_flutter_base/ui/views/user/list/user_list_binding.dart';
import 'package:varcore_flutter_base/ui/views/user/list/user_list_view.dart';

final userListRoute = [
  GetPage(
    name: UserListView.route,
    page: () => const UserListView(),
    binding: UserListBinding(),
    participatesInRootNavigator: true,
  ),
];