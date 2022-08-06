import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:varcore_flutter_base/ui/views/order/filter/filter_order_data.dart';
import 'package:varcore_flutter_base/ui/views/order/filter/filter_order_type_model.dart';

class FilterOrderController extends GetxController {
  FilterOrderController({required this.type, required this.data});

  final List<FilterOrder> data;
  final OrderType type;


  // List<FilterOrder> _filterStatus = [];
  final filterStatus = <FilterOrder>[].obs;
  final filterOrderBy = <FilterOrder>[].obs;
  final filterPeriod = Rxn<FilterOrder>();
  List<FilterOrder> _appliedFilter = [];


  @override
  void onInit() {
    super.onInit();
    initDefaultData();
  }

  @override
  void onReady() {
    super.onReady();
    _initAppliedData();
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
    _appliedFilter = data;
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
    _appliedFilter = selectedFilterOrderBy + selectedFilterStatus;
    if (filterPeriod.value != null) {
      _appliedFilter.add(filterPeriod.value!);
    }
    Get.back(result: _appliedFilter);
  }
}