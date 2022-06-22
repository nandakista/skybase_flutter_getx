import 'package:get/get.dart';
import 'package:varcore_flutter_base/core/helper/dialog_helper.dart';
import 'package:varcore_flutter_base/data/data_sources/user/user_datasource.dart';
import 'package:varcore_flutter_base/data/models/user.dart';

class UserListController extends GetxController {
  final UserDatasource datasource;
  UserListController({required this.datasource});

  final RxList<User> listUser = <User>[].obs;

  @override
  void onReady() async {
    await getUser();
  }

  getUser() async {
    Loading.show();
    try {
      await datasource.getUsers().then((res) {
        Loading.hide();
        listUser.value = res;
      });
    } catch (e) {
      Loading.hide();
      AppDialog.show(
        typeDialog: TypeDialog.FAILED,
        message: e.toString(),
        onPress: () {
          AppDialog.close();
          Get.back();
        },
      );
    }
  }

  onChooseUser({required User user}) {
    Get.back(result: user);
  }
}
