import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/data/models/global/picker_data.dart';
import 'package:skybase/ui/widgets/picker/sky_filter_chip.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
typedef SMFilterItemBuilder<T> = Widget Function(
  T item,
);

typedef SMFilterOnChanged<T> = Function(
  BuildContext context,
  int index,
  List<PickerData<T>> item,
);

class PickerListView<T> extends StatelessWidget {
  const PickerListView({
    Key? key,
    required this.data,
    required this.isMultiple,
    required this.itemBuilder,
    required this.onChanged,
    this.widthItem,
    this.heightItem,
    this.shrinkWrap = false,
    this.physics,
    this.separator,
  }) : super(key: key);

  final List<PickerData<T>> data;
  final SMFilterItemBuilder<PickerData<T>> itemBuilder;
  final SMFilterOnChanged<T> onChanged;
  final bool isMultiple;
  final double? widthItem;
  final double? heightItem;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final Widget? separator;

  @override
  Widget build(BuildContext context) {
    RxList<PickerData<T>> tempData = data.obs;
    return Obx(
      () => ListView.separated(
        shrinkWrap: shrinkWrap,
        physics: physics,
        itemCount: tempData.length,
        separatorBuilder: (BuildContext context, int index) {
          return separator ?? const SizedBox.shrink();
        },
        itemBuilder: (context, index) {
          final item = tempData[index];
          return SkyFilterChip(
            selected: item.isSelected,
            onSelected: (bool isSelected) {
              if (!isMultiple) {
                for (var element in tempData) {
                  element.isSelected = false;
                }
              }
              tempData.value = tempData.map(
                (otherChip) {
                  return item == otherChip
                      ? otherChip.copy(isSelected: isSelected)
                      : otherChip;
                },
              ).toList();
              onChanged(
                context,
                index,
                tempData.where((element) => element.isSelected).toList(),
              );
            },
            child: itemBuilder(item),
          );
        },
      ),
    );
  }
}
