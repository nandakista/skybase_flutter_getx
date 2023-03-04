import 'package:skybase/core/helper/dialog_helper.dart';

class SafeRequestAPI {
  /// For update cache data.
  /// Just create function for request API and Insert to Database and pass that function to [functionUpdate]

  /// Function for call api without try fetch.
  /// Just create function for request API and pass it to [functionUpdate] and it will be process.
  static void call(Future<void> Function() functionUpdate) async {
    try {
      await functionUpdate();
    } catch (e) {
      SkyDialog.show(
          type: DialogType.FAILED,
          message: e.toString(),
          onConfirm: () => SkyDialog.dismiss());
      rethrow;
    }
  }

  /// Function for call api without try fetch.
  /// It's useful when you need to call API outside features like download, etc.
  /// Return the value of Response API.
  Future<dynamic> callWithReturn(Function() function) async {
    try {
      return await function();
    } catch (e) {
      SkyDialog.show(
        type: DialogType.FAILED,
        message: e.toString(),
        onConfirm: () {
          SkyDialog.dismiss();
        },
      );
      rethrow;
    }
  }
}