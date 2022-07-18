import 'package:get/get.dart';
import 'package:varcore_flutter_base/core/helper/dialog_helper.dart';
import 'package:varcore_flutter_base/data/models/user/user.dart';
import 'package:varcore_flutter_base/data/repositories/user/user_repository.dart';
import 'package:varcore_flutter_base/ui/views/user/detail/user_detail_view.dart';

class UserListController extends GetxController {
  final UserRepository repository;
  UserListController({required this.repository});

  final RxList<User> listUser = <User>[].obs;
  final isLoading = false.obs;
  showLoading() => isLoading.toggle();
  hideLoading() => isLoading.toggle();

  @override
  void onReady() async {
    await getUser();
  }

  getUser() async {
    showLoading();
    try {
      await repository.getUsers().then((data) {
        hideLoading();
        listUser.value = data;
      });
    } catch (e) {
      hideLoading();
      AppDialog.show(
        typeDialog: TypeDialog.RETRY,
        message: e.toString(),
        dismissible: false,
        onCancel: () {
          AppDialog.close();
          Get.back();
        },
        onPress: () {
          AppDialog.close();
          getUser();
        },
      );
    }
  }

  onChooseUser({required User user}) {
    Get.toNamed(UserDetailView.route, arguments: user);
  }
}

