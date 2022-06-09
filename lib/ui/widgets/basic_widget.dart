import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:varcore_flutter_base/core/app/app_constant.dart';
import 'package:varcore_flutter_base/core/themes/app_colors.dart';

Widget loadingIndicator =
    const SpinKitThreeBounce(size: 45, color: Colors.blue);

class CustomCard extends StatelessWidget {
  final Color? borderColor, backgroundColor;
  final Widget? child;
  final double? borderRadius;
  final double? elevation;
  final EdgeInsetsGeometry? padding;

  const CustomCard({
    Key? key,
    this.borderColor,
    this.backgroundColor = Colors.white,
    this.borderRadius = 12,
    this.child,
    this.padding,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      elevation: elevation ?? 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius!),
      ),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius!),
          // color: backgroundColor,
          color: (Get.isDarkMode)
              ? context.theme.dialogBackgroundColor
              : Colors.white,
        ),
        child: child,
      ),
    );
  }
}

class CircleIcon extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData? icon;
  final double? iconSize, size;
  final Color? backgroundColor, color, splashColor;

  const CircleIcon({
    Key? key,
    this.onPressed,
    required this.icon,
    this.backgroundColor = Colors.black,
    this.color = Colors.white,
    this.iconSize = 30,
    this.size = 56,
    this.splashColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: backgroundColor ?? Colors.black54.withOpacity(0.6),
        child: SizedBox(
          height: size,
          width: size,
          child: IconButton(
            onPressed: onPressed,
            splashColor: splashColor,
            icon: Icon(
              icon,
              size: iconSize,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}

class ContentWrapper extends StatelessWidget {
  final Widget? child;
  const ContentWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(AppConst.defaultMargin, 0,
            AppConst.defaultMargin, AppConst.defaultMargin),
        child: child);
  }
}

class CustomAppBar extends StatelessWidget {
  final Color? backgroundColor, textColor, iconColor;
  final VoidCallback? onPress;
  final String title;
  final List<Widget>? action;

  const CustomAppBar(
      {Key? key,
      required this.onPress,
      this.title = '',
      this.iconColor,
      this.backgroundColor,
      this.textColor,
      this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
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
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded,
                color: (iconColor == null)
                    ? Get.isDarkMode
                        ? AppColors.primary
                        : Colors.black
                    : iconColor),
            onPressed: onPress),
      ),
      actions: action,
    );
  }
}

class MyBox extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final EdgeInsets? padding;
  const MyBox({Key? key, this.child, this.padding, this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      color: (Get.isDarkMode) ? AppColors.baseDark : color,
      child: child,
    );
  }
}

class Countdown extends AnimatedWidget {
  Countdown({Key? key, required this.animation})
      : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${(clockTimer.inSeconds.remainder(60) % 60).toString().padLeft(2, '0')}';

    return Text(
      timerText,
      style: TextStyle(
        fontSize: 110,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
