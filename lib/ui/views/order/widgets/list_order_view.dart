import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:varcore_flutter_base/core/themes/app_colors.dart';

class ListOrderView extends StatelessWidget {
  const ListOrderView({Key? key, required this.data}) : super(key: key);

  final List<dynamic> data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (ctx, index) {
        var item = data[index];
        return GestureDetector(
          onTap: () {
            // MainNavigation.instance
            //     .push(context: context, path: MainRouter.orderDetailPath);
            // Get.toNamed(page)
          },
          child: Card(
            elevation: 3,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
                  child: Row(
                    children: [
                      Image.asset(
                        item['image'],
                        height: 85,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title'],
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item['institution'],
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['type'] + ' - ',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      Expanded(
                        child: Text(
                          item['status'],
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: AppColors.primary),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: Row(
                    children: [
                      const Text('Periode: '),
                      Text(item['periode']),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
