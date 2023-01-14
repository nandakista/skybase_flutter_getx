import 'package:flutter/material.dart';
import 'package:skybase/core/helper/sky_snackbar.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/sky_button.dart';

class SnackBarUtilsView extends StatelessWidget {
  const SnackBarUtilsView({Key? key}) : super(key: key);

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
              onPressed: () => SkySnackBar.showNormal(message: 'Normal'),
            ),
            const SizedBox(height: 12),
            SkyButton(
              text: 'Error',
              onPressed: () =>
                  SkySnackBar.showError(message: 'Some Error Message'),
            ),
            const SizedBox(height: 12),
            SkyButton(
              text: 'Warning',
              onPressed: () =>
                  SkySnackBar.showWarning(message: 'Some Warning Message'),
            ),
            const SizedBox(height: 12),
            SkyButton(
              text: 'Success',
              onPressed: () =>
                  SkySnackBar.showSuccess(message: 'Some Success Message'),
            ),
          ],
        ),
      ),
    );
  }
}
