import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_controller.dart';
import 'package:skybase/ui/views/sample_feature/detail/widgets/sample_feature_detail_header.dart';
import 'package:skybase/ui/views/sample_feature/detail/widgets/sample_feature_detail_info.dart';
import 'package:skybase/ui/views/sample_feature/detail/widgets/sample_feature_detail_tab.dart';
import 'package:skybase/ui/widgets/base/state_view.dart';
import 'package:skybase/ui/widgets/shimmer/sample_feature/shimmer_sample_feature_detail.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';

class SampleFeatureDetailView extends GetView<SampleFeatureDetailController> {
  static const String route = '/user-detail';

  const SampleFeatureDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkyAppBar.primary(title: controller.usernameArgs),
      body: SafeArea(
        child: Obx(
          () => StateView.page(
            loadingEnabled: controller.isLoading,
            errorEnabled: controller.isError,
            emptyEnabled: controller.isEmpty,
            loadingView: const ShimmerSampleFeatureDetail(),
            errorTitle: controller.errorMessage.value,
            onRefresh: () => controller.onRefresh(),
            onRetry: () => controller.onRefresh(),
            child: const Column(
              children: [
                SampleFeatureDetailHeader(),
                SampleFeatureDetailInfo(),
                SampleFeatureDetailTab(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
