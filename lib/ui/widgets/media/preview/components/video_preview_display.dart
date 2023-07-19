import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:skybase/ui/widgets/platform_loading_indicator.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewDisplay extends StatefulWidget {
  final String url;
  final double? width;
  final double? height;
  final bool showControls;
  final VoidCallback? onTapVideo;
  final VoidCallback? onRemoveVideo;

  const VideoPreviewDisplay({
    Key? key,
    required this.url,
    this.width,
    this.height,
    this.showControls = true,
    this.onTapVideo,
    this.onRemoveVideo,
  }) : super(key: key);

  @override
  State<VideoPreviewDisplay> createState() => _VideoPreviewDisplayState();
}

class _VideoPreviewDisplayState extends State<VideoPreviewDisplay> {
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
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      errorBuilder: (context, error) => SizedBox(
        height: widget.height,
        width: widget.width,
        child: const Icon(
          Icons.error,
        ),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: widget.width,
          height: widget.height,
          child: chewieController != null &&
                  chewieController!.videoPlayerController.value.isInitialized
              ? Chewie(controller: chewieController!)
              : const PlatformLoadingIndicator(),
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
    );
  }

  @override
  void dispose() {
    videoController.dispose();
    chewieController?.dispose();
    super.dispose();
  }
}
