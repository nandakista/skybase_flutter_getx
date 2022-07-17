import 'package:flutter/material.dart';
import 'package:varcore_flutter_base/core/themes/app_colors.dart';
import 'package:varcore_flutter_base/core/themes/app_style.dart';

///  Default button on this project with primary color.
///  Change it as needed.
class CustomButton extends StatelessWidget {

  /// Background color of button. Default value is primary color.
  final Color color;

  /// Text color of button, default value is white.
  final Color textColor;

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

  /// The size of text button.
  final double? fontSize;

  /// The radius of the button shape.
  final double? borderRadius;

  /// Elevation value of button.
  final double? elevation;

  /// Leading icon inside button.
  final IconData? icon;

  /// Font weight text and icon inside button.
  final FontWeight? fontWeight;

  const CustomButton({
    Key? key,
    required this.onPressed,
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
        onPressed: onPressed,
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
