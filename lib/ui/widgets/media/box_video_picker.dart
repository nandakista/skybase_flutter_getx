import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/ui/widgets/sky_video.dart';

/* Created by
   Nanda K Permana
   05/11/2022
*/
typedef OnSelectedVideo<T> = Function(
  File? file,
);

class BoxVideoPicker extends StatelessWidget {
  const BoxVideoPicker({
    Key? key,
    required this.text,
    this.icon,
    this.iconWidget,
    this.height = 100,
    this.width = 100,
    required this.onSelectedVideo,
    this.source = ImageSource.gallery,
    this.replace = true,
  }) : super(key: key);

  final double height;
  final double width;
  final String text;
  final IconData? icon;
  final Widget? iconWidget;
  final OnSelectedVideo onSelectedVideo;
  final ImageSource source;
  final bool replace;

  @override
  Widget build(BuildContext context) {
    final selectedImage = Rxn<File>();
    if (replace) {
      return Obx(
        () => (selectedImage.value != null)
            ? SkyVideo(
                url: selectedImage.value!.path,
                height: height,
                width: width,
                showControls: false,
                enablePreview: true,
                onRemoveVideo: () {
                  selectedImage.value = null;
                  onSelectedVideo(null);
                },
              )
            : _buildBoxPicker(
                (file) {
                  selectedImage.value = file;
                  onSelectedVideo(file);
                },
              ),
      );
    } else {
      return _buildBoxPicker(
        (file) {
          selectedImage.value = file;
          onSelectedVideo(file);
        },
      );
    }
  }

  _buildBoxPicker(Function(File) onSelected) {
    return GestureDetector(
      onTap: () async {
        await _pickVideo(
          ImageSource.gallery,
          (file) async {
            onSelected(file);
          },
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

  Future _pickVideo(ImageSource source, Function(File) onPick) async {
    final pickedFile = await ImagePicker().pickVideo(source: source);
    if (pickedFile == null) {
      return;
    }
    File file = File(pickedFile.path);
    onPick(file);
  }
}
