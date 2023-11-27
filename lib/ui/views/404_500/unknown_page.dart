import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/extension/string_extension.dart';
import 'package:skybase/ui/widgets/platform_loading_indicator.dart';

GetPage<dynamic>? get unknownPage {
  if (Platform.isAndroid) {
    return GetPage(
      name: '/unknown',
      page: () {
        if (Get.previousRoute.isNotNullAndNotEmpty) Get.back();
        return const Scaffold(
          body: PlatformLoadingIndicator(),
        );
      },
    );
  }
  return null;
}
