import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:skybase/core/localization/language_const.dart';

class PaginationEmptyView extends StatelessWidget {
  const PaginationEmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SvgPicture.asset('assets/images/img_search_no_result.svg'),
            const SizedBox(height: 24),
            Text(
              International.emptyListTitle.tr,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Text(
              International.emptyListSubtitle.tr,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
