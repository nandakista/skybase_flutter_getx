import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

ReceivePort _port = ReceivePort();

class DownloadManager {
  static const String portName = "downloader_send_port";
  static final DownloadManager _singleton = DownloadManager._internal();

  factory DownloadManager() => _singleton;

  final StreamController<DownloadInfo> _eventController =
      StreamController<DownloadInfo>.broadcast();

  Stream<DownloadInfo> get downloadInfo {
    return _eventController.stream;
  }

  DownloadManager._internal() {
    IsolateNameServer.registerPortWithName(
      _port.sendPort,
      portName,
    );
    _port.listen(
      (data) {
        final id = data[0];
        final status = data[1];
        final progress = data[2];
        debugPrint('Id: $id\nStatus: $status\nProgress: $progress');
        _eventController.add(DownloadInfo(data[0], data[1], data[2]));
      },
    );
    FlutterDownloader.registerCallback(downloadCallback);
  }

  static Future<void> initDownloader() async {
    await FlutterDownloader.initialize(
      debug: true,
      ignoreSsl: true,
    );
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
    String id,
    DownloadTaskStatus status,
    int progress,
  ) {
    final SendPort? send = IsolateNameServer.lookupPortByName(portName);
    send?.send([id, status, progress]);
  }

  Future<String?> _findLocalPath() async {
    String? externalStorageDirPath;
    if (Platform.isAndroid) {
      try {
        externalStorageDirPath = await AndroidPathProvider.downloadsPath;
      } catch (e) {
        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    return externalStorageDirPath;
  }

  Future<bool> _checkPermission() async {
    if (Platform.isAndroid) {
      final requestPermission = await Permission.storage.request();

      return requestPermission.isGranted;
    } else {
      return true;
    }
  }

  Future<String?> download({
    required String url,
    required Function(String errorMessage) onError,
  }) async {
    try {
      final permissionGranted = await _checkPermission();
      if (!permissionGranted) {
        debugPrint('Cannot download file, permission not enabled');
        onError('txt_err_download_permission_msg'.tr);
        return null;
      }
      final fileName =
          "${DateTime.now().millisecondsSinceEpoch}_${p.basename(url).split("?").first}";
      final taskId = await FlutterDownloader.enqueue(
        url: url,
        fileName: fileName,
        savedDir: (await _findLocalPath())!,
        saveInPublicStorage: true,
        showNotification: true,
        openFileFromNotification: true,
      );
      return taskId;
    } on Exception catch (e) {
      debugPrint('Error downloading file: ${e.toString()}');
      onError('txt_err_download_msg'.tr);
      return null;
    }
  }

  Future<void> cancel(String taskId) async {
    await FlutterDownloader.cancel(taskId: taskId);
  }

  Future<void> retry(String taskId) async {
    await FlutterDownloader.retry(taskId: taskId);
  }

  Future<bool> open(String taskId) async {
    return FlutterDownloader.open(taskId: taskId);
  }

  Future<void> cancelAll(String taskId) async {
    return await FlutterDownloader.cancelAll();
  }

  Future<void> pause(String taskId) async {
    return await FlutterDownloader.pause(taskId: taskId);
  }

  Future<String?> resume(String taskId) async {
    return await FlutterDownloader.resume(taskId: taskId);
  }

  void showDownloadedSnackBar() {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text('txt_downloading'.tr),
      ),
    );
    late StreamSubscription<dynamic> subs;
    subs = DownloadManager().downloadInfo.listen((task) {
      if (task.status == DownloadTaskStatus.complete) {
        debugPrint(
            'Id: ${task.id}\nStatus: ${task.status}\nProgress: ${task.progress}');
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text('txt_download_file_success'.tr),
            action: SnackBarAction(
              label: 'txt_open_file'.tr,
              textColor: Colors.white,
              onPressed: () {
                DownloadManager().open(task.id);
              },
            ),
          ),
        );
        subs.cancel();
      } else if (task.status == DownloadTaskStatus.failed) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text('txt_failed_download_file'.tr),
          ),
        );
        subs.cancel();
      }
    });
  }
}

class DownloadInfo {
  final String id;
  final DownloadTaskStatus status;
  final int progress;

  DownloadInfo(this.id, this.status, this.progress);
}
