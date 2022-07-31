import 'package:flutter/material.dart';
import 'package:varcore_flutter_base/core/helper/filter/filter_action_result.dart';

class BottomSheetHelper {
  static show(BuildContext context, {required Widget child}) async {
    await showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (btmContext) => Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(child: child),
      ),
    );
  }

  static Future<FilterResult> filter(BuildContext context, {required Widget child}) async {
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
    if(result != null) {
      return FilterResult(action: FilterAction.submit, value: result);
    } else {
      return FilterResult(action: FilterAction.cancel, value: []);
    }
  }
}
