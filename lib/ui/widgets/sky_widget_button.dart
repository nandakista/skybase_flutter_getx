import 'package:flutter/material.dart';
import 'package:skybase/config/themes/app_colors.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class SkyWidgetButton extends StatelessWidget {
  final Color? color;
  final Color iconColor;
  final Color? borderColor;
  final VoidCallback? onPressed;
  final double? height;
  final double? width;
  final double? borderRadius;
  final double? borderWidth;

  // Only can assign if [child] is null
  final IconData? icon;

  // If child is not null and icon is not null, the value of icon will be ignored
  final Widget? child;

  final bool outlineMode;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const SkyWidgetButton({
    Key? key,
    this.color = AppColors.primary,
    this.iconColor = Colors.white,
    this.onPressed,
    this.height = 24,
    this.width = 24,
    this.borderRadius,
    this.icon,
    this.child,
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
          child: child ??
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
