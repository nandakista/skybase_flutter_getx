import 'package:get/get.dart';
import 'package:varcore_flutter_base/core/helper/bottom_sheet_helper.dart';
import 'package:varcore_flutter_base/core/helper/filter/filter_action_result.dart';
import 'package:varcore_flutter_base/ui/views/order/dummy_order_data.dart';
import 'package:varcore_flutter_base/ui/views/order/filter/filter_content_view.dart';
import 'package:varcore_flutter_base/ui/views/order/filter/filter_order_type_model.dart';

class OrderController extends GetxController {
  OrderController({required this.type, required this.data});
  final RxList data;
  final Rx<OrderType> type;

  final List _defaultData = [];
  RxList<FilterOrder> selectedFilterLabel = <FilterOrder>[].obs;

  @override
  void onInit() {
    super.onInit();
    _defaultData.addAll(data);
  }

  setInitialData() {
    selectedFilterLabel.clear();
    data.clear();
    data.addAll(_defaultData);
  }

  setFilterData() {
    data.clear();
    for (var status in selectedFilterLabel) {
      data.addAll(
          dummyOrder().where((element) => element['status'] == status.label));
    }
  }

  deleteFilter(FilterOrder item) {
    selectedFilterLabel.remove(item);
    data.removeWhere((element) => element['status'] == item.label);
    if (selectedFilterLabel.isEmpty) {
      setInitialData();
    }
  }

  submitFilter() async {
    FilterResult result = await BottomSheetHelper.filter(
      Get.context!,
      child: FilterContentView(
        data: selectedFilterLabel,
        type: type.value,
      ),
    );
    if (result.action == FilterAction.submit && result.value.isNotEmpty) {
      selectedFilterLabel.value = result.value as List<FilterOrder>;
      setFilterData();
    } else if (result.action == FilterAction.submit && result.value.isEmpty) {
      setInitialData();
    }
  }
}
