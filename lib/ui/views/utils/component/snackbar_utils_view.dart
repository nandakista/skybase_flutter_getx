import 'package:flutter/material.dart';
import 'package:skybase/core/helper/snackbar_helper.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/sky_button.dart';

class SnackBarUtilsView extends StatelessWidget {
  const SnackBarUtilsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkyAppBar.secondary(title: 'SnackBar Utility'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text('Sample SnackBar Usage'),
            const SizedBox(height: 12),
            SkyButton(
              text: 'Normal',
              onPressed: () => SnackBarHelper.normal(message: 'Normal'),
            ),
            const SizedBox(height: 12),
            SkyButton(
              text: 'Error',
              onPressed: () =>
                  SnackBarHelper.error(message: 'Some Error Message'),
            ),
            const SizedBox(height: 12),
            SkyButton(
              text: 'Warning',
              onPressed: () =>
                  SnackBarHelper.warning(message: 'Some Warning Message'),
            ),
            const SizedBox(height: 12),
            SkyButton(
              text: 'Success',
              onPressed: () =>
                  SnackBarHelper.success(message: 'Some Success Message'),
            ),
          ],
        ),
      ),
    );
  }
}
