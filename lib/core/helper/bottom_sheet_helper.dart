import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:skybase/core/helper/filter/filter_action_result.dart';
import 'package:skybase/core/themes/app_shadows.dart';
import 'package:skybase/ui/widgets/basic_widget.dart';

class BottomSheetHelper {
  static basic({
    required Widget child,
    bool isDismissible = true,
    bool isScrollControlled = true,
    Color? backgroundColor = Colors.transparent,
    Color? barrierColor,
  }) async {
    await showModalBottomSheet(
      context: Get.context!,
      isDismissible: isDismissible,
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor,
      barrierColor: barrierColor,
      builder: (btmContext) => Container(
        color: Theme.of(Get.context!).scaffoldBackgroundColor,
        child: SafeArea(child: child),
      ),
    );
  }

  static Future<FilterResult> filter(BuildContext context,
      {required Widget child}) async {
    final result = await showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (btmContext) => Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                child,
              ],
            ),
          ),
        ),
      ),
    );
    if (result != null) {
      return FilterResult(action: FilterAction.submit, value: result);
    } else {
      return FilterResult(action: FilterAction.cancel, value: []);
    }
  }

  static Future cupertino({
    required Widget child,
    bool isDismissible = true,
    bool isScrollControlled = true,
    bool enableDrag = true,
    bool enableBack = true,
    Color? barrierColor,
  }) async {
    return await showCupertinoModalBottomSheet(
      context: Get.context!,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      topRadius: const Radius.circular(24),
      duration: const Duration(milliseconds: 600),
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      barrierColor: barrierColor,
      builder: (btmContext) => WillPopScope(
        onWillPop: () async {
          return enableBack;
        },
        child: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.only(top: 12),
                  height: 6,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              ContentWrapper(
                top: true,
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
