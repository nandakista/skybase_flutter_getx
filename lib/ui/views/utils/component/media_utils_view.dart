import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:skybase/core/helper/bottom_sheet_helper.dart';
import 'package:skybase/core/modules/module_helper.dart';
import 'package:skybase/core/themes/app_colors.dart';
import 'package:skybase/core/themes/app_style.dart';
import 'package:skybase/ui/views/utils/utils_controller.dart';
import 'package:skybase/ui/widgets/media/box_image_picker.dart';
import 'package:skybase/ui/widgets/media/box_video_picker.dart';
import 'package:skybase/ui/widgets/media/image_source_bottom_sheet.dart';
import 'package:skybase/ui/widgets/media/media_items.dart';
import 'package:skybase/ui/widgets/media/preview/media_carousel_preview_page.dart';
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
      appBar: SkyAppBar.primary(title: 'Media Utility'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ..._buildImagePicker(context),
            const Divider(thickness: 1, height: 36),
            const SkyImage(),
            const Divider(thickness: 1, height: 36),
            MediaItems(
              maxItem: 5,
              mediaUrls: controller.sampleImage,
              onTap: (index) {
                Get.to(
                  () => MediaCarouselPreviewPage(
                    initialIndex: index,
                    url: controller.sampleImage,
                    bottomWidget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          'Name',
                          style: AppStyle.body1.copyWith(
                              fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        Expanded(
                          child: Text(
                            'Review description',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyle.headline4.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const Divider(thickness: 1, height: 36),
            const MediaItems(
              isGrid: true,
              mediaUrls: [
                'https://picsum.photos/200/200.jpg',
                'https://picsum.photos/200/200.jpg',
                'assets/images/img_sample.jpeg',
                'https://picsum.photos/200/200.jpg',
                'https://picsum.photos/200/200.jpg',
              ],
            ),
            const Divider(thickness: 1, height: 36),
            const MediaItems(
              size: 100,
              maxItem: 3,
              mediaUrls: [
                'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
                'assets/images/img_sample.jpeg',
                'https://picsum.photos/200/200.jpg',
                'https://picsum.photos/200/200.jpg',
                'https://picsum.photos/200/200.jpg',
                'assets/images/img_sample.jpeg',
                'https://picsum.photos/200/200.jpg',
              ],
            ),
            const SizedBox(height: 24),
            const SkyImage(src: 'assets/images/img_sample.jpeg'),
          ],
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
                    src: controller.imageFile.value!.path,
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
                        child: SkyImage(src: 'assets/images/img_man.png'),
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
            debugPrint('file = $file');
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
        const SizedBox(height: 12),
        BoxVideoPicker(
          replace: true,
          text: 'Add video',
          iconWidget: SvgPicture.asset(
            'assets/images/ic_add.svg',
            color: AppColors.primary,
          ),
          onSelectedVideo: (File? file) {
            debugPrint('Picked = $file');
          },
        ),
        const SizedBox(height: 12),
        BoxImagePicker(
          text: 'Add Photo',
          iconWidget: SvgPicture.asset(
            'assets/images/ic_add.svg',
            color: AppColors.primary,
          ),
          replace: true,
          onSelectedUiImage: (File? file) {
            debugPrint('Picked file = $file');
            if (file != null) {
              controller.imageFile.value = file;
              // controller.update();
            }
          },
        ),
        const SizedBox(height: 12),
        Obx(
          () => Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              ...controller.pickedImages
                  .map(
                    (e) => SkyImage(
                      src: e.path,
                      height: 100,
                      width: 100,
                      enablePreview: true,
                      borderRadius: BorderRadius.circular(4),
                      onRemoveImage: () {
                        controller.pickedImages.remove(e);
                        controller.update();
                      },
                    ),
                  )
                  .toList(),
              BoxImagePicker(
                text: 'Add Photos',
                iconWidget: SvgPicture.asset(
                  'assets/images/ic_add.svg',
                  color: AppColors.primary,
                ),
                replace: false,
                onSelectedUiImage: (File? file) {
                  debugPrint('Picked file = $file');
                  if (file != null) {
                    controller.pickedImages.add(file);
                    controller.update();
                  }
                },
              ),
            ],
          ),
        ),
      ];
}
