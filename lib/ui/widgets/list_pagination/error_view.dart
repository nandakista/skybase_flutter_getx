import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/ui/widgets/sky_button.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class ErrorView extends StatelessWidget {
  const ErrorView({
    Key? key,
    this.errorImage,
    this.errorTitle,
    this.errorSubtitle,
    this.onRetry,
    this.isScrollable = true,
    this.retryText,
  }) : super(key: key);

  final Widget? errorImage;
  final String? errorTitle;
  final String? errorSubtitle;
  final String? retryText;
  final VoidCallback? onRetry;
  final bool isScrollable;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: (isScrollable)
            ? const NeverScrollableScrollPhysics()
            : const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            errorImage ?? Image.asset('assets/images/img_error.png'),
            const SizedBox(height: 24),
            const SizedBox(height: 24),
            Text(
              errorTitle ?? 'txt_err_general_formal'.tr,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              errorSubtitle ?? 'txt_tap_to_retry'.tr,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SkyButton(
              wrapContent: true,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              text: retryText ?? 'txt_retry'.tr,
              onPressed: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}
