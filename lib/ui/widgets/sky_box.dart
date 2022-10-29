import 'package:flutter/material.dart';

class SkyBox extends StatelessWidget {
  const SkyBox({
    Key? key,
    required this.child,
    this.margin,
    this.padding,
    this.borderRadius,
    this.width,
    this.height,
    this.onPressed,
    this.color,
    this.gradient,
    this.borderColor,
  }) : super(key: key);

  final Widget? child;
  final EdgeInsetsGeometry? margin, padding;
  final double? borderRadius;
  final double? width;
  final double? height;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? borderColor;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        margin: margin,
        padding: padding ?? const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          gradient: gradient,
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
          border: Border.all(
            color: borderColor ?? Colors.grey.shade300,
          ),
        ),
        child: child,
      ),
    );
  }
}
