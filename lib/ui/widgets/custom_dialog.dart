import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:varcore_flutter_base/core/themes/app_style.dart';
import 'package:varcore_flutter_base/ui/widgets/custom_button.dart';

class SuccessDialog extends StatelessWidget {
  final String title, description;
  final Image? image;
  final Function onPress;

  const SuccessDialog(
      {Key? key, required this.title,
      required this.description,
      this.image,
      required this.onPress}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context, onPress),
    );
  }

  dialogContent(BuildContext context, Function onPress) {
    return Stack(
      children: [
        Wrap(children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
            margin: const EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
                color: (Get.isDarkMode) ? Colors.black : Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(17),
                boxShadow: [
                  BoxShadow(
                      color: (Get.isDarkMode) ? primaryColor : Colors.black,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 10.0)
                ]),
            child: Column(
              children: [
                Text(
                  title,
                  style: baseFontStyleVeryBig.copyWith(color: primaryColor),
                ),
                const SizedBox(height: 24),
                Text(
                  description,
                  style: baseFontStyleSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Align(
                    alignment: Alignment.bottomRight,
                    child: CustomButton(
                        onPress: onPress, text: 'OK', color: primaryColor))
              ],
            ),
          ),
        ]),
        Positioned(
          top: 0,
          left: 16,
          right: 16,
          child: CircleAvatar(
            backgroundColor: accentColor,
            radius: 50,
            child: Lottie.asset('assets/anim_success.json', repeat: false),
          ),
        )
      ],
    );
  }
}

class FailedDialog extends StatelessWidget {
  final String title, description;
  final Image? image;
  final Function onPress;

  const FailedDialog(
      {Key? key, required this.title,
        required this.description,
        this.image,
        required this.onPress}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context, onPress),
    );
  }

  dialogContent(BuildContext context, Function onPress) {
    return Stack(
      children: [
        Wrap(children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
            margin: const EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
                color: (Get.isDarkMode) ? Colors.black : Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(17),
                boxShadow: [
                  BoxShadow(
                      color: (Get.isDarkMode) ? primaryColor : Colors.black,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 10.0)
                ]),
            child: Column(
              children: [
                Text(
                  title,
                  style: baseFontStyleVeryBig.copyWith(fontWeight: FontWeight.bold, color: primaryColor),
                ),
                const SizedBox(height: 24),
                Text(
                  description,
                  style: baseFontStyleSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CustomButton(
                      onPress: onPress, text: 'OK', color: primaryColor),
                )
              ],
            ),
          ),
        ]),
        Positioned(
          top: 0,
          left: 16,
          right: 16,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.red[100],
            child: Lottie.asset('assets/anim_failed.json', repeat: false),
          ),
        )
      ],
    );
  }
}

class WarningDialog extends StatelessWidget {
  final String title, description;
  final Image? image;
  final Function confirmPress, cancelPress;

  const WarningDialog(
      {Key? key, required this.title,
        required this.description,
        this.image,
        required this.confirmPress,
        required this.cancelPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context, confirmPress, cancelPress),
    );
  }

  dialogContent(BuildContext context, Function confirmPress, Function cancelPress) {
    return Stack(
      children: [
        Wrap(children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
            margin: const EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
                color: (Get.isDarkMode) ? Colors.black : Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(17),
                boxShadow: [
                  BoxShadow(
                      color: (Get.isDarkMode) ? primaryColor : Colors.black,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 10.0)
                ]),
            child: Column(
              children: [
                Text(
                  title,
                  style: baseFontStyleVeryBig.copyWith(color: primaryColor),
                ),
                const SizedBox(height: 24),
                Text(
                  description,
                  style: baseFontStyleSmall,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 24),Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: CustomButton(
                        text: 'Kembali',
                        color: Colors.red,
                        onPress: () => cancelPress(),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: CustomButton(
                        text: 'Ya',
                        color: Colors.green,
                        onPress: () => confirmPress(),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ]),
        Positioned(
          top: 0,
          left: 16,
          right: 16,
          child: CircleAvatar(
            backgroundColor: Colors.orangeAccent,
            radius: 50,
            child: Lottie.asset('assets/anim_warning.json', repeat: false),
          ),
        )
      ],
    );
  }
}

class ConfirmDialog extends StatelessWidget {
  final String title, description;
  final Image? image;
  final Function confirmPress, cancelPress;

  const ConfirmDialog(
      {Key? key, required this.title,
      required this.description,
      this.image,
      required this.confirmPress,
      required this.cancelPress}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context, confirmPress, cancelPress),
    );
  }

  dialogContent(
      BuildContext context, Function confirmPress, Function cancelPress) {
    return Stack(
      children: [
        Wrap(children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
            decoration: BoxDecoration(
                color: (Get.isDarkMode) ? Colors.black : Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(17),
                boxShadow: [
                  BoxShadow(
                      color: (Get.isDarkMode) ? primaryColor : Colors.black,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 10.0)
                ]),
            child: Column(
              children: [
                Text(
                  title,
                  style: baseFontStyleVeryBig,
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: baseFontStyleSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: CustomButton(
                        text: 'Tidak',
                        color: Colors.amber,
                        onPress: () => cancelPress(),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: CustomButton(
                        text: 'Ya',
                        color: Colors.green,
                        onPress: () => confirmPress(),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ]),
      ],
    );
  }
}

class CommingSoonDialog extends StatelessWidget {
  const CommingSoonDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: [
        Wrap(children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
            margin: const EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
                color: (Get.isDarkMode) ? Colors.black : Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(17),
                boxShadow: [
                  BoxShadow(
                      color: (Get.isDarkMode) ? primaryColor : Colors.black,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 10.0)
                ]),
            child: Column(
              children: [
                SizedBox(
                  height: 250,
                  width: 200,
                  child: Lottie.asset('assets/anim_soon.json'),
                ),
                Text(
                  'COMING SOON',
                  style: baseFontStyleVeryBig,
                ),
                Text(
                  'Fitur ini lagi dikembangin..',
                  style: baseFontStyleVeryBig,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Align(
                    alignment: Alignment.bottomRight,
                    child: CustomButton(
                        onPress: () => Get.back(),
                        text: 'OK',
                        color: primaryColor))
              ],
            ),
          ),
        ]),
      ],
    );
  }
}

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: systemBlackColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(17),
            boxShadow: [
              BoxShadow(
                  color: (Get.isDarkMode) ? primaryColor : Colors.black26,
                  offset: const Offset(0.0, 2.0),
                  blurRadius: 10.0)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Loading',
              style: baseFontStyleBig.copyWith(color: Colors.white),
            ),
            const SpinKitThreeBounce(size: 35, color: Colors.blue),
          ],
        ),
      ),
    );
  }
}