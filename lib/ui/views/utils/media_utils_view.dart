import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/helper/bottom_sheet_helper.dart';
import 'package:skybase/core/localization/language_const.dart';
import 'package:skybase/core/modules/module_helper.dart';
import 'package:skybase/core/themes/app_colors.dart';
import 'package:skybase/ui/views/utils/utils_controller.dart';
import 'package:skybase/ui/widgets/common_widget.dart';
import 'package:skybase/ui/widgets/media/image_source_bottom_sheet.dart';
import 'package:skybase/ui/widgets/media/media_items.dart';
import 'package:skybase/ui/widgets/media/ui_image_picker.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/sky_box.dart';
import 'package:skybase/ui/widgets/sky_button.dart';
import 'package:skybase/ui/widgets/sky_image.dart';

class MediaUtilsView extends GetView<UtilsController> {
  const MediaUtilsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkyAppBar.secondary(title: 'Media Utility'),
      body: SingleChildScrollView(
        child: ContentWrapper(
          top: true,
          bottom: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ..._buildImagePicker(context),
              const Divider(thickness: 1, height: 36),
              const MediaItems(
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
              const Divider(thickness: 1, height: 36),
              const MediaItems(
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
              const Divider(thickness: 1, height: 36),
              const MediaItems(
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
              const SizedBox(height: 24),
              const SkyImage(url: 'assets/images/img_sample.jpeg'),
            ],
          ),
        ),
      ),
    );
  }

  _buildImagePicker(BuildContext context) => [
        const Text('Preview File'),
        const SizedBox(height: 4),
        Obx(
          () => Container(
            child: controller.imageFile.value != null
                ? SkyImage(
                    url: controller.imageFile.value!.path,
                    height: MediaQuery.of(context).size.width * 1 / 2,
                    width: MediaQuery.of(context).size.width * 2 / 3,
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.width * 1 / 2,
                    width: MediaQuery.of(context).size.width * 1 / 2,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(40.0),
                        child: SkyImage(url: 'assets/images/img_man.png'),
                      ),
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 12),
        SkyBox(
          borderRadius: 8,
          padding: const EdgeInsets.all(10),
          width: 140,
          onPressed: () {
            ModuleHelper.pickImage(showInfo: true).then((image) {
              if (image != null) {
                controller.imageFile.value = image;
              }
            });
          },
          child: Column(
            children: const [
              Icon(
                Icons.add_a_photo_outlined,
                size: 30,
                color: AppColors.primary,
              ),
              Text('Module Camera', textAlign: TextAlign.center)
            ],
          ),
        ),
        const SizedBox(height: 4),
        UiImagePicker(
          onSelected: (file) {
            log('file = $file');
            controller.imageFile.value = file;
          },
          child: const SkyBox(
            margin: EdgeInsets.all(4),
            child: Text('UI Image Picker'),
          ),
        ),
        const SizedBox(height: 4),
        SkyButton(
          text: 'Image BottomSheet',
          onPressed: () {
            BottomSheetHelper.material(
              child: ImageSourceBottomSheet(
                onImageSelected: (image) {
                  controller.imageFile.value = image;
                  Get.back();
                },
              ),
            );
          },
        ),
      ];
}
