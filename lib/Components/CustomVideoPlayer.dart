import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moviewatcher/Components/VideoOverlay.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  String source;
  CustomVideoPlayer(this.source);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController controller;

  @override
  void initState() {
    controller = VideoPlayerController.network(widget.source);
    controller.initialize().then((value) {
      setState(() {});
      controller.play();
    });

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeLeft]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? normalScreenView()
        : fullScreenView();
  }

  Widget normalScreenView() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? Container(
                      height: 200,
                      child: AspectRatio(
                        aspectRatio: controller.value.aspectRatio,
                        child: VideoPlayer(controller),
                      ),
                    )
                  : AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: VideoPlayer(controller),
                    ),
            ],
          ),
        ),
        VideoOverlay(controller)
      ],
    );
  }

  Widget fullScreenView() {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          color: Colors.black,
          child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: VideoPlayer(controller),
          ),
        ),
        VideoOverlay(controller)
      ],
    );
  }
}
