import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:skybase/ui/widgets/sky_button.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class PaginationErrorView extends StatelessWidget {
  const PaginationErrorView({
    Key? key,
    required this.controller,
    this.errorTitle,
    this.errorSubtitle,
    this.errorImage,
    this.errorImageWidget,
    this.verticalSpacing = 24,
    this.horizontalSpacing = 24,
    this.imageSize,
    this.titleStyle,
    this.subtitleStyle,
    this.retryWidget,
    this.retryText,
  }) : super(key: key);

  final String? errorImage;
  final Widget? errorImageWidget;
  final String? errorTitle;
  final String? errorSubtitle;
  final PagingController controller;
  final double verticalSpacing;
  final double horizontalSpacing;
  final double? imageSize;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final Widget? retryWidget;
  final String? retryText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          vertical: verticalSpacing,
          horizontal: horizontalSpacing,
        ),
        child: Column(
          children: [
            errorImageWidget ??
                Image.asset(
                  errorImage ?? 'assets/images/img_error.png',
                  height: imageSize,
                ),
            SizedBox(height: verticalSpacing),
            Text(
              '${errorTitle ?? controller.error ?? 'txt_err_general_formal'.tr}',
              textAlign: TextAlign.center,
              style: titleStyle ?? Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Text(
              errorSubtitle ?? 'txt_tap_retry'.tr,
              textAlign: TextAlign.center,
              style: subtitleStyle,
            ),
            SizedBox(height: verticalSpacing),
            retryWidget ?? SkyButton(
              wrapContent: true,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              text: retryText ?? 'txt_retry'.tr,
              onPressed: () => controller.retryLastFailedRequest(),
            ),
          ],
        ),
      ),
    );
  }
}
