import 'package:flutter/material.dart';
import 'package:skybase/core/themes/app_colors.dart';
import 'package:skybase/core/themes/app_style.dart';
import 'package:skybase/ui/widgets/bullet_text.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class UnorderedList extends StatelessWidget {
  const UnorderedList({
    Key? key,
    required this.data,
    this.titleStyle,
    this.subtitleStyle,
    this.captionData,
    this.captionStyle,
  }) : super(key: key);

  final Map<String, String> data;
  final Map<String, String>? captionData;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final TextStyle? captionStyle;

  @override
  Widget build(BuildContext context) {
    List<BulletText> children = [];

    for (var item in data.entries) {
      String? caption;
      if (captionData?.containsKey(item.key) ?? false) {
        caption = captionData?.entries
            .where((element) => element.key == item.key)
            .first
            .value;
      }
      children.add(
        BulletText(
          title: Text(
            item.key,
            style: titleStyle ??
                AppStyle.headline4.copyWith(fontWeight: FontWeight.w400),
          ),
          subtitle: Text(
            item.value,
            style: subtitleStyle ?? AppStyle.body2,
          ),
          caption: (caption != null)
              ? Text(
                  caption.toString(),
                  style: captionStyle ??
                      AppStyle.body2.copyWith(
                        color: AppColors.accent,
                      ),
                )
              : const SizedBox.shrink(),
        ),
      );
    }

    return Column(
      children: children,
    );
  }
}
