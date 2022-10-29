import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skybase/core/themes/app_colors.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/

/// Wrap your Scaffold to this widget for set Status Bar color in specific pages.
class ColoredStatusBar extends StatelessWidget {
  const ColoredStatusBar({
    Key? key,
    required this.child,
    this.color = AppColors.primary,
    this.brightness = Brightness.dark,
    this.coloredBottomBar = false,
  }) : super(key: key);

  /// Background color of Status Bar
  final Color? color;

  /// Icon Color in Status Bar.
  ///
  /// Brightness.dark == Icon White.
  ///
  /// Brightness.light == Icon Black
  final Brightness brightness;

  /// Color of bottom bar (under navigation bar).
  final bool coloredBottomBar;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Brightness _iconBrightness;
    if (Platform.isIOS) {
      (brightness == Brightness.dark)
          ? _iconBrightness = Brightness.light
          : _iconBrightness = Brightness.dark;
    } else {
      _iconBrightness = brightness;
    }
    const defaultColor = AppColors.primary;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: color ?? defaultColor,
        statusBarIconBrightness: _iconBrightness,
        statusBarBrightness: _iconBrightness,
      ),
      child: Container(
        color: color ?? defaultColor,
        child: SafeArea(
          left: false,
          right: false,
          bottom: coloredBottomBar,
          child: child,
        ),
      ),
    );
  }
}
