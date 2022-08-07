import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skybase/core/helper/general_function.dart';

class UiImagePicker extends StatelessWidget {

  final Function(File)? onSelected;
  final Widget child;
  final bool withCompression;
  final int sizeLimit;

  const UiImagePicker({ 
    Key? key,
    this.onSelected,
    required this.child,
    this.withCompression = false,
    this.sizeLimit = 2000000,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _pickImage(ImageSource.gallery, (file) async {
          if(withCompression) {
            file = await AppFunction.compressImage(file: file, limit: sizeLimit);
          }
          onSelected!.call(file);
        });
      },
      child: child,
    );
  }

  Future _pickImage(ImageSource source, Function(File) onPick) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
      maxWidth: withCompression ? 1024 : null,
      maxHeight: withCompression ? 1024 : null
    );
    if (pickedFile == null) {
      return;
    }
    var image = File(pickedFile.path);
    onPick(image);
  }
}