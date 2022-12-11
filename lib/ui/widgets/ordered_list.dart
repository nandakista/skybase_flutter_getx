import 'package:flutter/material.dart';
import 'package:skybase/core/themes/app_style.dart';
import 'package:skybase/ui/widgets/number_tile.dart';

class OrderedList extends StatelessWidget {
  const OrderedList({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    this.numberStyle,
    this.spacing = 8,
    this.itemMargin,
    this.itemPadding,
  }) : super(key: key);

  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final TextStyle? numberStyle;
  final double spacing;
  final EdgeInsetsGeometry? itemMargin;
  final EdgeInsetsGeometry? itemPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: itemCount,
          padding: const EdgeInsets.only(bottom: 12),
          itemBuilder: (context, index) {
            return NumberTile(
              number: index + 1,
              child: itemBuilder(context, index),
              numberStyle: AppStyle.body1,
              horizontalSpacing: spacing,
              margin: itemMargin,
              padding: itemPadding ?? EdgeInsets.zero,
            );
          },
        ),
      ],
    );
  }
}
