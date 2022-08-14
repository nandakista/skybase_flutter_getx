import 'package:flutter/material.dart';

class CustomRadioField extends StatelessWidget {
  final Widget child;
  final String title;
  final double? elevation;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final bool useBorder;

  const CustomRadioField({
    Key? key,
    required this.child,
    required this.title,
    this.elevation,
    this.borderColor = Colors.grey,
    this.borderWidth = 1,
    this.useBorder = false,
    this.borderRadius = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.5,
      child: (useBorder)
          ? Card(
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(
            color: borderColor,
            width: borderWidth,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            child,
            Text(title),
          ],
        ),
      )
          : Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          child,
          Text(title),
        ],
      ),
    );
  }
}