import 'package:flutter/material.dart';
import 'package:skybase/app_configuration.dart';
import 'package:skybase/core/themes/app_colors.dart';
import 'package:skybase/core/themes/app_style.dart';
import 'package:skybase/ui/widgets/basic_widget.dart';
import 'package:skybase/ui/widgets/colored_status_bar.dart';

class SplashView extends StatelessWidget {
  static const String route = '/splash';
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredStatusBar(
      brightness: Brightness.light,
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: ContentWrapper(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 170,
                        width: 170,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(180),
                          color: Colors.white,
                        ),
                        child: const FlutterLogo(),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'SKYBASE',
                        style: AppStyle.headline2.copyWith(color: Colors.white),
                      ),
                      const Text(
                        'Flutter Getx',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Versi ${AppConfiguration.appVersion}',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
