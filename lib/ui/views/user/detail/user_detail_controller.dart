import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:varcore_flutter_base/core/helper/dialog_helper.dart';
import 'package:varcore_flutter_base/data/models/user/user.dart';
import 'package:varcore_flutter_base/data/repositories/user/user_repository.dart';

class UserDetailController extends GetxController {
  final UserRepository repository;
  UserDetailController({required this.repository});

  final GlobalKey headerKey = GlobalKey();
  final GlobalKey detailInfoKey = GlobalKey();
  final headerWidget = Rxn<Size>();
  final detailInfoWidget = Rxn<Size>();

  final user = Rxn<User>();

  RxBool isLoading = false.obs;
  showLoading() => isLoading.toggle();
  hideLoading() => isLoading.toggle();

  @override
  void onInit() {
    super.onInit();
    user.value = Get.arguments;
  }

  @override
  void onReady() async {
    headerWidget.value = (headerKey.currentContext?.findRenderObject() as RenderBox).size;
    detailInfoWidget.value = (detailInfoKey.currentContext?.findRenderObject() as RenderBox).size;
    await getDetailUser();
  }

  getDetailUser() async {
    showLoading();
    try {
      await repository.getDetailUser(user: user.value!).then((res) {
        hideLoading();
        user.value = res;
      });
    } catch (e) {
      hideLoading();
      AppDialog.show(
        typeDialog: TypeDialog.RETRY,
        dismissible: false,
        message: e.toString(),
        onCancel: (){
          AppDialog.close();
          Get.back();
        },
        onPress: () {
          AppDialog.close();
          getDetailUser();
        },
      );
    }
  }
}