import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:varcore_flutter_base/ui/views/order/dummy_order_data.dart';
import 'package:varcore_flutter_base/ui/views/order/filter/filter_order_type_model.dart';
import 'package:varcore_flutter_base/ui/views/order/view/order_controller.dart';
import 'package:varcore_flutter_base/ui/views/order/view/order_view.dart';
import 'package:varcore_flutter_base/ui/views/order/search/search_delegate.dart';
import 'package:varcore_flutter_base/ui/widgets/search_button.dart';

class FilterTabView extends StatelessWidget {
  const FilterTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: SearchButton(
            hintText: 'Cari nama campaign disini...',
            delegate: SearchOrderDelegate(),
          ),
          bottom: const TabBar(
            isScrollable: true,
            padding: EdgeInsets.symmetric(horizontal: 50),
            labelPadding: EdgeInsets.symmetric(horizontal: 24),
            tabs: [
              Tab(text: 'SEMUA'),
              Tab(text: 'PENDING'),
              Tab(text: 'PROSES'),
              Tab(text: 'SELESAI'),
            ],
          ),
        ),
        body: TabBarView(children: [
          OrderView(
            type: OrderType.all,
            data: dummyOrder(),
          ),
          OrderView(
            type: OrderType.pending,
            data: dummyOrder()
                .where((item) => item['status'] == 'Butuh Konfirmasi')
                .toList(),
          ),
          OrderView(
            type: OrderType.process,
            data: dummyOrder()
                .where((item) => (item['status'] == 'Upload Draft' ||
                    item['status'] == 'Revisi Draft' ||
                    item['status'] == 'Menunggu Konfirmasi Draft' ||
                    item['status'] == 'Upload Insight' ||
                    item['status'] == 'Menunggu Konfirmasi Insight'))
                .toList(),
          ),
          OrderView(
            type: OrderType.done,
            data: dummyOrder()
                .where((item) => (item['status'] == 'Selesai' ||
                    item['status'] == 'Ditolak'))
                .toList(),
          ),
        ]),
      ),
    );
  }
}
