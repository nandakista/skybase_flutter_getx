import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:varcore_flutter_base/core/app/app_constant.dart';
import 'package:varcore_flutter_base/core/themes/app_style.dart';

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
  final Function onPressed;
  final IconData? icon;
  final double? iconSize, size;
  final Color? backgroundColor, color;

  const CircleIcon(
      {Key? key,
      required this.onPressed,
      required this.icon,
      this.backgroundColor = Colors.black,
      this.color = Colors.white,
      this.iconSize = 30,
      this.size = 56})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: backgroundColor,
        child: InkWell(
          splashColor: Colors.grey, // Splash color
          onTap: () => onPressed(),
          child: Container(
              color: backgroundColor ?? Colors.black54.withOpacity(0.6),
              width: size,
              height: size,
              child: Icon(
                icon,
                size: iconSize,
                color: color,
              )),
        ),
      ),
    );
  }
}

class Content extends StatelessWidget {
  final Widget? child;
  const Content({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(
            defaultMargin, 0, defaultMargin, defaultMargin),
        child: child);
  }
}

class CustomAppBar extends StatelessWidget {
  final Color? backgroundColor, textColor, iconColor;
  final Function onPress;
  final String title;
  final List<Widget>? action;

  const CustomAppBar(
      {Key? key,
      required this.onPress,
      this.title = "",
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
      backgroundColor: (Get.isDarkMode) ? baseDarkColor : baseLightColor,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded,
                color: (iconColor == null)
                    ? Get.isDarkMode
                        ? primaryColor
                        : Colors.black
                    : iconColor),
            onPressed: () => onPress()),
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
      color: (Get.isDarkMode) ? baseDarkColor : color,
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
