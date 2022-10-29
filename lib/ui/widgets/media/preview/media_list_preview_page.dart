import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/helper/media_helper.dart';
import 'package:skybase/core/localization/language_const.dart';
import 'package:skybase/ui/widgets/media/preview/media_preview_page.dart';
import 'package:skybase/ui/widgets/sky_image.dart';
import 'package:skybase/ui/widgets/sky_video.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';

class MediaListPreviewPage extends StatelessWidget {
  const MediaListPreviewPage({Key? key, required this.mediaUrls})
      : super(key: key);
  final List<String> mediaUrls;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    for (var item in mediaUrls) {
      children.add(_determineMedia(item));
      children.add(const Divider());
    }
    return Scaffold(
      appBar: SkyAppBar.primary(
        title: International.preview.tr + ' ' + International.media.tr,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  Widget _determineMedia(String path) {
    final mediaType = MediaHelper.getMediaType(path);
    switch (mediaType.type) {
      case MediaType.file:
        return const Center(child: Text('Media Unsupported'));
      case MediaType.image:
        return SkyImage(url: mediaType.path);
      case MediaType.video:
        return SkyVideo(
          url: mediaType.path,
          height: 400,
          showControls: false,
          onTapVideo: () => Get.to(MediaPreviewPage(url: mediaType.path)),
        );
      case MediaType.unknown:
        return const Center(child: Text('Media Unsupported'));
    }
  }
}
