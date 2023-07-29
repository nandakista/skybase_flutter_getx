import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skybase/core/helper/media_helper.dart';

class ImageSourceBottomSheet extends StatelessWidget {
  final double? maxHeight;
  final double? maxWidth;
  final int? imageQuality;
  final CameraDevice preferredCameraDevice;
  final void Function(Uint8List)? onImageBytesSelected;
  final void Function(File)? onImageSelected;

  final Widget? cameraIcon;
  final Widget? galleryIcon;
  final Widget? cameraLabel;
  final Widget? galleryLabel;
  final bool withCompression;
  final int sizeLimit;

  const ImageSourceBottomSheet({
    Key? key,
    this.maxHeight,
    this.maxWidth,
    this.imageQuality,
    this.preferredCameraDevice = CameraDevice.rear,
    this.onImageBytesSelected,
    this.onImageSelected,
    this.cameraIcon = const Icon(Icons.camera_alt_rounded),
    this.galleryIcon = const Icon(Icons.image),
    this.cameraLabel,
    this.galleryLabel,
    this.withCompression = false,
    this.sizeLimit = 2000000,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        ListTile(
          leading: cameraIcon,
          title: cameraLabel ?? Text('txt_camera'.tr),
          onTap: () => _onPickImage(ImageSource.camera),
        ),
        ListTile(
          leading: galleryIcon,
          title: galleryLabel ?? Text('txt_gallery'.tr),
          onTap: () => _onPickImage(ImageSource.gallery),
        ),
      ],
    );
  }

  Future<void> _onPickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
      maxHeight: withCompression ? 1024 : maxHeight,
      maxWidth: withCompression ? 1024 : maxWidth,
      imageQuality: imageQuality,
      preferredCameraDevice: preferredCameraDevice,
    );
    if (null != pickedFile) {
      if (kIsWeb) {
        if (null != onImageBytesSelected) {
          Uint8List imageBytes = await pickedFile.readAsBytes();
          if (withCompression) {
            imageBytes = await MediaHelper.compressBytes(imageBytes);
          }
          onImageBytesSelected!(imageBytes);
        }
      } else {
        if (null != onImageSelected) {
          // Warning:  this will not work on the web platform because pickedFile
          // will instead point to a network resource.
          File imageFile = File(pickedFile.path);
          if (withCompression) {
            imageFile = await MediaHelper.compressImage(
              file: imageFile,
              limit: sizeLimit,
            );
          }
          onImageSelected!(imageFile);
        }
      }
    }
  }
}
