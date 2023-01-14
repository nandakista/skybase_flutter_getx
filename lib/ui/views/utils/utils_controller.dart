import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/download_manager/download_manager.dart';

class UtilsController extends GetxController {
  final currency = 125000;
  final imageFile = Rxn<File>();
  final currencyCtr = TextEditingController();

  final RxList pickedImages = <File>[].obs;

  RxDouble progressDownload = 0.0.obs;
  // Short time download
  String url1 = 'https://media.neliti.com/media/publications/249244-none-837c3dfb.pdf';
  // Long time download
  String url2 = 'https://dl.ymcdn.website/6018b1992a38ca03ded7c8fecf1ded61/ywh9dNpEX9c';

  listenDownload() {
    DownloadManager().downloadInfo.listen((task) {
      progressDownload.value = task.progress.toDouble()/100;
    });
  }

  downloadFile() async {
    try {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text("Mengunduh file"),
        ),
      );
      DownloadManager()
          .download(
            url: url1,
            onError: (errorMessage) {
              ScaffoldMessenger.of(Get.context!).showSnackBar(
                SnackBar(content: Text(errorMessage)),
              );
            },
          )
          .then((_) => DownloadManager().showDownloadedSnackBar());
      listenDownload();
    } on Exception catch (e) {
      debugPrint(e.toString());
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text("Tidak dapat mengunduh file"),
        ),
      );
    }
  }
}