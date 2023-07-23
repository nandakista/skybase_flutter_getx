import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_controller.dart';
import 'package:skybase/ui/views/sample_feature/detail/widgets/sample_feature_detail_header.dart';
import 'package:skybase/ui/views/sample_feature/detail/widgets/sample_feature_detail_info.dart';
import 'package:skybase/ui/views/sample_feature/detail/widgets/sample_feature_detail_tab.dart';
import 'package:skybase/ui/widgets/base/sky_view.dart';
import 'package:skybase/ui/widgets/colored_status_bar.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';

class SampleFeatureDetailView extends GetView<SampleFeatureDetailController> {
  static const String route = '/user-detail';

  const SampleFeatureDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredStatusBar(
      child: Scaffold(
        appBar: SkyAppBar.primary(title: controller.user.value?.username),
        body: SafeArea(
          child: Obx(
            () => SkyView(
              loadingEnabled: controller.isLoading.isTrue,
              errorEnabled: controller.isError.isTrue,
              errorTitle: controller.errorMessage.value,
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
      ),
    );
  }
}
