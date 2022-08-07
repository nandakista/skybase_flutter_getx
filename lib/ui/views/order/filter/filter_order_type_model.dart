import 'package:skybase/ui/widgets/date_picker_widget.dart';

enum OrderType {
  all,
  pending,
  process,
  done,
}

class FilterOrder {
  String? label;
  bool isSelected;
  PickerDateRange? period;

  FilterOrder({
    required this.label,
    this.isSelected = false,
    this.period,
  });

  FilterOrder copy({
    String? label,
    bool? isSelected,
  }) =>
      FilterOrder(
        label: label ?? this.label,
        isSelected: isSelected ?? this.isSelected,
      );
}
