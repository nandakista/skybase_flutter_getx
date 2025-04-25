import 'package:flutter/material.dart';
import 'package:skybase/config/themes/app_colors.dart';
import 'package:skybase/ui/widgets/colored_status_bar.dart';
import 'package:skybase/ui/widgets/platform_loading_indicator.dart';

class SplashView extends StatelessWidget {
  static const String route = '/splash';

  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    /// TODO : If you are using flutter_native_splash use this
    return const ColoredStatusBar(
      brightness: Brightness.dark,
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(
          child: PlatformLoadingIndicator(color: Colors.white),
        ),
      ),
    );

    /// TODO : Otherwise use this
    // return ColoredStatusBar(
    //   brightness: Brightness.light,
    //   child: Scaffold(
    //     backgroundColor: AppColors.primary,
    //     body: ContentWrapper(
    //       bottom: true,
    //       child: Center(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Expanded(
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Container(
    //                     height: 170,
    //                     width: 170,
    //                     padding: const EdgeInsets.all(20),
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(180),
    //                       color: Colors.white,
    //                     ),
    //                     child: const FlutterLogo(),
    //                   ),
    //                   const SizedBox(height: 20),
    //                   Text(
    //                     AppConfiguration.appName,
    //                     style: AppStyle.headline2.copyWith(color: Colors.white),
    //                   ),
    //                   Text(
    //                     AppConfiguration.appTag,
    //                     style: const TextStyle(color: Colors.white),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             Text(
    //               '${'txt_version'.tr} ${AppConfiguration.appVersion}',
    //               style: const TextStyle(color: Colors.white),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
