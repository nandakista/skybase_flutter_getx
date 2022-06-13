import 'package:flutter/material.dart';
import 'package:varcore_flutter_base/core/themes/app_colors.dart';
import 'package:varcore_flutter_base/core/themes/app_style.dart';

class CustomButton extends StatelessWidget {
  final Color color, textColor, iconColor;
  final VoidCallback? onPress;
  final String text;
  final double? height, width, fontSize, borderRadius, elevation;
  final IconData? icon;
  final FontWeight? fontWeight;

  const CustomButton({
    Key? key,
    required this.onPress,
    required this.text,
    this.icon,
    this.color = AppColors.primary,
    this.iconColor = Colors.white,
    this.textColor = Colors.white,
    this.height = 70,
    this.width = double.infinity,
    this.fontSize,
    this.fontWeight,
    this.borderRadius = 8,
    this.elevation = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      child: ElevatedButton.icon(
        icon: Visibility(
          visible: (icon != null),
          child: Icon(
            icon,
            color: iconColor,
          ),
        ),
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          padding: (icon != null)
              ? const EdgeInsets.symmetric(horizontal: 10, vertical: 10)
              : const EdgeInsets.fromLTRB(0, 10, 10, 10),
          minimumSize: Size(MediaQuery.of(context).size.width, 0),
          primary: color,
          fixedSize: Size(width ?? MediaQuery.of(context).size.width, height!),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
        ),
        label: Text(
          text,
          textAlign: TextAlign.center,
          style: AppStyle.subtitle4.copyWith(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
