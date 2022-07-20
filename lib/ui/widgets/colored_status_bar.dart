import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:varcore_flutter_base/core/themes/app_colors.dart';

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
  final bool? coloredBottomBar;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    const defaultColor = AppColors.primary;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: color ?? defaultColor,
        statusBarIconBrightness: brightness,
        statusBarBrightness: brightness,
      ),
      child: Container(
        color: color ?? defaultColor,
        child: SafeArea(
          bottom: false,
          child: Container(
            child: child,
          ),
        ),
      ),
    );
  }
}
