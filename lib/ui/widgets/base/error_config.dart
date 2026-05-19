/* Created by
   Varcant
   nanda.kista@gmail.com
*/

import 'package:flutter/widgets.dart';

class ErrorConfig {
  final Widget? imageWidget;
  final String? image;
  final String? title;
  final String? subtitle;
  final double? imageHeight;
  final double? imageWidth;
  final double? verticalSpacing;
  final double? horizontalSpacing;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final String? retryText;
  final Widget? retryWidget;
  final void Function()? onRetry;

  const ErrorConfig({
    this.imageWidget,
    this.image,
    this.title,
    this.subtitle,
    this.imageHeight,
    this.imageWidth,
    this.verticalSpacing,
    this.horizontalSpacing,
    this.titleStyle,
    this.subtitleStyle,
    this.retryText,
    this.retryWidget,
    this.onRetry,
  });
}
