import 'package:get/get.dart';
import 'package:skybase/ui/views/user/list/user_list_binding.dart';
import 'package:skybase/ui/views/user/list/user_list_view.dart';

final userListRoute = [
  GetPage(
    name: UserListView.route,
    page: () => const UserListView(),
    binding: UserListBinding(),
    participatesInRootNavigator: true,
  ),
];