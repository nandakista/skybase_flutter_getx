import 'package:flutter/material.dart';
import 'package:skybase/core/themes/app_colors.dart';
import 'package:skybase/core/themes/app_style.dart';

///  Default button on this project with primary color.
///  Change it as needed.
class SkyButton extends StatelessWidget {
  /// Background color of button. Default value is primary color.
  final Color? color;

  /// Text color of button, default value is white.
  final Color textColor;

  /// Text color of button, default value is white.
  final Color? borderColor;

  /// Text color of leading icon, default value is white.
  final Color iconColor;

  /// Action or function that called when button pressed.
  final VoidCallback? onPressed;

  /// Display text in button.
  final String text;

  /// Width shape of button, default value is 70
  final double? height;

  /// Width shape of button, default value is match parent.
  final double? width;

  final double? borderWidth;

  /// The size of text button.
  final double? fontSize;

  /// The radius of the button shape.
  final double? borderRadius;

  /// Elevation value of button.
  final double? elevation;

  /// Leading icon inside button.
  final IconData? icon;

  /// Leading icon with Widget
  final Widget? iconWidget;

  /// Font weight text and icon inside button.
  final FontWeight? fontWeight;

  final EdgeInsetsGeometry? margin;

  final EdgeInsetsGeometry? padding;

  /// Width of button
  final bool wrapContent;

  /// Change style button to outline mode
  final bool outlineMode;

  const SkyButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.color = AppColors.primary,
    this.iconColor = Colors.white,
    this.textColor = Colors.white,
    this.height = 55,
    this.width = double.infinity,
    this.fontSize,
    this.fontWeight,
    this.borderRadius = 8,
    this.elevation = 1,
    this.margin,
    this.padding,
    this.wrapContent = false,
    this.borderColor,
    this.borderWidth,
    this.iconWidget,
    this.outlineMode = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (wrapContent) ? null : width,
      height: height,
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      margin: margin,
      child: ElevatedButton.icon(
        icon: Visibility(
          visible: (iconWidget != null || icon != null),
          child: iconWidget ??
              Icon(
                icon,
                color: (outlineMode) ? AppColors.primary : iconColor,
              ),
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          backgroundColor:
              (outlineMode) ? Theme.of(context).scaffoldBackgroundColor : color,
          padding: (icon != null || iconWidget != null)
              ? const EdgeInsets.symmetric(horizontal: 10, vertical: 10)
              : const EdgeInsets.fromLTRB(0, 10, 10, 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
            side: BorderSide(
              color: (outlineMode)
                  ? AppColors.primary
                  : borderColor ?? Colors.transparent,
              width: borderWidth ?? 1.5,
              style: BorderStyle.solid,
            ),
          ),
        ),
        label: Container(
          padding: padding,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: AppStyle.subtitle4.copyWith(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: outlineMode ? AppColors.primary : textColor,
            ),
          ),
        ),
      ),
    );
  }
}
