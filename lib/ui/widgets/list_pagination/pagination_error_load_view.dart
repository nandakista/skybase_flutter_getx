import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/localization/language_const.dart';

class PaginationErrorLoadView extends StatelessWidget {
  const PaginationErrorLoadView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Text(
          International.errGeneralFormal.tr,
          style: const TextStyle(color: Colors.grey),
        ),
        Text(
          International.tapRetry.tr,
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 4),
        const Icon(
          CupertinoIcons.refresh_thick,
          color: Colors.grey,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
