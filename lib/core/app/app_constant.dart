import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppConst {
  /*
    ...App General Const
  */
  static const double defaultMargin = 30;
  static const String appName = 'Gitagram';
  static const String appTag = 'Connect every developers';

  /* Size Helper
  ... Size of everything
   */
  /// The height of SafeArea Widget
  static double safeAreaHeight = Get.height -
      MediaQuery.of(Get.context!).padding.top -
      MediaQuery.of(Get.context!).padding.bottom;

  /// The height of SafeArea - Toolbar or the height of content view
  static double contentHeight = safeAreaHeight - kToolbarHeight;
}
