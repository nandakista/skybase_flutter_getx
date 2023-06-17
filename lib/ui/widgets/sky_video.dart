import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/ui/widgets/media/play_overlay.dart';
import 'package:skybase/ui/widgets/media/preview/media_preview_page.dart';
import 'package:skybase/ui/widgets/platform_loading_indicator.dart';
import 'package:video_player/video_player.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class SkyVideo extends StatefulWidget {
  final String url;
  final double width;
  final double height;
  final bool showControls;
  final VoidCallback? onTapVideo;
  final VoidCallback? onRemoveVideo;
  final double borderRadius;
  final BoxFit? fit;
  final Widget? placeholder;
  final bool enablePreview;

  const SkyVideo({
    Key? key,
    required this.url,
    this.width = double.infinity,
    this.height = double.infinity,
    this.showControls = true,
    this.onTapVideo,
    this.onRemoveVideo,
    this.borderRadius = 8,
    this.placeholder,
    this.fit,
    this.enablePreview = true,
  }) : super(key: key);

  @override
  State<SkyVideo> createState() => _SkyVideoState();
}

class _SkyVideoState extends State<SkyVideo> {
  ChewieController? chewieController;
  late VideoPlayerController videoController;

  @override
  void initState() {
    initializePlayer();
    super.initState();
  }

  Future<void> initializePlayer() async {
    final isFromRemote = widget.url.startsWith('http');

    videoController = isFromRemote
        ? VideoPlayerController.network(widget.url)
        : VideoPlayerController.file(File(widget.url));

    await videoController.initialize();

    chewieController = ChewieController(
      videoPlayerController: videoController,
      autoPlay: false,
      looping: false,
      showControls: widget.showControls,
      placeholder: SizedBox(
        height: widget.height,
        width: widget.width,
        child:
            widget.placeholder ?? ((widget.showControls) ? Container() : null),
      ),
      errorBuilder: (context, error) => SizedBox(
        height: widget.height,
        width: widget.width,
        child: const Icon(Icons.error),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: (widget.showControls) ? Colors.black : null,
      child: Stack(
        children: [
          chewieController != null &&
                  chewieController!.videoPlayerController.value.isInitialized
              ? GestureDetector(
                  onTap: widget.onTapVideo ??
                      (widget.enablePreview
                          ? () => Get.to(MediaPreviewPage(url: widget.url))
                          : () {}),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    child: SizedBox(
                      width: widget.width,
                      height: widget.height,
                      child: PlayOverlay(
                        borderRadius: 0,
                        visible: !widget.showControls,
                        child: FittedBox(
                            fit: widget.fit ?? BoxFit.none,
                            child: Chewie(controller: chewieController!)),
                      ),
                    ),
                  ),
                )
              : const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: PlatformLoadingIndicator(),
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
    chewieController?.dispose();
    super.dispose();
  }
}
