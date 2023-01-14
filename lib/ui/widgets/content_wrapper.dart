import 'package:flutter/material.dart';

/// Use this widget for give base padding every content in page.
/// not required when your page is list
class ContentWrapper extends StatelessWidget {
  final Widget? child;
  final bool top;
  final bool bottom;
  final double? marginTop;
  final double? marginBottom;

  const ContentWrapper({
    Key? key,
    required this.child,
    this.top = false,
    this.bottom = false,
    this.marginTop,
    this.marginBottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        24,
        top ? marginTop ?? 24 : 0,
        24,
        bottom ? marginBottom ?? 24 : 0,
      ),
      child: child,
    );
  }
}
