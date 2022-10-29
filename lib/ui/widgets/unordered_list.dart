import 'package:flutter/material.dart';
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
  }) : super(key: key);

  final Map<String, String> data;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  @override
  Widget build(BuildContext context) {
    List<BulletText> children = [];

    for (var item in data.entries) {
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
        ),
      );
    }

    return Column(
      children: children,
    );
  }
}
