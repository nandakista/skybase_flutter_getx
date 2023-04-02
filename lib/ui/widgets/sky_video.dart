import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/ui/widgets/media/play_overlay.dart';
import 'package:skybase/ui/widgets/media/preview/media_preview_page.dart';
import 'package:skybase/ui/widgets/sky_image.dart';
import 'package:video_player/video_player.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class SkyVideo extends StatefulWidget {
  final String url;
  final double? width;
  final double? height;
  final bool showControls;
  final VoidCallback? onTapVideo;
  final VoidCallback? onRemoveVideo;
  final double borderRadius;
  final bool enablePreview;

  const SkyVideo({
    Key? key,
    required this.url,
    this.width,
    this.height,
    this.showControls = true,
    this.onTapVideo,
    this.onRemoveVideo,
    this.borderRadius = 8,
    this.enablePreview = false,
  }) : super(key: key);

  @override
  State<SkyVideo> createState() => _SkyVideoState();
}

class _SkyVideoState extends State<SkyVideo> {
  late ChewieController chewieController;
  late VideoPlayerController videoController;

  @override
  void initState() {
    final isFromRemote = widget.url.startsWith('http');

    videoController = isFromRemote
        ? VideoPlayerController.network(widget.url)
        : VideoPlayerController.file(File(widget.url));

    videoController.initialize();

    chewieController = ChewieController(
      videoPlayerController: videoController,
      autoPlay: false,
      looping: false,
      showControls: widget.showControls,
      fullScreenByDefault: false,
      placeholder: SizedBox(
        height: widget.height,
        width: widget.width,
        child: (widget.showControls)
            ? const Center(
                child: SkyImage(url: 'assets/images/img_empty.png'),
              )
            : null,
      ),
      errorBuilder: (context, error) => SizedBox(
        height: widget.height,
        width: widget.width,
        child: const Icon(
          Icons.error,
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: (widget.showControls) ? Colors.black : null,
      child: Stack(
        children: [
          GestureDetector(
            onTap: widget.onTapVideo ??
                () => Get.to(MediaPreviewPage(url: widget.url)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              child: SizedBox(
                width: widget.width,
                height: widget.height,
                child: PlayOverlay(
                  borderRadius: 0,
                  visible: !widget.showControls,
                  child: Chewie(
                    controller: chewieController,
                  ),
                ),
              ),
            ),
          ),
          widget.onRemoveVideo != null
              ? Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: widget.onRemoveVideo,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        ),
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    videoController.dispose();
    chewieController.dispose();
    super.dispose();
  }
}
