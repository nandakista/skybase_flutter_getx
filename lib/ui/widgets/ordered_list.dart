import 'package:flutter/material.dart';
import 'package:skybase/config/themes/app_style.dart';
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
    this.shrinkWrap = false,
    this.physics,
    this.scrollDirection = Axis.vertical,
    this.separator,
  }) : super(key: key);

  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final TextStyle? numberStyle;
  final double spacing;
  final EdgeInsetsGeometry? itemMargin;
  final EdgeInsetsGeometry? itemPadding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final Axis scrollDirection;
  final Widget? separator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.separated(
          shrinkWrap: shrinkWrap,
          physics: physics,
          scrollDirection: scrollDirection,
          itemCount: itemCount,
          separatorBuilder: (BuildContext context, int index) {
            return separator ?? const SizedBox.shrink();
          },
          padding: const EdgeInsets.only(bottom: 12),
          itemBuilder: (context, index) {
            return NumberTile(
              number: index + 1,
              numberStyle: AppStyle.body1,
              horizontalSpacing: spacing,
              margin: itemMargin,
              padding: itemPadding ?? EdgeInsets.zero,
              child: itemBuilder(context, index),
            );
          },
        ),
      ],
    );
  }
}
