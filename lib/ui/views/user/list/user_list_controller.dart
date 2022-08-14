import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:skybase/data/data_sources/local/user/user_dao.dart';
import 'package:skybase/data/data_sources/local/user/user_dao_impl.dart';
import 'package:skybase/data/models/user/user.dart';
import 'package:skybase/data/repositories/user/user_repository.dart';
import 'package:skybase/ui/views/user/detail/user_detail_view.dart';

class UserListController extends GetxController {
  final UserRepository repository;
  UserListController({required this.repository});

  // Pagination
  int perPage = 20;
  int page = 1;
  final pagingController = PagingController<int, User>(firstPageKey: 0);

  @override
  void onInit() {
    pagingController.addPageRequestListener((page) {
      getUser();
    });
    super.onInit();
  }

  refreshPage() {
    page = 1;
    pagingController.refresh();
    getUser();
  }

  getUser() async {
    try {
      await repository.getUsers(page: page, perPage: perPage).then((data) {
        final isLastPage = data.length < perPage;
        if (isLastPage) {
          pagingController.appendLastPage(data);
        } else {
          final nextPageKey = page++;
          pagingController.appendPage(data, nextPageKey);
        }
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
