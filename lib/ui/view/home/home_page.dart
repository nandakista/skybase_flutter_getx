import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:varcore_flutter_base/core/themes/app_style.dart';

class HomePage extends StatelessWidget {
  static const String route = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DoubleBackToCloseApp(
          snackBar: SnackBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
            content: const Text("Tap sekali lagi untuk keluar.",
                textAlign: TextAlign.center),
          ),
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
