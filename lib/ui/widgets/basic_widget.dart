import 'dart:io';

import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:varcore_flutter_base/core/app/app_constant.dart';
import 'package:varcore_flutter_base/core/themes/app_colors.dart';

Widget loadingIndicator =
    const SpinKitThreeBounce(size: 45, color: Colors.blue);

/// Loading widget based on platform (android or iOS)
Widget platformLoadingIndicator() {
  if (Platform.isAndroid) {
    return const Center(child: CircularProgressIndicator());
  } else {
    return const Center(child: CupertinoActivityIndicator(radius: 16));
  }
}

/// Double back to pop the navigation.
/// Use in the page that need to double Back
class DoubleBack extends StatelessWidget {
  const DoubleBack({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DoubleBackToCloseApp(
      snackBar: SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
        content: const Text("Tap sekali lagi untuk keluar.",
            textAlign: TextAlign.center),
      ),
      child: child,
    );
  }
}

class CircleIcon extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData? icon;
  final double? iconSize, size;
  final Color? backgroundColor, color, splashColor;

  const CircleIcon({
    Key? key,
    this.onPressed,
    required this.icon,
    this.backgroundColor = Colors.black,
    this.color = Colors.white,
    this.iconSize = 30,
    this.size = 56,
    this.splashColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: backgroundColor ?? Colors.black54.withOpacity(0.6),
        child: SizedBox(
          height: size,
          width: size,
          child: IconButton(
            onPressed: onPressed,
            splashColor: splashColor,
            icon: Icon(
              icon,
              size: iconSize,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}

/// Use this widget for give base padding every content in page.
/// not required when your page is list
class ContentWrapper extends StatelessWidget {
  final Widget? child;
  const ContentWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(
          AppConst.defaultMargin,
          0,
          AppConst.defaultMargin,
          AppConst.defaultMargin,
        ),
        child: child);
  }
}

class MyBox extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final EdgeInsets? padding;
  const MyBox({Key? key, this.child, this.padding, this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      color: (Get.isDarkMode) ? AppColors.baseDark : color,
      child: child,
    );
  }
}

class Countdown extends AnimatedWidget {
  Countdown({Key? key, required this.animation})
      : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${(clockTimer.inSeconds.remainder(60) % 60).toString().padLeft(2, '0')}';

    return Text(
      timerText,
      style: TextStyle(
        fontSize: 110,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
