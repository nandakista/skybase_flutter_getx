import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';

class DoubleBack extends StatelessWidget {
  const DoubleBack({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DoubleBackToCloseApp(
      snackBar: SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
        content: const Text("Tap sekali lagi untuk keluar.",
            textAlign: TextAlign.center),
      ),
      child: child,
    );
  }
}