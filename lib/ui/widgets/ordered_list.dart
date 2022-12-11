import 'package:flutter/material.dart';
import 'package:skybase/core/themes/app_style.dart';
import 'package:skybase/ui/widgets/number_tile.dart';

class OrderedList extends StatelessWidget {
  const OrderedList({
    Key? key,
    this.title,
    required this.data,
  }) : super(key: key);

  final String? title;
  final List<String> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(title!=null) Text('$title :', style: AppStyle.headline4),
        if(title!=null) const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data.length,
          padding: const EdgeInsets.only(bottom: 12),
          itemBuilder: (context, index) {
            return NumberTile(
              number: index + 1,
              title: data[index],
              titleStyle: AppStyle.body1,
              padding: EdgeInsets.zero,
              verticalSpacing: 2,
            );
          },
        ),
      ],
    );
  }
}
