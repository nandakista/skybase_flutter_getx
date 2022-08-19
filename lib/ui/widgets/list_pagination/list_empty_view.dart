import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/localization/language_const.dart';

class ListEmptyView extends StatelessWidget {
  const ListEmptyView({
    Key? key,
    this.emptyImage,
    this.emptyTitle,
    this.emptySubtitle,
    this.isScrollable = true,
  }) : super(key: key);

  final Widget? emptyImage;
  final String? emptyTitle;
  final String? emptySubtitle;
  final bool isScrollable;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        physics: (isScrollable)
            ? const NeverScrollableScrollPhysics()
            : const BouncingScrollPhysics(),
        child: Column(
          children: [
            emptyImage ??
                Image.asset('assets/images/img_empty.png'),
            const SizedBox(height: 24),
            Text(
              emptyTitle ?? International.emptyListTitle.tr,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Text(
              emptySubtitle ?? International.emptyListSubtitle.tr,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
