import 'package:get/get.dart';
import 'package:skybase/ui/views/auth/login/login_binding.dart';
import 'package:skybase/ui/views/auth/login/login_view.dart';

final loginRoute = [
  GetPage(
    name: LoginView.route,
    page: () => const LoginView(),
    binding: LoginBinding(),
    participatesInRootNavigator: true,
  ),
];
