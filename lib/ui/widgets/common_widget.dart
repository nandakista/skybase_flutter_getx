import 'dart:io';

import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/

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
  final Widget icon;
  final double? size;
  final Color? backgroundColor, splashColor;

  const CircleIcon({
    Key? key,
    this.onPressed,
    required this.icon,
    this.backgroundColor = Colors.black,
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
            icon: icon,
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
  final bool top;
  final bool bottom;
  final double? marginTop;
  final double? marginBottom;

  const ContentWrapper({
    Key? key,
    required this.child,
    this.top = false,
    this.bottom = false,
    this.marginTop,
    this.marginBottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        24,
        top ? marginTop ?? 24 : 0,
        24,
        bottom ? marginBottom ?? 24 : 0,
      ),
      child: child,
    );
  }
}
