import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class PaginationErrorLoadView extends StatelessWidget {
  const PaginationErrorLoadView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Text(
          'txt_err_general_formal'.tr,
          style: const TextStyle(color: Colors.grey),
        ),
        Text(
          'txt_tap_retry'.tr,
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
