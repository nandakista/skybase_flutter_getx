import 'package:flutter/material.dart';
import 'package:skybase/core/themes/app_colors.dart';
import 'package:skybase/ui/widgets/sky_box.dart';

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
    this.onTap, this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        child,
        if (visible)
          SkyBox(
            borderRadius: borderRadius,
            onPressed: onTap,
            padding: const EdgeInsets.all(0),
            color: Colors.black12,
            child: const Center(
              child: Icon(
                Icons.play_circle,
                color: AppColors.primary,
                size: 36,
              ),
            ),
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }
}
