import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/helper/general_function.dart';
import 'package:skybase/core/helper/sky_snackbar.dart';
import 'package:skybase/ui/widgets/circle_icon.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class PreviewCameraPage extends StatelessWidget {
  final File imageFile;
  final bool showInfo;
  const PreviewCameraPage({
    Key? key,
    required this.imageFile,
    required this.showInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.file(
                File(imageFile.path),
                // fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 150,
              width: double.infinity,
              color: Colors.black.withOpacity(0.3),
              padding: const EdgeInsets.all(25),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleIcon(
                        onPressed: () => Get.back(),
                        backgroundColor: Colors.white,
                        icon: const Icon(
                          Icons.close,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                      CircleIcon(
                        onPressed: () async {
                          if (showInfo) {
                            showImageInfo(context);
                          }
                          Get.back(result: File(imageFile.path));
                        },
                        backgroundColor: Colors.white,
                        icon: const Icon(
                          Icons.check,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  showImageInfo(BuildContext context) async {
    // Show Image Info
    String size = await AppFunction.getFileSize(imageFile.path, 2);
    SkySnackBar.show(message: '$size, ${imageFile.path}');
  }
}
