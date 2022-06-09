import 'package:flutter/material.dart';
import 'package:varcore_flutter_base/core/themes/app_colors.dart';
import 'package:varcore_flutter_base/core/themes/app_style.dart';

class CustomButton extends StatelessWidget {
  final Color color, textColor;
  final VoidCallback? onPress;
  final String text;
  final double? height, width;
  final FontWeight? fontWeight;
  final double? fontSize;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPress,
    this.color = AppColors.primary,
    this.fontSize,
    this.textColor = Colors.white,
    this.height = 60,
    this.fontWeight,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: width,
      // height: height,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Wrap(
          children: [
            ElevatedButton(
                onPressed: onPress,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  primary: color,
                  fixedSize:
                      Size(width ?? MediaQuery.of(context).size.width, height!),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(text,
                    textAlign: TextAlign.center,
                    style: AppStyle.subtitle4.copyWith(
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                        color: (color == Colors.white)
                            ? Colors.black
                            : textColor))),
          ],
        ),
      ),
    );
  }
}

class CustomButtonIcon extends StatelessWidget {
  final Color color, textColor, iconColor;
  final VoidCallback onPress;
  final String text;
  final double height, width;
  final IconData icon;

  const CustomButtonIcon({
    Key? key,
    required this.onPress,
    required this.text,
    required this.icon,
    this.color = AppColors.primary,
    this.iconColor = Colors.white,
    this.textColor = Colors.white,
    this.height = 60,
    this.width = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ElevatedButton.icon(
            icon: Icon(
              icon,
              color: iconColor,
            ),
            onPressed: () {
              onPress();
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              minimumSize: Size(MediaQuery.of(context).size.width, 0),
              primary: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            label: Text(text,
                style: AppStyle.subtitle4
                    .copyWith(fontWeight: FontWeight.bold, color: textColor))),
      ),
    );
  }
}
