import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:skybase/core/database/hive/hive_box.dart';
import 'package:skybase/core/localization/language_const.dart';
import 'package:skybase/core/themes/app_colors.dart';
import 'package:skybase/core/themes/app_style.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/ui/views/sample_feature/list/sample_feature_list_controller.dart';
import 'package:skybase/ui/widgets/cached_image.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/base/sky_pagination_view.dart';

class SampleFeatureListView extends GetView<SampleFeatureListController> {
  static const String route = '/user-list';
  const SampleFeatureListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkyAppBar.secondary(title: International.userList.tr),
      body: SkyPaginationView<SampleFeature>(
        pagingController: controller.pagingController,
        onRefresh: () => controller.refreshPage(),
        itemBuilder: (BuildContext context, item, int index) {
          return ListTile(
            onTap: () => controller.onChooseUser(user: item),
            leading: CircleAvatar(
              radius: 30,
              child: CachedImage(url: '${item.avatarUrl}&s=200'),
            ),
            title: Text(item.username.toString()),
            subtitle: Text(
              item.gitUrl.toString(),
              style: AppStyle.small,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.delete, color: Colors.white),
        backgroundColor: AppColors.primary,
        onPressed: () {
          Hive.box<SampleFeature>(HiveBox.user).clear();
        },
      ),
    );
  }
}
