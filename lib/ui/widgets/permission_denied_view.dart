import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'sky_button.dart';

class PermissionDeniedView extends StatelessWidget {
  const PermissionDeniedView({
    super.key,
    required this.title,
    required this.message,
    required this.onRequest,
    this.buttonTitle,
  });

  final String title;
  final String message;
  final String? buttonTitle;
  final VoidCallback onRequest;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SkyButton(
              text: buttonTitle ?? 'txt_request_permission'.tr,
              onPressed: onRequest,
            ),
          ],
        ),
      ),
    );
  }
}
