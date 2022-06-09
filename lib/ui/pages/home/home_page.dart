import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:varcore_flutter_base/core/helper/input_formater.dart';
import 'package:varcore_flutter_base/core/helper/validator_helper.dart';
import 'package:varcore_flutter_base/core/themes/app_style.dart';
import 'package:varcore_flutter_base/ui/widgets/custom_form_field.dart';

import '../../../core/helper/dialog_helper.dart';

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
            child: Text("Home Page", style: AppStyle.subtitle1),
          ),
        ],
      ),
    );
  }
}
