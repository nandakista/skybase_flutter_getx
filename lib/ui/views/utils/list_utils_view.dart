import 'package:flutter/material.dart';
import 'package:skybase/core/themes/app_style.dart';
import 'package:skybase/ui/widgets/base/sky_list_view.dart';
import 'package:skybase/ui/widgets/common_widget.dart';
import 'package:skybase/ui/widgets/sky_grouped_listview.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';

class ListUtilsView extends StatelessWidget {
  const ListUtilsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkyAppBar.primary(title: 'List Utility'),
      body: Column(
        children: [
          const SizedBox(height: 12),
          const Text('Sample Grouped ListView'),
          Expanded(
            child: ContentWrapper(
              top: true,
              child: SkyListView(
                loadingEnabled: false,
                errorEnabled: false,
                onRetry: () {},
                onRefresh: () {},
                emptyEnabled: dummyData.isEmpty,
                child: SkyGroupedListView<dynamic, String>(
                  // shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  sortBy: SortBy.ASC,
                  elements: dummyData ,
                  separator: const Divider(thickness: 1, height: 12),
                  separatorGroup: const Divider(
                    thickness: 1,
                    height: 12,
                    color: Colors.red,
                  ),
                  groupHeaderBuilder: (group) {
                    return Text(
                      group.toString(),
                      textAlign: TextAlign.center,
                      style: AppStyle.headline4.copyWith(
                        fontWeight: AppStyle.semiBold,
                      ),
                    );
                  },
                  itemBuilder: (context, index, item) {
                    return Text(
                      item['name'],
                      textAlign: TextAlign.start,
                      style: AppStyle.body1,
                    );
                  },
                  groupBy: (element) => element['group'],
                ),
                // child: Column(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Text('Sample Grouped ListView', style: AppStyle.headline3,),
                //     const SizedBox(height: 24),
                //     SkyGroupedListView<dynamic, String>(
                //       shrinkWrap: true,
                //       physics: const NeverScrollableScrollPhysics(),
                //       sortBy: SortBy.ASC,
                //       elements: dummyData,
                //       separator: const Divider(thickness: 1, height: 12),
                //       separatorGroup: const Divider(thickness: 1, height: 12, color: Colors.red,),
                //       groupHeaderBuilder: (group) {
                //         return Text(
                //           group.toString(),
                //           textAlign: TextAlign.center,
                //           style: AppStyle.headline4.copyWith(
                //             fontWeight: AppStyle.semiBold,
                //           ),
                //         );
                //       },
                //       itemBuilder: (context, index, item) {
                //         return Text(
                //           item['name'],
                //           textAlign: TextAlign.start,
                //           style: AppStyle.body1,
                //         );
                //       },
                //       groupBy: (element) => element['group'],
                //     ),
                //   ],
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final dummyData = [
  {
    'group': 'Jakarta',
    'name': 'Gambir',
    'date': DateTime.now(),
  },
  {
    'group': 'Lampung',
    'name': 'Pringsewu',
    'date': DateTime.now().add(const Duration(days: 12)),
  },
  {
    'group': 'Jakarta',
    'name': 'Tebet',
    'date': DateTime.now().add(const Duration(days: 1)),
  },
  {
    'group': 'Bandung',
    'name': 'Setrasari',
    'date': DateTime.now().add(const Duration(days: 2)),
  },
  {
    'group': 'Lampung',
    'name': 'Pesawaran',
    'date': DateTime.now().add(const Duration(days: 2)),
  },
  {
    'group': 'Yogyakarta',
    'name': 'Yogyakarta',
    'date': DateTime.now().add(const Duration(days: 12)),
  },
  {
    'group': 'Yogyakarta',
    'name': 'Yogyakarta2',
    'date': DateTime.now().add(const Duration(days: 12)),
  },
  {
    'group': 'Lampung',
    'name': 'Metro',
    'date': DateTime.now().add(const Duration(days: 1)),
  },
  {
    'group': 'Bandung',
    'name': 'Gedebage',
    'date': DateTime.now().add(const Duration(days: 1)),
  },
  {
    'group': 'Bandung',
    'name': 'Cihanjuang',
    'date': DateTime.now(),
  },
  {
    'group': 'Jakarta',
    'name': 'Sudirman',
    'date': DateTime.now().subtract(const Duration(days: 4)),
  },
];
