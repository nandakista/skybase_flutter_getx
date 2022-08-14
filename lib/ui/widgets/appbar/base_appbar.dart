
import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BaseAppBar({
    Key? key,
    this.title,
    this.action,
    this.backgroundColor,
    this.centerTitle = false,
    this.titleStyle,
    this.iconColor,
    this.elevation,
  }) : super(key: key);

  final String? title;
  final Color? backgroundColor;
  final List<Widget>? action;
  final bool? centerTitle;
  final Color? iconColor;
  final TextStyle? titleStyle;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      title: Text(
        title ?? '',
        style: titleStyle,
      ),

      backgroundColor: backgroundColor,
      elevation: elevation,
      actions: action,
      iconTheme: IconThemeData(
        color: iconColor, //change your color here
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}