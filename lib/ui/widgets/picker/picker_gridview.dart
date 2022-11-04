import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/data/models/global/picker_data.dart';
import 'package:skybase/ui/widgets/picker/picker_listview.dart';
import 'package:skybase/ui/widgets/picker/sky_filter_chip.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class PickerGridView<T> extends StatelessWidget {
  const PickerGridView({
    Key? key,
    required this.data,
    required this.child,
    required this.onChanged,
    this.isMultiple = true,
    this.widthItem,
    this.heightItem,
    this.crossAxisSpacing,
    this.mainAxisSpacing = 0.0,
    this.shrinkWrap = false,
    this.physics,
  }) : super(key: key);

  final List<PickerData<T>> data;
  final SMFilterItemBuilder<PickerData<T>> child;
  final SMFilterOnChanged<T> onChanged;
  final bool isMultiple;
  final double? widthItem;
  final double? heightItem;
  final double? crossAxisSpacing;
  final double mainAxisSpacing;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    RxList<PickerData<T>> tempData = data.obs;
    List<PickerData<T>> pickedData = [];
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
            onSelected: (isSelected) {
              _resetSelected(tempData);
              _setSelectedData(tempData, item, isSelected);
              _setPickedData(tempData, pickedData);
              onChanged(pickedData, pickedData.last);
            },
            selected: item.isSelected,
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
