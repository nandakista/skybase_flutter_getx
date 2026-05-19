import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/config/themes/app_colors.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';
import 'package:skybase/core/extension/context_extension.dart';
import 'package:skybase/data/sources/local/cached_key.dart';
import 'package:skybase/ui/views/github_user/github_user_controller.dart';
import 'package:skybase/ui/widgets/base/error_config.dart';
import 'package:skybase/ui/widgets/base/pagination/pagination_grid_view.dart';
import 'package:skybase/ui/widgets/shimmer/sample_feature/shimmer_sample_feature_list.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/sky_box.dart';
import 'package:skybase/ui/widgets/sky_image.dart';

class GithubUserView extends GetView<GithubUserController> {
  static const String route = '/github-user';

  const GithubUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkyAppBar.secondary(title: 'Github Users (Manual)'),
      body: Obx(
        () => PaginationGridView(
          state: controller.state.value,
          scrollController: controller.scrollController,
          onRefresh: controller.onRefresh,
          onLoadMore: controller.onLoadMore,
          itemCount: controller.dataList.length,
          allLoaded: controller.allLoaded.value,
          errorConfig: ErrorConfig(subtitle: controller.errorMessage.value),
          loadingView: const ShimmerSampleFeatureList(),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          sliverGridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 180,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (BuildContext context, int index) {
            final item = controller.dataList[index];
            return SkyBox(
              onPressed: () =>
                  controller.onChooseUser(id: item.id, username: item.username),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SkyImage(
                    shapeImage: ShapeImage.circle,
                    size: 30,
                    src: '${item.avatarUrl}&s=200',
                  ),
                  const SizedBox(height: 4),
                  Text(item.username.toString(), textAlign: TextAlign.center),
                  const SizedBox(height: 4),
                  Flexible(
                    child: Text(
                      item.gitUrl.toString(),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: context.typography.body2,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 12,
          children: [
            FloatingActionButton(
              heroTag: 'clear_cache',
              backgroundColor: AppColors.primary,
              onPressed: () {
                StorageManager.find.delete(CachedKey.SAMPLE_FEATURE_LIST);
                StorageManager.find.delete(CachedKey.SAMPLE_FEATURE_DETAIL);
              },
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            FloatingActionButton(
              heroTag: 'search',
              backgroundColor: AppColors.primary,
              onPressed: () {
                controller.onUpdateSearch(search: 'ada');
              },
              child: const Icon(Icons.search, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
