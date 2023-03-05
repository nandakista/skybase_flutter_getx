import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class PaginationErrorLoadView<ItemType> extends StatelessWidget {
  const PaginationErrorLoadView({
    Key? key,
    required this.pagingController,
  }) : super(key: key);

  final PagingController<int, ItemType> pagingController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Text(
          'txt_err_general_formal'.tr,
          style: const TextStyle(color: Colors.grey),
        ),
        TextButton(
          onPressed: () => pagingController.retryLastFailedRequest(),
          child: Text(
            'txt_tap_retry'.tr,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        const SizedBox(height: 4),
        const Icon(
          CupertinoIcons.refresh_thick,
          color: Colors.grey,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
