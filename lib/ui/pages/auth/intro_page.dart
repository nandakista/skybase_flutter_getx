import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:varcore_flutter_base/core/database/shared_prefs.dart';
import 'package:varcore_flutter_base/core/themes/app_style.dart';
import 'package:varcore_flutter_base/ui/pages/auth/login/login_page.dart';

class IntroPage extends StatelessWidget {
  static String routeName = '/intro';
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final introKey = GlobalKey<IntroductionScreenState>();
    const bodyStyle = TextStyle(fontSize: 19.0);

    var pageDecoration = PageDecoration(
      titleTextStyle: baseFontStyle.copyWith(fontSize: 26.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: 'PPAT Digital Security',
          body: '',
          image: _buildImage('img_pv_1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: '',
          body: '',
          image: _buildImage('img_pv_2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: '',
          body: '',
          image: _buildImage('img_pv_3.png'),

          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: Text('Skip', style: baseFontStyle.copyWith(color: primaryColor, fontWeight: FontWeight.bold)),
      next: const Icon(Icons.arrow_forward, color: primaryColor,),
      done: Text('Done', style: baseFontStyle.copyWith(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeColor: primaryColor,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }

  void _onIntroEnd(context) async {
    prefs.setBool(KeyPrefs.firstOpen, false);
    Get.offAllNamed(LoginPage.routeName);
  }

  Widget _buildImage(String assetName, [double width = 250]) {
    return Image.asset('assets/$assetName', width: width);
  }
}