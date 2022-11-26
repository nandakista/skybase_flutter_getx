import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:skybase/core/database/get_storage/get_storage_key.dart';
import 'package:skybase/core/database/get_storage/get_storage_manager.dart';
import 'package:skybase/core/themes/app_colors.dart';
import 'package:skybase/core/themes/app_style.dart';
import 'package:skybase/ui/views/auth/login/login_view.dart';

class IntroView extends StatelessWidget {
  static const String route = '/intro';
  const IntroView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final introKey = GlobalKey<IntroductionScreenState>();
    const bodyStyle = TextStyle(fontSize: 19.0);

    var pageDecoration = PageDecoration(
      titleTextStyle: AppStyle.subtitle4
          .copyWith(fontSize: 26.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: 'Skybase',
          image: _buildImage('img_pv_1.png'),
          decoration: pageDecoration,
          bodyWidget: Column(
            children: [
              const SizedBox(height: 12),
              Text('Created by', style: AppStyle.subtitle4,),
              Text('Varcant', style: AppStyle.subtitle3.copyWith(fontWeight: FontWeight.bold)),
              Text('nanda.kista@gmail.com', style: TextStyle(fontWeight: AppStyle.semiBold)),
            ],
          ),
        ),
        PageViewModel(
          title: 'Skybase',
          image: _buildImage('img_pv_2.png'),
          decoration: pageDecoration,
          bodyWidget: Column(
            children: [
              const SizedBox(height: 12),
              Text('Created by', style: AppStyle.subtitle4,),
              Text('Varcant', style: AppStyle.subtitle3.copyWith(fontWeight: FontWeight.bold)),
              Text('nanda.kista@gmail.com', style: TextStyle(fontWeight: AppStyle.semiBold)),
            ],
          ),
        ),
        PageViewModel(
          title: 'Skybase',
          image: _buildImage('img_pv_3.png'),
          decoration: pageDecoration,
          bodyWidget: Column(
            children: [
              const SizedBox(height: 12),
              Text('Created by', style: AppStyle.subtitle4,),
              Text('Varcant', style: AppStyle.subtitle3.copyWith(fontWeight: FontWeight.bold)),
              Text('nanda.kista@gmail.com', style: TextStyle(fontWeight: AppStyle.semiBold)),
            ],
          ),
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: Text('txt_skip'.tr,
          style: AppStyle.subtitle4
              .copyWith(color: AppColors.primary, fontWeight: FontWeight.bold)),
      next: const Icon(
        Icons.arrow_forward,
        color: AppColors.primary,
      ),
      done: Text('txt_done'.tr,
          style: AppStyle.subtitle4.copyWith(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeColor: AppColors.primary,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }

  void _onIntroEnd(context) async {
    GetStorageManager.find.save(GetStorageKey.firstInstall, false);
    Get.offAllNamed(LoginView.route);
  }

  Widget _buildImage(String assetName, [double width = 250]) {
    return Image.asset('assets/images/$assetName', width: width);
  }
}
