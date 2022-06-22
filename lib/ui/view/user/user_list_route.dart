import 'package:get/get.dart';
import 'package:varcore_flutter_base/ui/view/user/user_list_binding.dart';
import 'package:varcore_flutter_base/ui/view/user/user_list_page.dart';

final userListRoute = [
  GetPage(
    name: UserListPage.route,
    page: () => const UserListPage(),
    binding: UserListBinding(),
    participatesInRootNavigator: true,
  ),
];