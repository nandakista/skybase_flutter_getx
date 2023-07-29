import 'package:get/get.dart';
import 'package:skybase/ui/views/profile/profile_binding.dart';
import 'package:skybase/ui/views/profile/profile_view.dart';

final profileRoute = [
  GetPage(
    name: ProfileView.route,
    page: () => const ProfileView(),
    binding: ProfileBinding(),
    preventDuplicates: false
  ),
];