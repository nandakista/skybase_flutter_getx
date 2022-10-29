import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/localization/language_const.dart';
import 'package:skybase/core/themes/app_style.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class PaginationMaxItemView extends StatelessWidget {
  const PaginationMaxItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Text(
          International.maxItem.tr,
          style: AppStyle.subtitle4.copyWith(
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
