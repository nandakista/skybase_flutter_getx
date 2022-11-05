// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

/* Created by
   Varcant
   05/11/2022
   nanda.kista@gmail.com
*/

enum SortBy {
    ASC,
    DESC,
}

class SkyGroupedListView<T, G> extends StatelessWidget {
  const SkyGroupedListView({
    Key? key,
    required this.elements,
    required this.groupBy,
    required this.groupHeaderBuilder,
    required this.itemBuilder,
    this.controller,
    this.sortBy = SortBy.ASC,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
    this.separator,
    this.separatorGroup,
  }) : super(key: key);

  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final List<T> elements;
  final Widget Function(G element) groupHeaderBuilder;
  final Widget Function(BuildContext context, int index, T element) itemBuilder;
  final ScrollController? controller;
  final SortBy sortBy;
  final G Function(T element) groupBy;
  final EdgeInsetsGeometry? padding;
  final Widget? separator;
  final Widget? separatorGroup;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: shrinkWrap,
      physics: physics,
      padding: padding ?? const EdgeInsets.all(0),
      itemCount: elements.length,
      controller: controller,
      reverse: sortBy == SortBy.ASC ? false : true,
      itemBuilder: (_, index) {
        (elements).sort(
          (b, a) => (groupBy(b) as dynamic)!.compareTo(
            groupBy(a),
          ),
        );

        bool isSame = true;
        final G item = groupBy(elements[index]);

        G prevItem;
        if (index != 0) {
          prevItem = groupBy(elements[index - 1]);
          isSame = item == prevItem;
        } else {
          prevItem = item;
          isSame = item == prevItem;
        }

        if (sortBy == SortBy.ASC) {
          return Column(
            children: [
              if (index == 0) _buildHeaderWidget(item),
              if (!isSame) _buildHeaderWidget(item),
              _buildItemWidget(context, index),
              if (index + 1 != elements.length)
                _buildSeparatorWidget(separator),
            ],
          );
        } else {
          return Column(
            children: [
              if (index + 1 == elements.length) _buildHeaderWidget(item),
              _buildItemWidget(context, index),
              if (!isSame) _buildHeaderWidget(prevItem),
              if (index != 0) _buildSeparatorWidget(separator),
            ],
          );
        }
      },
    );
  }

  _buildHeaderWidget(G item) {
    return Column(
      children: [
        SizedBox(width: double.infinity, child: groupHeaderBuilder(item)),
        _buildSeparatorWidget(separatorGroup),
      ],
    );
  }

  _buildItemWidget(BuildContext context, int index) {
    return SizedBox(
      width: double.infinity,
      child: itemBuilder(context, index, elements[index]),
    );
  }

  _buildSeparatorWidget(Widget? item) {
    return SizedBox(
      width: double.infinity,
      child: item ?? const SizedBox.shrink(),
    );
  }
}
