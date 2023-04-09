import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/data/models/global/picker_data.dart';
import 'package:skybase/ui/widgets/picker/sky_filter_chip.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
enum GridPickerType {
  single,
  multiple,
  radio,
}

typedef SMFilterItemBuilder<T> = Widget Function(
  T item,
);

typedef SMFilterOnChanged<T> = Function(
  BuildContext context,
  int index,
  T? firstItem,
  List<T?> listItem,
);

class PickerGridView<T> extends StatelessWidget {
  const PickerGridView({
    Key? key,
    required this.type,
    required this.data,
    required this.child,
    required this.onChanged,
    this.widthItem,
    this.heightItem,
    this.crossAxisSpacing,
    this.mainAxisSpacing = 0.0,
    this.shrinkWrap = false,
    this.physics,
    this.initialValue,
  }) : super(key: key);

  final GridPickerType type;
  final List<PickerData<T>> data;
  final SMFilterItemBuilder<PickerData<T>> child;
  final SMFilterOnChanged<T> onChanged;
  final double? widthItem;
  final double? heightItem;
  final double? crossAxisSpacing;
  final double mainAxisSpacing;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final PickerData<T>? initialValue;

  @override
  Widget build(BuildContext context) {
    _setInitial();
    RxList<PickerData<T>> tempData = data.obs;
    return Obx(
      () => GridView.builder(
        shrinkWrap: shrinkWrap,
        physics: physics,
        itemCount: tempData.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: widthItem ?? 200,
          mainAxisExtent: heightItem ?? 50,
          crossAxisSpacing: crossAxisSpacing ?? 8,
          mainAxisSpacing: mainAxisSpacing,
        ),
        itemBuilder: (context, index) {
          final item = tempData[index];
          return SkyFilterChip(
            isRadio: (type == GridPickerType.radio) ? true : false,
            selected: item.isSelected,
            onSelected: (isSelected) {
              if (type != GridPickerType.multiple) {
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
                tempData
                    .firstWhereOrNull((element) => element.isSelected && element.isAvailable)
                    ?.data,
                tempData
                    .where((element) => element.isSelected && element.isAvailable)
                    .map((e) => e.data)
                    .toList(),
              );
            },
            child: child(item),
          );
        },
      ),
    );
  }

  void _setInitial() {
    if (initialValue != null) {
      int index =
          data.indexWhere((element) => element.data == initialValue?.data);
      data[index] = PickerData(
        isSelected: true,
        index: initialValue?.index,
        data: initialValue?.data,
      );
    }
  }
}
