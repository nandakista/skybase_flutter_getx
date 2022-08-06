import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:varcore_flutter_base/ui/views/order/filter/filter_order_type_model.dart';
import 'package:varcore_flutter_base/ui/views/order/view/order_controller.dart';
import 'package:varcore_flutter_base/ui/views/order/widgets/empty_order_view.dart';
import 'package:varcore_flutter_base/ui/views/order/widgets/list_order_view.dart';

class OrderView extends StatelessWidget {
  const OrderView({
    Key? key,
    required this.data,
    required this.type,
  }) : super(key: key);

  final List data;
  final OrderType type;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
        OrderController(
          data: data.obs,
          type: type.obs,
        ),
        tag: type.toString());
    return Center(
      child: Stack(
        children: [
          Obx(
            () => Container(
              margin: const EdgeInsets.only(top: 60),
              child: (controller.data.isEmpty)
                  ? const EmptyOrderView()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListOrderView(data: controller.data),
                    ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: _buildListFilter(context, controller),
          ),
        ],
      ),
    );
  }

  _buildListFilter(BuildContext context, OrderController controller) {
    return SizedBox(
      height: 72,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        scrollDirection: Axis.horizontal,
        children: [
          InputChip(
            label: const Text('Filter'),
            avatar: const Icon(Icons.filter_list),
            padding: const EdgeInsets.symmetric(horizontal: 4),
            onPressed: () => controller.submitFilter(),
          ),
          const SizedBox(width: 8),
          Obx(
            () => Wrap(
              spacing: 8,
              children: controller.selectedFilterLabel
                  .map((e) => InputChip(
                      label: Text(e.label.toString()),
                      onDeleted: () => controller.deleteFilter(e)))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
