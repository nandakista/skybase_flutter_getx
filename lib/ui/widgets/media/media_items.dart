import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/helper/media_helper.dart';
import 'package:skybase/ui/widgets/sky_image.dart';
import 'package:skybase/ui/widgets/media/preview/media_list_preview_page.dart';
import 'package:skybase/ui/widgets/media/preview/media_preview_page.dart';
import 'package:skybase/ui/widgets/sky_video.dart';

class MediaItems extends StatelessWidget {
  final VoidCallback? onTapMore;
  final VoidCallback? onTap;
  final List<String> mediaUrls;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final int maxItem;
  final bool isGrid;
  final double size;
  final double itemsSpacing;

  const MediaItems({
    Key? key,
    required this.mediaUrls,
    this.onTapMore,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.onTap,
    this.isGrid = false,
    this.size = 64.0,
    this.maxItem = 4,
    this.itemsSpacing = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double itemSize = size;
    if (mediaUrls.length == 1) {
      itemSize = size * 2 + itemsSpacing;
    }

    double containerSize = size + itemsSpacing + size; // 2 rows
    if (mediaUrls.length == 1) {
      containerSize = itemSize;
    }

    final List<Widget> items = [];
    for (var i = 0; i < min(maxItem, mediaUrls.length); i++) {
      if (mediaUrls.length > maxItem && i >= maxItem - 1) {
        items.add(
          GestureDetector(
            onTap: onTapMore ??
                () {
                  Get.to(MediaListPreviewPage(
                    mediaUrls: mediaUrls,
                  ));
                },
            child: SizedBox(
              width: itemSize,
              height: itemSize,
              child: _MoreItem(
                text: "+ ${mediaUrls.length - maxItem}",
                isGrid: isGrid,
                child: _determineMedia(mediaUrls[i]),
              ),
            ),
          ),
        );
      } else {
        items.add(
          GestureDetector(
            onTap: onTap,
            child: SizedBox(
              width: itemSize,
              height: itemSize,
              child: _determineMedia(mediaUrls[i]),
            ),
          ),
        );
      }
    }

    return (isGrid)
        ? Row(
            mainAxisSize: mainAxisSize,
            mainAxisAlignment: mainAxisAlignment,
            children: [
              Container(
                width: containerSize,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: itemsSpacing,
                  runSpacing: itemsSpacing,
                  children: items,
                ),
              ),
            ],
          )
        : Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: itemsSpacing,
            runSpacing: itemsSpacing,
            children: items,
          );
  }

  Widget _determineMedia(String path) {
    final mediaType = MediaHelper.getMediaType(path);
    switch (mediaType.type) {
      case MediaType.file:
        return const Center(child: Text('Media Unsupported'));
      case MediaType.image:
        return SkyImage(
          url: mediaType.path,
          width: double.infinity,
          height: double.infinity,
          borderRadius: BorderRadius.circular((isGrid) ? 0 : 8),
          onTapImage:
              onTap ?? () => Get.to(MediaPreviewPage(url: mediaType.path)),
        );
      case MediaType.video:
        return SkyVideo(
          url: mediaType.path,
          showControls: false,
          height: double.infinity,
          width: double.infinity,
          onTapVideo:
              onTapMore ?? () => Get.to(MediaPreviewPage(url: mediaType.path)),
        );
      case MediaType.unknown:
        return const Center(child: Text('Media Unsupported'));
    }
  }
}

class _MoreItem extends StatelessWidget {
  final String text;
  final Widget child;
  final bool isGrid;

  const _MoreItem({
    Key? key,
    required this.child,
    required this.text,
    required this.isGrid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular((isGrid) ? 0 : 8),
            ),
            child: Center(
              child: Text(text, style: _moreStyle),
            ),
          ),
        ),
      ],
    );
  }
}

const _moreStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);
