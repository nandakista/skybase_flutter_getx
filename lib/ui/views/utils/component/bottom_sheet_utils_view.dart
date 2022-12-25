import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/helper/bottom_sheet_helper.dart';
import 'package:skybase/ui/widgets/date_picker_widget.dart';
import 'package:skybase/ui/widgets/media/image_source_bottom_sheet.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/sky_button.dart';

class BottomSheetUtilsView extends StatelessWidget {
  const BottomSheetUtilsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkyAppBar.primary(title: 'Bottom Sheet Utility'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 12),
            const Text(
              'This page is helper to show all of bottomsheet from BottomSheetHelper',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            SkyButton(
              text: 'Basic',
              onPressed: () {
                BottomSheetHelper.basic(child: _imageSource());
              },
            ),
            SkyButton(
              text: 'Rounded',
              onPressed: () {
                BottomSheetHelper.rounded(child: _imageSource());
              },
            ),
            SkyButton(
              text: 'Bar',
              onPressed: () {
                BottomSheetHelper.bar(child: _imageSource());
              },
            ),
            SkyButton(
              text: 'Cupertino',
              onPressed: () {
                BottomSheetHelper.cupertino(child: _imageSource());
              },
            ),
            SkyButton(
              text: 'Material',
              onPressed: () {
                BottomSheetHelper.material(child: _imageSource());
              },
            ),
            SkyButton(
              onPressed: () {
                BottomSheetHelper.basic(
                  child: DatePickerWidget.range(
                    onSelectionChanged: (selected) {},
                  ),
                );
              },
              text: 'Bottom Sheet + Date Range',
              icon: Icons.date_range_outlined,
            ),
          ],
        ),
      ),
    );
  }

  _imageSource() {
    return ImageSourceBottomSheet(
      onImageSelected: (image) {
        // controller.selectedProof.value = image;
        Get.back();
      },
    );
  }
}
