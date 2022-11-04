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
    List<PickerData<T>> list,
    PickerData<T> item,
    );

class PickerListView<T> extends StatelessWidget {
  const PickerListView({
    Key? key,
    required this.data,
    required this.child,
    required this.onChanged,
    required this.isMultiple,
    this.widthItem,
    this.heightItem,
    this.shrinkWrap = false,
    this.physics,
  }) : super(key: key);

  final List<PickerData<T>> data;
  final SMFilterItemBuilder<PickerData<T>> child;
  final SMFilterOnChanged<T> onChanged;
  final bool isMultiple;
  final double? widthItem;
  final double? heightItem;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    RxList<PickerData<T>> tempData = data.obs;
    List<PickerData<T>> pickedData = [];
    return Obx(
      () => ListView.separated(
        shrinkWrap: shrinkWrap,
        physics: physics,
        itemCount: tempData.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(thickness: 1, height: 16);
        },
        itemBuilder: (context, index) {
          final item = tempData[index];
          return SkyFilterChip(
            selected: item.isSelected,
            onSelected: (bool isSelected) {
              _resetSelected(tempData);
              _setSelectedData(tempData, item, isSelected);
              _setPickedData(tempData, pickedData);
              onChanged(pickedData, pickedData.last);
            },
            child: child(item),
          );
        },
      ),
    );
  }

  void _resetSelected(RxList<PickerData<T>> tempData) {
    if (!isMultiple) {
      for (var element in tempData) {
        element.isSelected = false;
      }
    }
  }

  void _setSelectedData(
    RxList<PickerData<T>> tempData,
    PickerData<T> item,
    bool isSelected,
  ) {
    tempData.value = tempData.map(
      (otherChip) {
        return item == otherChip
            ? otherChip.copy(isSelected: isSelected)
            : otherChip;
      },
    ).toList();
  }

  void _setPickedData(
    RxList<PickerData<T>> temptData,
    List<PickerData<T>> pickedData,
  ) {
    if (isMultiple) {
      pickedData.clear();
      pickedData.addAll(temptData.where((p0) => p0.isSelected));
    } else {
      pickedData.clear();
      pickedData.add(temptData.where((p0) => p0.isSelected).last);
    }
  }
}
