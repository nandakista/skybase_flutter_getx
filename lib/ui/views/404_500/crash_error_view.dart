import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/config/themes/generated/assets.gen.dart';
import 'package:skybase/ui/widgets/sky_image.dart';

class CrashErrorView extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  const CrashErrorView({
    super.key,
    required this.errorDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Get.theme.colorScheme.surface,
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SkyImage(
              src: Assets.images.imgError.path,
              height: 144,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              kDebugMode
                  ? errorDetails.summary.toString()
                  : "txt_crash_error_title".tr,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge?.copyWith(
                color: kDebugMode
                    ? Get.theme.colorScheme.error
                    : Get.theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              kDebugMode
                  ? errorDetails.exceptionAsString()
                  : "txt_crash_error_message".tr,
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
