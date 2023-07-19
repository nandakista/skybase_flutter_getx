import 'package:get/get.dart';
import 'package:skybase/ui/views/intro/intro_binding.dart';
import 'package:skybase/ui/views/intro/intro_view.dart';

final introRoute = [
  GetPage(
    name: IntroView.route,
    page: () => const IntroView(),
    binding: IntroBinding()
  ),
];

