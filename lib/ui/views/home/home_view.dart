import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:varcore_flutter_base/core/themes/app_style.dart';
import 'package:varcore_flutter_base/ui/widgets/basic_widget.dart';

class HomeView extends StatelessWidget {
  static const String route = '/home';
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DoubleBack(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text('Home Page', style: AppStyle.subtitle4),
                ),
              ],
            ),
        ),
      ),
    );
  }
}
