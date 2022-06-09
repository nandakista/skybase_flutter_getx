import 'package:flutter/material.dart';
import 'package:varcore_flutter_base/core/themes/app_style.dart';

class HomePage extends StatelessWidget {
  static String routeName = "/home";
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("Home Page", style: AppStyle.subtitle4),
          ),
        ],
      ),
    );
  }
}
