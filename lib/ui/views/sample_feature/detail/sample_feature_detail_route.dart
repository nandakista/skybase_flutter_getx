import 'package:get/get.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_binding.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_view.dart';

final sampleFeatureDetailPage = [
  GetPage(
    name: SampleFeatureDetailView.route,
    page: () => const SampleFeatureDetailView(),
    binding: SampleFeatureDetailBinding(),
  ),
];