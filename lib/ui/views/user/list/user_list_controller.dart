import 'dart:developer';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:skybase/core/base/base_list_controller.dart';
import 'package:skybase/data/models/user/user.dart';
import 'package:skybase/data/repositories/user/user_repository.dart';
import 'package:skybase/ui/views/user/detail/user_detail_view.dart';

class UserListController extends BaseListController<User> {
  final UserRepository repository;
  UserListController({required this.repository});

  @override
  void getListData() async {
    try {
      await repository.getUsers(page: page, perPage: perPage).then((data) {
        loadNextData(data);
      });
    } catch (e) {
      log('Error : $e');
      pagingController.error = e;
    }
  }

  onChooseUser({required User user}) {
    Get.toNamed(UserDetailView.route, arguments: user);
  }
}
