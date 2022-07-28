import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

class DateRangePicker extends StatelessWidget {
  final double? height;
  final double? width;
  final TextStyle? weekLabelStyle;
  final List<String>? weekLabel;
  final Function(PickDateRange? selected) onResult;
  final PickDateRange? initialValue;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? startDate;
  final Color? selectedHighlightColor;

  const DateRangePicker({
    Key? key,
    required this.onResult,
    this.initialValue,
    this.height,
    this.width,
    this.weekLabelStyle,
    this.weekLabel,
    this.firstDate,
    this.lastDate,
    this.startDate,
    this.selectedHighlightColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: CalendarDatePicker2(
        config: CalendarDatePicker2Config(
          calendarType: CalendarDatePicker2Type.range,
          weekdayLabelTextStyle: weekLabelStyle,
          weekdayLabels: weekLabel,
          firstDate: firstDate,
          lastDate: lastDate,
          currentDate: startDate,
          selectedDayHighlightColor: selectedHighlightColor,
        ),
        initialValue: [initialValue?.startDate, initialValue?.endDate],
        onValueChanged: (selected) {
          if (selected.length == 2) {
            PickDateRange selectedDate =
                PickDateRange(selected[0], selected[1]);
            onResult(selectedDate);
          }
        },
      ),
    );
  }
}

class PickDateRange {
  final DateTime? startDate;
  final DateTime? endDate;
  const PickDateRange(this.startDate, this.endDate);
}
