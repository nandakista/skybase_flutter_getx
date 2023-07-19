import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/database/get_storage/get_storage_key.dart';
import 'package:skybase/core/database/get_storage/get_storage_manager.dart';
import 'package:skybase/ui/views/login/login_view.dart';

class IntroController extends GetxController {
  String tag = 'IntroController : ';

  RxInt currentIndex = 0.obs;
  PageController pageController = PageController(initialPage: 0);

  bool get isFirstPage => currentIndex.value == 0;

  bool get isLastPage => currentIndex.value == 2;

  void onPreviousPage() {
    pageController.previousPage(
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 260),
    );
  }

  void onNextPage() {
    if (!isLastPage) {
      pageController.nextPage(
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 260),
      );
    } else {
      GetStorageManager.find.save(GetStorageKey.firstInstall, false);
      Get.offAllNamed(LoginView.route);
    }
  }
}