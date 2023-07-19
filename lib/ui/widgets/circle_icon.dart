import 'package:flutter/material.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class CircleIcon extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget icon;
  final double? size;
  final Color? backgroundColor, splashColor;

  const CircleIcon({
    Key? key,
    this.onPressed,
    required this.icon,
    this.backgroundColor = Colors.black,
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
            icon: icon,
          ),
        ),
      ),
    );
  }
}
