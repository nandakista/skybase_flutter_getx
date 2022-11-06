import 'package:flutter/material.dart';
import 'package:skybase/core/themes/app_colors.dart';
import 'package:skybase/core/themes/app_style.dart';

class NumberTile extends StatelessWidget {
  const NumberTile({
    Key? key,
    required this.number,
    required this.title,
    this.horizontalSpacing = 8,
    this.verticalSpacing = 4,
    this.subtitle,
    this.caption,
    this.margin,
    this.padding,
    this.titleStyle,
    this.subtitleStyle,
    this.captionStyle,
  }) : super(key: key);

  final int number;
  final String title;
  final String? subtitle;
  final String? caption;
  final double horizontalSpacing;
  final double verticalSpacing;
  final EdgeInsetsGeometry? margin, padding;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final TextStyle? captionStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding ?? const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: horizontalSpacing * 2,
                child: Text(
                  number.toString() + '.',
                  style: titleStyle ??
                      AppStyle.headline4,
                ),
              ),
              SizedBox(width: horizontalSpacing),
              Expanded(
                child: Text(
                  title,
                  style: titleStyle ??
                      AppStyle.headline4,
                ),
              ),
            ],
          ),
          SizedBox(height: verticalSpacing),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8 + (horizontalSpacing),
            ),
            child: (subtitle != null)
                ? Text(
                    subtitle.toString(),
                    style: subtitleStyle ?? AppStyle.body1,
                  )
                : const SizedBox.shrink(),
          ),
          SizedBox(height: verticalSpacing / 2),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8 + (horizontalSpacing),
            ),
            child: (caption != null)
                ? Text(
                    caption.toString(),
                    style: captionStyle ??
                        AppStyle.body2.copyWith(
                          color: AppColors.accent,
                        ),
                  )
                : const SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}
