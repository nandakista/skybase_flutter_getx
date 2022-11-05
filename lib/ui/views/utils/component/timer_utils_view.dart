import 'package:flutter/material.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';

class TimerUtilsView extends StatelessWidget {
  const TimerUtilsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkyAppBar.primary(title: 'Timer Utility'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text('Timer'),
          ],
        ),
      ),
    );
  }
}
