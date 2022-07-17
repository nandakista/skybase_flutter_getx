import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:varcore_flutter_base/core/themes/app_colors.dart';

class CustomAppBar extends StatelessWidget {
  final Color? backgroundColor, textColor, iconColor;
  final VoidCallback? onPress;
  final String title;
  final List<Widget>? action;
  final bool centerTitle;

  const CustomAppBar({
    Key? key,
    this.onPress,
    this.title = '',
    this.iconColor,
    this.backgroundColor,
    this.textColor,
    this.action,
    this.centerTitle = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      title: Text(
        title,
        style: TextStyle(
            color: (textColor == null)
                ? (Get.isDarkMode)
                    ? Colors.white
                    : Colors.black
                : textColor),
      ),
      backgroundColor:
          (Get.isDarkMode) ? AppColors.baseDark : AppColors.baseLight,
      elevation: 0,
      leading: (Navigator.canPop(context))
          ? Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_rounded,
                      color: (iconColor == null)
                          ? Get.isDarkMode
                              ? AppColors.primary
                              : Colors.black
                          : iconColor),
                  onPressed: onPress ?? () => Get.back()),
            )
          : null,
      actions: action,
    );
  }
}
