import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/database/get_storage/get_storage_manager.dart';
import 'package:skybase/config/themes/app_colors.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/data/sources/local/cached_key.dart';
import 'package:skybase/ui/widgets/shimmer/shimmer_list.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/sky_image.dart';

import 'sample_feature_list_basic_controller.dart';

class SampleFeatureListBasicView
    extends GetView<SampleFeatureListBasicController> {
  static const String route = '/user-list';

  const SampleFeatureListBasicView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkyAppBar.secondary(title: 'txt_list_users'.tr),
      body: Obx(
        () => _buildList(
          keepAlive: false,
          loadingView: const ShimmerList(),
          isLoading: controller.isLoading.value,
          onRefresh: () => Future.sync(controller.getUsers),
          itemCount: controller.datas.length ?? 0,
          itemBuilder: (context, index) {
            final item = controller.datas[index];
            return ListTile(
              onTap: () => controller.onChooseUser(
                id: item.id,
                username: item.username,
              ),
              leading: SkyImage(
                shapeImage: ShapeImage.circle,
                size: 30,
                src: '${item.avatarUrl}&s=200',
              ),
              title: Text(item.username),
              subtitle: Text(
                item.gitUrl ?? '',
                style: AppStyle.body2,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          GetStorageManager.find.delete(CachedKey.SAMPLE_FEATURE_LIST);
          GetStorageManager.find.delete(CachedKey.SAMPLE_FEATURE_DETAIL);
        },
        child: const Icon(Icons.delete, color: Colors.white),
      ),
    );
  }

  Widget _buildList({
    required Future<void> Function() onRefresh,
    required ItemListBuilder itemBuilder,
    required int itemCount,
    bool keepAlive = true,
    bool isLoading = false,
    Widget? loadingView,
  }) {
    return Platform.isIOS
        ? _buildIOSList(
            onRefresh: onRefresh,
            itemBuilder: itemBuilder,
            itemCount: itemCount,
            keepAlive: keepAlive,
            loadingView: loadingView,
            isLoading: isLoading,
          )
        : _buildAndroidList(
            onRefresh: onRefresh,
            itemBuilder: itemBuilder,
            itemCount: itemCount,
            keepAlive: keepAlive,
            loadingView: loadingView,
            isLoading: isLoading,
          );
  }

  Widget _buildIOSList({
    required Future<void> Function() onRefresh,
    required ItemListBuilder itemBuilder,
    required int itemCount,
    required bool keepAlive,
    required isLoading,
    Widget? loadingView,
  }) {
    return CustomScrollView(
      slivers: [
        CupertinoSliverRefreshControl(onRefresh: onRefresh),
        (!isLoading || keepAlive)
            ? SliverList(
                delegate: SliverChildBuilderDelegate(
                  itemBuilder,
                  childCount: itemCount,
                ),
              )
            : SliverToBoxAdapter(
                child:
                    loadingView ?? const CupertinoActivityIndicator(radius: 16),
              ),
      ],
    );
  }

  Widget _buildAndroidList({
    required Future<void> Function() onRefresh,
    required ItemListBuilder itemBuilder,
    required int itemCount,
    required bool keepAlive,
    required isLoading,
    Widget? loadingView,
  }) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        itemBuilder: (keepAlive || !isLoading)
            ? itemBuilder
            : (context, index) =>
                loadingView ??
                const Center(
                  child: CircularProgressIndicator(),
                ),
        itemCount: (keepAlive)
            ? itemCount
            : !isLoading
                ? itemCount
                : 1,
      ),
    );
  }
}

typedef ItemListBuilder = Widget Function(
  BuildContext context,
  int index,
);
