import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/base/base_controller.dart';
import 'package:skybase/core/helper/dialog_helper.dart';
import 'package:skybase/data/models/user/user.dart';
import 'package:skybase/data/repositories/user/user_repository.dart';

class UserDetailController extends BaseController {
  final UserRepository repository;
  UserDetailController({required this.repository});

  final GlobalKey headerKey = GlobalKey();
  final GlobalKey detailInfoKey = GlobalKey();
  final headerWidget = Rxn<Size>();
  final detailInfoWidget = Rxn<Size>();

  final user = Rxn<User>();

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