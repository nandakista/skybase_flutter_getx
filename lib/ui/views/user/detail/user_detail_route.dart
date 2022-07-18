import 'package:get/get.dart';
import 'package:varcore_flutter_base/ui/views/user/detail/user_detail_binding.dart';
import 'package:varcore_flutter_base/ui/views/user/detail/user_detail_view.dart';

final userDetailPage = [
  GetPage(
    name: UserDetailView.route,
    page: () => const UserDetailView(),
    binding: UserDetailBinding(),
  ),
];