import 'dart:io';

import 'package:flutter/material.dart';

class AdaptivePopScope extends StatelessWidget {
  const AdaptivePopScope({
    super.key,
    required this.child,
    this.canPop = false,
    this.onBack,
  });

  final bool canPop;
  final Widget child;

  /// Only called if you set [canPop] to false,
  /// otherwise if you set [canPop] to true, the code inside [onBack] never called and
  /// the behavior is back like default behavior
  /// <br>
  ///
  /// **Note:**
  ///
  /// iOS and android have different behavior when set [canPop=false] and [onBack != null]
  /// - Android : Can gesture back
  /// - iOS : Can not gesture back
  ///
  /// More details on : https://github.com/flutter/flutter/issues/138624
  final void Function()? onBack;


  @override
  Widget build(BuildContext context) {
    // The change is base on https://docs.flutter.dev/release/breaking-changes/android-predictive-back so ios should be fine
    if (Platform.isIOS) {
      if (canPop) {
        return _defaultPopScope(canPop: canPop, child: child, onBack: onBack);
      } else {
        // ignore: deprecated_member_use
        return WillPopScope(
          onWillPop: () async {
            onBack?.call();
            return false;
          },
          child: child,
        );
      }
    }
    return _defaultPopScope(canPop: canPop, child: child, onBack: onBack);
  }

  Widget _defaultPopScope({required Widget child,
    required bool canPop,
    Function? onBack,}) {
    return PopScope(
      canPop: canPop,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        onBack?.call();
      },
      child: child,
    );
  }
}
