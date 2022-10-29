import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/ui/views/utils/utils_controller.dart';
import 'package:skybase/ui/widgets/common_widget.dart';
import 'package:skybase/ui/widgets/media/media_items.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';

class UtilsView2 extends GetView<UtilsController> {
  const UtilsView2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkyAppBar.secondary(title: 'Utils 2'),
      body: SingleChildScrollView(
        child: ContentWrapper(
          top: true,
          bottom: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              MediaItems(
                maxItem: 5,
                mediaUrls: [
                  'assets/images/img_sample.jpeg',
                  'assets/images/img_sample.jpeg',
                  'assets/images/img_sample.jpeg',
                  'assets/images/img_sample.jpeg',
                  'assets/images/img_sample.jpeg',
                  'assets/images/img_sample.jpeg',
                ],
              ),
              Divider(thickness: 1, height: 36),
              MediaItems(
                isGrid: true,
                mediaUrls: [
                  'assets/images/img_sample.jpeg',
                  'assets/images/img_sample.jpeg',
                  'assets/images/img_sample.jpeg',
                  'assets/images/img_sample.jpeg',
                  'assets/images/img_sample.jpeg',
                  'assets/images/img_sample.jpeg',
                ],
              ),
              Divider(thickness: 1, height: 36),

              MediaItems(
                size: 100,
                maxItem: 3,
                mediaUrls: [
                  'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
                  'assets/images/img_sample.jpeg',
                  'assets/images/img_sample.jpeg',
                  'assets/images/img_sample.jpeg',
                  'assets/images/img_sample.jpeg',
                  'assets/images/img_sample.jpeg',
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
