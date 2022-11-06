import 'package:flutter/material.dart';
import 'package:skybase/core/themes/app_colors.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class PlayOverlay extends StatelessWidget {
  final Widget child;
  final bool visible;
  final VoidCallback? onTap;
  final double? borderRadius;

  const PlayOverlay({
    Key? key,
    required this.child,
    required this.visible,
    this.onTap,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        child,
        if (visible)
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(borderRadius ?? 12),
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.play_circle,
                  color: AppColors.primary,
                  size: 36,
                ),
              ),
            ),
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }
}
