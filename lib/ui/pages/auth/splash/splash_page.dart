import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:varcore_flutter_base/core/themes/app_style.dart';
import 'package:varcore_flutter_base/ui/pages/auth/splash/splash_controller.dart';
import 'package:varcore_flutter_base/ui/widgets/basic_widget.dart';

class SplashPage extends GetView<SplashController> {
  static String routeName = "/splash";
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.init();
    return Scaffold(
      backgroundColor: primaryColor,
      body: Content(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 170,
                width: 170,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(180),
                    color: Colors.white),
                // child: const CircleAvatar(
                //   backgroundColor: Colors.white,
                //   backgroundImage: AssetImage("assets/logo_splash.png"),
                // ),
                child: FlutterLogo(),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "VARCORE",
                style: titleFontStyle.copyWith(color: Colors.white),
              ),
              Text("BASE CODE",
                  style: baseFontStyleSmall.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ),
    );
  }
}
