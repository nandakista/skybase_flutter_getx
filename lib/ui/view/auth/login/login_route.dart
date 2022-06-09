import 'package:get/get.dart';
import 'package:varcore_flutter_base/ui/view/auth/login/login_binding.dart';
import 'package:varcore_flutter_base/ui/view/auth/login/login_page.dart';

final loginRoute = [
  GetPage(
    name: LoginPage.route,
    page: () => const LoginPage(),
    binding: LoginBinding(),
    participatesInRootNavigator: true,
  ),
];
