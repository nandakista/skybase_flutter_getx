import 'package:get/get.dart';
import 'package:skybase/ui/views/sample_feature/list/sample_feature_list_binding.dart';
import 'package:skybase/ui/views/sample_feature/list/sample_feature_list_view.dart';

final sampleFeatureRoute = [
  GetPage(
    name: SampleFeatureListView.route,
    page: () => const SampleFeatureListView(),
    binding: SampleFeatureListBinding(),
    participatesInRootNavigator: true,
  ),
];