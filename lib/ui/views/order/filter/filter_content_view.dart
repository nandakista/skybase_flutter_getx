import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:varcore_flutter_base/core/helper/date_time_helper.dart';
import 'package:varcore_flutter_base/core/themes/app_colors.dart';
import 'package:varcore_flutter_base/ui/views/order/filter/filter_controller.dart';
import 'package:varcore_flutter_base/ui/views/order/filter/filter_order_type_model.dart';
import 'package:varcore_flutter_base/ui/views/order/filter/filter_order_data.dart';
import 'package:varcore_flutter_base/ui/widgets/custom_button.dart';
import 'package:varcore_flutter_base/ui/widgets/date_picker_widget.dart';

class FilterContentView extends StatelessWidget {
  FilterContentView({
    Key? key,
    required this.data,
    required this.type,
  }) : super(key: key);

  final List<FilterOrder> data;
  final OrderType type;

  final filterStatus = <FilterOrder>[].obs;
  final filterOrderBy = <FilterOrder>[].obs;
  final filterPeriod = Rxn<FilterOrder>();
  final _appliedFilter = <FilterOrder>[].obs;

  @override
  Widget build(BuildContext context) {
    initDefaultData();
    _initAppliedData();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(context),
        const Divider(thickness: 1),
        _buildOrderBy(context),
        _buildStatus(context),
        _buildPeriod(context),
        CustomButton(
            text: 'Submit',
            height: 50,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          onPressed: () => onSubmit(),
  )
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Filter & Urutan', style: Theme.of(context).textTheme.headline5),
          InkWell(
            onTap: () => initDefaultData(),
            child: Text(
              'Reset',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderBy(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Urutkan Berdasarkan',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
          Obx(()=>_buildContentFilter(
            context,
            data: filterOrderBy,
            onSelected: (filterChip) => (isSelected) =>
            filterOrderBy.value = filterOrderBy.map((otherChip) {
              return filterChip == otherChip
                  ? otherChip.copy(isSelected: isSelected)
                  : otherChip;
            }).toList(),
          )),
        ],
      ),
    );
  }

  Widget _buildStatus(BuildContext context) {
    return Visibility(
      visible: type == OrderType.all ||
          type == OrderType.process ||
          type == OrderType.done,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status Pesanan',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            Obx(()=>_buildContentFilter(
                context,
                data: filterStatus,
                onSelected: (filterChip) => (isSelected) =>
                filterStatus.value = filterStatus.map((otherChip) {
                  return filterChip == otherChip
                      ? otherChip.copy(isSelected: isSelected)
                      : otherChip;
                }).toList()
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriod(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Periode Campaign',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          DatePickerWidget.range(
              onSelectionChanged: (selected) {
            if (selected?.startDate != null && selected?.endDate != null) {
              filterPeriod.value = FilterOrder(
                  label: DateHelper(
                          startDate: selected?.startDate,
                          endDate: selected?.endDate)
                      .format(),
                  isSelected: true,
                  period: selected);
            }
          }),
        ],
      ),
    );
  }

  _buildContentFilter(
      BuildContext context,
      {
    required List<FilterOrder> data,
    required void Function(bool)? Function(FilterOrder) onSelected,
  }) {
    return Wrap(
      runSpacing: -10,
      spacing: 4,
      children: data.map((filterChip) {
        return FilterChip(
          label: Text(
            filterChip.label.toString(),
            style: Theme.of(context)
                .textTheme
                .caption
                ?.copyWith(color: Colors.black),
          ),
          onSelected: onSelected(filterChip),
          selectedColor: AppColors.primary.withOpacity(0.2),
          selected: filterChip.isSelected,
        );
      }).toList(),
    );
  }

  initDefaultData() {
    switch (type) {
      case OrderType.all:
        filterStatus.value = FilterOrderData.all + FilterOrderData.process + FilterOrderData.done;
        break;
      case OrderType.process:
        filterStatus.value = FilterOrderData.process;
        break;
      case OrderType.done:
        filterStatus.value = FilterOrderData.done;
        break;
      case OrderType.pending:
        break;
    }
    filterOrderBy.value = FilterOrderData.orderBy;
    filterPeriod.value = null;
  }

  _initAppliedData() {
    _appliedFilter.value = data;
    for (var filterItem in _appliedFilter) {
      filterStatus.value = filterStatus.map((otherChip) {
        return filterItem.label == otherChip.label
            ? otherChip.copy(isSelected: filterItem.isSelected)
            : otherChip;
      }).toList();
      filterOrderBy.value = filterOrderBy.map((otherChip) {
        return filterItem.label == otherChip.label
            ? otherChip.copy(isSelected: filterItem.isSelected)
            : otherChip;
      }).toList();
      if (filterItem.period != null) {
        filterPeriod.value = filterItem;
      }
    }
  }

  onSubmit(){
    var selectedFilterStatus =
    filterStatus.where((e) => e.isSelected == true).toList();
    var selectedFilterOrderBy =
    filterOrderBy.where((e) => e.isSelected == true).toList();
    _appliedFilter.value = selectedFilterOrderBy + selectedFilterStatus;
    if (filterPeriod.value != null) {
      _appliedFilter.add(filterPeriod.value!);
    }
    Get.back(result: _appliedFilter);
  }
}
