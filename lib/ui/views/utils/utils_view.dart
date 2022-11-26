import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/ui/views/utils/component/bottom_sheet_utils_view.dart';
import 'package:skybase/ui/views/utils/component/dialog_utils_view.dart';
import 'package:skybase/ui/views/utils/component/list_utils_view.dart';
import 'package:skybase/ui/views/utils/component/settings_utils_view.dart';
import 'package:skybase/ui/views/utils/component/timer/timer_utils_view.dart';
import 'package:skybase/ui/views/utils/utils_controller.dart';
import 'package:skybase/ui/views/utils/component/media_utils_view.dart';
import 'package:skybase/ui/widgets/common_widget.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/sky_button.dart';

class UtilsView extends GetView<UtilsController> {
  const UtilsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkyAppBar.secondary(title: 'Utility'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ContentWrapper(
            top: true,
            bottom: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SkyButton(
                  text: 'Settings Utility',
                  icon: CupertinoIcons.settings,
                  outlineMode: true,
                  onPressed: () => Get.to(() => const SettingsUtilsView()),
                ),
                const SizedBox(height: 12),
                SkyButton(
                  text: 'Media Utility',
                  icon: Icons.photo_library_outlined,
                  outlineMode: true,
                  onPressed: () => Get.to(() => const MediaUtilsView()),
                ),
                const SizedBox(height: 12),
                SkyButton(
                  text: 'BottomSheet Utility',
                  icon: Icons.account_tree_outlined,
                  outlineMode: true,
                  onPressed: () => Get.to(() => const BottomSheetUtilsView()),
                ),
                const SizedBox(height: 12),
                SkyButton(
                  text: 'List Utility',
                  icon: Icons.list,
                  outlineMode: true,
                  onPressed: () => Get.to(() => const ListUtilsView()),
                ),
                const SizedBox(height: 12),
                SkyButton(
                  text: 'Dialog Utility',
                  icon: CupertinoIcons.conversation_bubble,
                  outlineMode: true,
                  onPressed: () => Get.to(() => const DialogUtilsView()),
                ),
                const SizedBox(height: 12),
                SkyButton(
                  text: 'Timer Utility',
                  icon: Icons.timer_outlined,
                  outlineMode: true,
                  onPressed: () => Get.toNamed(TimerUtilsView.route),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
