import 'package:get/get.dart';

extension GetXExtensions on GetInterface {
  T findOrLazyPut<T>(T Function() builder, {bool fenix = false}) {
    if (Get.isRegistered<T>()) {
      return Get.find<T>();
    } else {
      Get.lazyPut<T>(builder, fenix: fenix);
      return Get.find<T>();
    }
  }

  T findOrPut<T>(T builder, {bool fenix = false}) {
    if (Get.isRegistered<T>()) {
      return Get.find<T>();
    } else {
      Get.put<T>(builder);
      return Get.find<T>();
    }
  }
}
