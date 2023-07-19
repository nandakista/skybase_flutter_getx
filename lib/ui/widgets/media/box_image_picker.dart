import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skybase/core/helper/bottom_sheet_helper.dart';
import 'package:skybase/core/themes/app_style.dart';
import 'package:skybase/ui/widgets/media/image_source_bottom_sheet.dart';
import 'package:skybase/ui/widgets/sky_image.dart';

/* Created by
   Nanda K Permana
   05/11/2022
*/
typedef OnSelectedUiImage<T> = Function(
  File? file,
);

class BoxImagePicker extends StatelessWidget {
  const BoxImagePicker({
    Key? key,
    required this.text,
    this.icon,
    this.iconWidget,
    this.height = 100,
    this.width = 100,
    required this.onSelectedUiImage,
    this.withCompression = false,
    this.sizeLimit = 2000000,
    this.imageSource = ImageSource.gallery,
    this.imageQuality,
    this.replace = true,
  }) : super(key: key);

  final double height;
  final double width;
  final String text;
  final IconData? icon;
  final Widget? iconWidget;
  final OnSelectedUiImage onSelectedUiImage;
  final bool withCompression;
  final int sizeLimit;
  final ImageSource imageSource;
  final int? imageQuality;
  final bool replace;

  @override
  Widget build(BuildContext context) {
    final selectedImage = Rxn<File>();
    if (replace) {
      return Obx(
        () => (selectedImage.value != null)
            ? SkyImage(
                src: selectedImage.value!.path,
                height: height,
                width: width,
                borderRadius: BorderRadius.circular(4),
                enablePreview: true,
                onRemoveImage: () {
                  selectedImage.value = null;
                  onSelectedUiImage(null);
                },
              )
            : _buildBoxPicker(
                context,
                (image) {
                  selectedImage.value = image;
                  onSelectedUiImage(image);
                  Get.back();
                },
              ),
      );
    } else {
      return _buildBoxPicker(
        context,
        (image) {
          selectedImage.value = image;
          onSelectedUiImage(image);
          Get.back();
        },
      );
    }
  }

  _buildBoxPicker(BuildContext context, Function(File)? onSelected) {
    return GestureDetector(
      onTap: () async {
        BottomSheetHelper.cupertino(
          child: ImageSourceBottomSheet(
            onImageSelected: onSelected,
          ),
        );
      },
      child: DottedBorder(
        dashPattern: const [8],
        radius: const Radius.circular(4),
        borderType: BorderType.RRect,
        color: Colors.grey,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconWidget ?? const SizedBox.shrink(),
              icon != null ? Icon(icon) : const SizedBox.shrink(),
              const SizedBox(height: 8),
              Text(
                text,
                style: AppStyle.headline4.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
