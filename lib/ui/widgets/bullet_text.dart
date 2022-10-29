import 'package:flutter/material.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class BulletText extends StatelessWidget {
  const BulletText({
    Key? key,
    required this.title,
    this.subtitle,
    this.horizontalSpacing = 8,
    this.verticalSpacing = 4,
    this.margin,
    this.padding,
  }) : super(key: key);

  final Widget title;
  final Widget? subtitle;
  final double horizontalSpacing;
  final double verticalSpacing;
  final EdgeInsetsGeometry? margin, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding ?? const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.circle, size: 8),
              SizedBox(width: horizontalSpacing),
              title,
            ],
          ),
          SizedBox(height: verticalSpacing),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8 + (horizontalSpacing),
            ),
            child: subtitle,
          )
        ],
      ),
    );
  }
}
