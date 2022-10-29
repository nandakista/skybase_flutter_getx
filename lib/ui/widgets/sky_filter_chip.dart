import 'package:flutter/material.dart';

class SkyFilterChip extends StatelessWidget {
  const SkyFilterChip({
    Key? key,
    required this.onSelected,
    required this.child,
    required this.selected,
  }) : super(key: key);

  final void Function(bool) onSelected;
  final Widget child;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (selected) {
          onSelected(false);
        } else {
          onSelected(true);
        }
      },
      child: child,
    );
  }
}