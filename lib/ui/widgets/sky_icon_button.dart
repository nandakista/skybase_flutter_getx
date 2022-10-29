import 'package:flutter/material.dart';
import 'package:skybase/core/themes/app_colors.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class SkyIconButton extends StatelessWidget {
  /// Background color of button. Default value is primary color.
  final Color? color;

  /// Text color of leading icon, default value is white.
  final Color iconColor;

  /// Text color of button, default value is white.
  final Color? borderColor;

  /// Action or function that called when button pressed.
  final VoidCallback? onPressed;

  /// Width shape of button, default value is 70
  final double? height;

  /// Width shape of button, default value is match parent.
  final double? width;

  /// The radius of the button shape.
  final double? borderRadius;

  final double? borderWidth;

  /// Leading icon inside button.
  final IconData? icon;

  /// Leading icon with Widget
  final Widget? iconWidget;

  /// Change style button to outline mode
  final bool outlineMode;

  final EdgeInsetsGeometry? margin;

  final EdgeInsetsGeometry? padding;

  const SkyIconButton({
    Key? key,
    this.color = AppColors.primary,
    this.iconColor = Colors.white,
    this.onPressed,
    this.height = 24,
    this.width = 24,
    this.borderRadius,
    this.icon,
    this.iconWidget,
    this.outlineMode = false,
    this.margin,
    this.padding,
    this.borderColor,
    this.borderWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color:
            (outlineMode) ? Theme.of(context).scaffoldBackgroundColor : color,
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
        border: Border.all(
          color: (outlineMode)
              ? AppColors.primary
              : borderColor ?? Colors.transparent,
          width: borderWidth ?? 1.5,
          style: BorderStyle.solid,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
          onTap: onPressed,
          child: iconWidget ??
              Icon(
                icon,
                color: (outlineMode) ? AppColors.primary : iconColor,
                size: 18,
              ),
        ),
      ),
    );
  }
}
