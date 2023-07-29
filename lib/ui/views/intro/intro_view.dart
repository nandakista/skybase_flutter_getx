import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/config/themes/app_colors.dart';
import 'package:skybase/ui/views/intro/intro_controller.dart';
import 'package:skybase/ui/views/intro/intro_data.dart';
import 'package:skybase/ui/views/intro/widgets/intro_indicator.dart';

import 'widgets/intro_content.dart';

class IntroView extends GetView<IntroController> {
  static const String route = '/intro';

  const IntroView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Obx(
              () => Container(
                height: kToolbarHeight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (controller.isFirstPage)
                        ? const SizedBox.shrink()
                        : InkWell(
                            onTap: () =>
                                controller.pageController.jumpToPage(2),
                            child: const Icon(Icons.arrow_back),
                          ),
                    controller.isLastPage
                        ? const SizedBox.shrink()
                        : GestureDetector(
                            onTap: () =>
                                controller.pageController.jumpToPage(2),
                            child: const Text(
                              "Lewati",
                              style: TextStyle(color: AppColors.primary),
                            ),
                          ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                itemCount: introItem.length,
                controller: controller.pageController,
                itemBuilder: (context, index) {
                  final item = introItem[index];
                  return IntroContent(
                    image: item.image,
                    title: item.tittle,
                    description: item.description,
                  );
                },
                onPageChanged: (index) {
                  controller.currentIndex.value = index;
                },
              ),
            ),
            const SizedBox(height: 46),
            Obx(
              () => SizedBox(
                height: kBottomNavigationBarHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 40,
                      child: Visibility(
                        visible: !controller.isFirstPage,
                        child: InkWell(
                          onTap: () => controller.onPreviousPage(),
                          child: const Icon(Icons.arrow_back, color: AppColors.primary,),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                    Obx(
                      () => IntroIndicator(
                        itemCount: introItem.length,
                        currentIndex: controller.currentIndex.value,
                      ),
                    ),
                    const SizedBox(width: 48),
                    SizedBox(
                      width: 40,
                      child: Visibility(
                        visible: controller.isLastPage,
                        child: GestureDetector(
                          onTap: () => controller.onNextPage(),
                          child: const Text(
                            "Done",
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 46),
          ],
        ),
      ),
    );
  }
}
