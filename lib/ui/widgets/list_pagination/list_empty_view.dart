import 'package:flutter/material.dart';
import 'package:get/get.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class ListEmptyView extends StatelessWidget {
  const ListEmptyView({
    Key? key,
    this.emptyImage,
    this.emptyImageWidget,
    this.emptyTitle,
    this.emptySubtitle,
    this.isScrollable = true,
    this.imageSize,
    this.verticalSpacing = 24,
    this.horizontalSpacing = 24,
    this.titleStyle,
    this.subtitleStyle,
  }) : super(key: key);

  final Widget? emptyImageWidget;
  final String? emptyImage;
  final String? emptyTitle;
  final String? emptySubtitle;
  final bool isScrollable;
  final double? imageSize;
  final double verticalSpacing;
  final double horizontalSpacing;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: verticalSpacing,
          horizontal: horizontalSpacing,
        ),
        physics: (isScrollable)
            ? const NeverScrollableScrollPhysics()
            : const BouncingScrollPhysics(),
        child: Column(
          children: [
            emptyImageWidget ??
                Image.asset(
                  emptyImage ?? 'assets/images/img_empty.png',
                  height: imageSize,
                ),
            SizedBox(height: verticalSpacing),
            Text(
              emptyTitle ?? 'txt_empty_list_title'.tr,
              textAlign: TextAlign.center,
              style: titleStyle ?? Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: verticalSpacing / 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                emptySubtitle ?? 'txt_empty_list_subtitle'.tr,
                textAlign: TextAlign.center,
                style: subtitleStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
