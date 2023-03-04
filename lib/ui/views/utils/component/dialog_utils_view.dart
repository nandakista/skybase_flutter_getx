import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/helper/dialog_helper.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/sky_button.dart';

class DialogUtilsView extends StatelessWidget {
  const DialogUtilsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkyAppBar.primary(title: 'Dialog Utility'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text('Sample Dialog Usage'),
            const SizedBox(height: 12),
            SkyButton(
              text: 'Loading',
              icon: CupertinoIcons.arrow_2_circlepath,
              onPressed: () {
                Loading.show(dismissible: true);
              },
            ),
            const SizedBox(height: 12),
            SkyButton(
              text: 'Warning',
              icon: Icons.warning_amber,
              outlineMode: true,
              color: Colors.orange,
              onPressed: () {
                SkyDialog.show(
                  type: DialogType.WARNING,
                  message: 'Some Description Text',
                  onConfirm: () => SkyDialog.dismiss(),
                );
              },
            ),
            const SizedBox(height: 12),
            SkyButton(
              text: 'Failed',
              icon: Icons.close,
              outlineMode: true,
              color: Colors.red,
              onPressed: () {
                SkyDialog.show(
                  type: DialogType.FAILED,
                  message: 'Some Description Text',
                  onConfirm: () => SkyDialog.dismiss(),
                );
              },
            ),
            const SizedBox(height: 12),
            SkyButton(
              text: 'Success',
              icon: CupertinoIcons.checkmark_alt_circle,
              outlineMode: true,
              color: Colors.green,
              onPressed: () {
                SkyDialog.show(
                  type: DialogType.SUCCESS,
                  message: 'Some Description Text',
                  onConfirm: () => SkyDialog.dismiss(),
                );
              },
            ),
            const SizedBox(height: 12),
            SkyButton(
              text: 'Retry',
              icon: CupertinoIcons.refresh_thick,
              onPressed: () {
                SkyDialog.show(
                  type: DialogType.RETRY,
                  message: 'Some Description Text',
                  onConfirm: () => SkyDialog.dismiss(),
                );
              },
            ),
            const SizedBox(height: 12),
            SkyButton(
              text: 'Force',
              icon: CupertinoIcons.exclamationmark_shield,
              onPressed: () {
                SkyDialog.show(
                  type: DialogType.FORCE,
                  message: 'Some Description Text',
                  onConfirm: () => SkyDialog.dismiss(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
