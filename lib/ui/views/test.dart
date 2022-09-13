import 'package:flutter/material.dart';
import 'package:skybase/ui/widgets/sky_button.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SkyButton(onPressed: () {}, text: 'test'),
      ),
    );
  }
}
