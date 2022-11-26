import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:skybase/core/themes/app_colors.dart';
import 'package:skybase/core/themes/app_style.dart';
import 'package:skybase/ui/widgets/sky_button.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class SkyDialog extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const SkyDialog({
    Key? key,
    required this.child,
    this.padding,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Wrap(
            children: [
              Container(
                padding: padding ??
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                margin: margin ?? const EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                  color: (Get.isDarkMode) ? Colors.black : Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(17),
                  boxShadow: [
                    BoxShadow(
                        color:
                            (Get.isDarkMode) ? AppColors.primary : Colors.black,
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 10.0)
                  ],
                ),
                child: child,
              ),
            ],
          ),
        ],
      ),
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
        height: 80,
        margin: const EdgeInsets.all(24),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(17),
          boxShadow: [
            BoxShadow(
                color: (Get.isDarkMode) ? AppColors.primary : Colors.black26,
                offset: const Offset(0.0, 2.0),
                blurRadius: 10.0)
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Loading',
              style: AppStyle.title1.copyWith(color: Colors.white),
            ),
            const SizedBox(width: 4),
            const SpinKitThreeBounce(color: Colors.white, size: 16),
          ],
        ),
      ),
    );
  }
}

class DialogAlert extends StatelessWidget {
  final String title, description, confirmText;
  final VoidCallback? onConfirm, onCancel;
  final Color confirmColor, cancelColor;
  final Widget? header;
  final Color? backgroundColorHeader;
  final Color? confirmTextColor, confirmBorderColor, confirmBackgroundColor;

  const DialogAlert({
    Key? key,
    required this.title,
    required this.description,
    required this.header,
    required this.onConfirm,
    required this.backgroundColorHeader,
    this.onCancel,
    this.confirmColor = AppColors.primary,
    this.cancelColor = AppColors.primary,
    this.confirmText = 'Ya',
    this.confirmTextColor,
    this.confirmBorderColor,
    this.confirmBackgroundColor,
  }) : super(key: key);

  factory DialogAlert.success({
    required String title,
    required String description,
    Widget? header,
    Color? backgroundColorHeader,
    required VoidCallback onConfirm,
  }) =>
      DialogAlert(
        title: title,
        description: description,
        header: header ??
            Lottie.asset('assets/anim/anim_success.json', repeat: false),
        onConfirm: onConfirm,
        backgroundColorHeader: backgroundColorHeader ?? Colors.green[50],
        confirmTextColor: Colors.white,
        confirmBorderColor: Colors.green,
        confirmBackgroundColor: Colors.green,
      );

  factory DialogAlert.error({
    required String title,
    required String description,
    Widget? header,
    Color? backgroundColorHeader,
    required VoidCallback onConfirm,
  }) =>
      DialogAlert(
        title: title,
        description: description,
        header: header ??
            Lottie.asset('assets/anim/anim_failed.json', repeat: false),
        onConfirm: onConfirm,
        backgroundColorHeader: backgroundColorHeader ?? Colors.red[100],
        confirmTextColor: Colors.white,
        confirmBorderColor: Colors.red[700],
        confirmBackgroundColor: Colors.red[700],
      );

  factory DialogAlert.warning({
    required String title,
    required String description,
    Widget? header,
    Color? backgroundColorHeader,
    required VoidCallback onConfirm,
    required VoidCallback onCancel,
  }) =>
      DialogAlert(
        title: title,
        description: description,
        header: header ??
            Lottie.asset('assets/anim/anim_warning.json', repeat: false),
        onConfirm: onConfirm,
        onCancel: onCancel,
        backgroundColorHeader: backgroundColorHeader ?? Colors.orangeAccent,
      );

  factory DialogAlert.retry({
    required String title,
    required String description,
    String confirmText = 'Coba Lagi',
    Widget? header,
    Color? backgroundColorHeader,
    required VoidCallback onConfirm,
    required VoidCallback onCancel,
  }) =>
      DialogAlert(
        title: title,
        description: description,
        confirmText: confirmText,
        header: header ??
            Lottie.asset('assets/anim/anim_failed.json', repeat: false),
        onConfirm: onConfirm,
        onCancel: onCancel,
        confirmColor: AppColors.primary,
        backgroundColorHeader: backgroundColorHeader ?? Colors.red[100],
      );

  factory DialogAlert.permission({
    required String title,
    required String confirmText,
    required String description,
    Widget? header,
    Color? backgroundColorHeader,
    required VoidCallback onConfirm,
    required VoidCallback onCancel,
  }) =>
      DialogAlert(
        title: title,
        description: description,
        header: header ??
            Lottie.asset('assets/anim/anim_warning.json', repeat: false),
        onConfirm: onConfirm,
        confirmText: confirmText,
        backgroundColorHeader: backgroundColorHeader ?? Colors.orangeAccent,
        confirmColor: Colors.blue,
      );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Wrap(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  margin: const EdgeInsets.only(top: 26),
                  decoration: BoxDecoration(
                      color: (Get.isDarkMode) ? Colors.black : Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(17),
                      boxShadow: [
                        BoxShadow(
                            color: (Get.isDarkMode)
                                ? AppColors.primary
                                : Colors.black,
                            offset: const Offset(0.0, 0.0),
                            blurRadius: 10.0)
                      ]),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 64),
                      Text(
                        title,
                        style: AppStyle.subtitle3.copyWith(
                          fontWeight: AppStyle.semiBold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 32),
                      SkyButton(
                        text: confirmText,
                        textColor: confirmTextColor ?? AppColors.onPrimary,
                        color: confirmBackgroundColor ?? Colors.white,
                        onPressed: onConfirm,
                        borderColor: confirmBorderColor ?? AppColors.onPrimary,
                        fontWeight: AppStyle.semiBold,
                      ),
                      const SizedBox(height: 8),
                      Visibility(
                        visible: (onCancel != null),
                        child: SkyButton(
                          text: 'Tidak',
                          fontWeight: AppStyle.semiBold,
                          color: cancelColor,
                          onPressed: onCancel,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              left: 16,
              right: 16,
              child: CircleAvatar(
                backgroundColor: backgroundColorHeader,
                radius: 50,
                child: header,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SoonDialog extends StatelessWidget {
  const SoonDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkyDialog(
      child: Column(
        children: [
          SizedBox(
            height: 250,
            width: 200,
            child: Lottie.asset('assets/anim/anim_soon.json'),
          ),
          Text(
            'COMING SOON',
            style: AppStyle.headline2,
          ),
          Text(
            'Fitur ini lagi dikembangin..',
            style: AppStyle.subtitle4,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.bottomRight,
            child: SkyButton(
              onPressed: () => Get.back(),
              text: 'OK',
              color: AppColors.primary,
            ),
          )
        ],
      ),
    );
  }
}
