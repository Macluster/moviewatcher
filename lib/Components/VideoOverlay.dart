import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

class VideoOverlay extends StatefulWidget {
  VideoPlayerController controller;
  VideoOverlay(this.controller);
  @override
  State<VideoOverlay> createState() => _VideoOverlayState();
}

class _VideoOverlayState extends State<VideoOverlay> {
  bool isplayButtonOn = true;
  bool showIconsFlag = true;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? GestureDetector(
            onTap: () {
              if (showIconsFlag == true) {
                print("AFfaf");
                setState(() {
                  showIconsFlag = false;
                });
              } else {
                print("AFfaf");
                setState(() {
                  showIconsFlag = true;
                });
              }
            },
            child: normalScreenView(),
          )
        : GestureDetector(
            onTap: () {
              if (showIconsFlag == true) {
                print("AFfaf");
                setState(() {
                  showIconsFlag = false;
                });
              } else {
                print("AFfaf");
                setState(() {
                  showIconsFlag = true;
                });
              }
            },
            child: fullScreenView(),
          );
  }

  Indicator() {
    return VideoProgressIndicator(widget.controller, allowScrubbing: true);
  }

  Widget normalScreenView() {
    return Container(
      color: Colors.transparent,
      height: 200,
      width: double.infinity,
      child: Stack(children: [
        showIconsFlag == true
            ? Align(
                alignment: Alignment.bottomCenter,
                child: Indicator(),
              )
            : Container(),
        Align(
            alignment: Alignment.center,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    widget.controller.seekTo(Duration(seconds: 200));
                  },
                  child: const Icon(
                    Icons.home,
                    size: 60,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (showIconsFlag == true) {
                      if (isplayButtonOn == true) {
                        setState(() {
                          isplayButtonOn = false;
                          widget.controller.pause();
                        });
                      } else {
                        setState(() {
                          isplayButtonOn = true;
                          widget.controller.play();
                        });
                      }
                    }
                  },
                  child: showIconsFlag == true
                      ? isplayButtonOn == true
                          ? const Icon(
                              Icons.pause_circle_outline,
                              size: 60,
                              color: Color.fromARGB(255, 216, 214, 214),
                            )
                          : const Icon(
                              Icons.play_arrow,
                              size: 60,
                              color: Color.fromARGB(255, 216, 214, 214),
                            )
                      : Container(),
                ),
              ],
            )),
        Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.landscapeLeft,
                    DeviceOrientation.landscapeLeft
                  ]);
                },
                child: showIconsFlag == true
                    ? const Icon(
                        Icons.fullscreen,
                        color: Colors.white,
                      )
                    : Container(),
              ),
            ))
      ]),
    );
  }

  void seekItForward() async {
    Duration pos = await widget.controller.position as Duration;
    widget.controller.seekTo(Duration(seconds: 100) + pos);
  }

  void seekItBackWard() async {
    Duration pos = await widget.controller.position as Duration;
    widget.controller.seekTo(Duration(seconds: -100) + pos);
  }

  Widget fullScreenView() {
    return Container(
      color: Colors.transparent,
      height: double.infinity,
      width: double.infinity,
      child: Stack(children: [
        showIconsFlag == true
            ? Align(
                alignment: Alignment.bottomCenter,
                child: Padding(padding: EdgeInsets.all(20), child: Indicator()),
              )
            : Container(),
        Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  elevation: 0,
                  focusElevation: 0,
                  backgroundColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onPressed: () {
                    if (showIconsFlag == true) {
                      setState(() {
                        showIconsFlag = false;
                      });
                    } else {
                      setState(() {
                        showIconsFlag = true;
                      });
                    }
                  },
                  tooltip: 'Increment',
                  child: const Icon(
                    Icons.fast_rewind,
                    size: 40,
                    color: Colors.transparent,
                  ),
                ),
                showIconsFlag == true
                    ? FloatingActionButton(
                        elevation: 0,
                        focusElevation: 0,
                        backgroundColor: Colors.transparent,
                        focusColor: Colors.white,
                        onPressed: () {
                          seekItBackWard();
                        },
                        tooltip: 'Increment',
                        child: const Icon(
                          Icons.fast_rewind,
                          size: 40,
                          color: Color.fromARGB(255, 138, 137, 137),
                        ),
                      )
                    : Container(),
                const SizedBox(
                  width: 30,
                ),
                FloatingActionButton(
                  elevation: 0,
                  focusElevation: 0,
                  backgroundColor: Colors.transparent,
                  focusColor: Colors.white,
                  onPressed: () {
                    if (showIconsFlag == true) {
                      if (isplayButtonOn == true) {
                        setState(() {
                          isplayButtonOn = false;
                          widget.controller.pause();
                        });
                      } else {
                        setState(() {
                          isplayButtonOn = true;
                          widget.controller.play();
                        });
                      }
                    }
                  },
                  child: showIconsFlag == true
                      ? isplayButtonOn == true
                          ? const Padding(
                              padding: const EdgeInsets.all(0),
                              child: Icon(
                                Icons.pause_circle_outline_outlined,
                                size: 40,
                                color: Color.fromARGB(255, 216, 214, 214),
                              ),
                            )
                          : const Padding(
                              padding: const EdgeInsets.all(0),
                              child: Icon(
                                Icons.play_arrow,
                                size: 40,
                                color: Color.fromARGB(255, 216, 214, 214),
                              ),
                            )
                      : Container(),
                ),
                const SizedBox(
                  width: 30,
                ),
                showIconsFlag == true
                    ? FloatingActionButton(
                        elevation: 0,
                        focusElevation: 0,
                        backgroundColor: Colors.transparent,
                        focusColor: Colors.white,
                        onPressed: () {
                          seekItForward();
                        },
                        child: const Icon(
                          Icons.fast_forward,
                          size: 40,
                          color: Color.fromARGB(255, 138, 137, 137),
                        ),
                      )
                    : Container(),
                FloatingActionButton(
                  elevation: 0,
                  focusElevation: 0,
                  backgroundColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onPressed: () {
                    if (showIconsFlag == true) {
                      setState(() {
                        showIconsFlag = false;
                      });
                    } else {
                      setState(() {
                        showIconsFlag = true;
                      });
                    }
                  },
                  tooltip: 'Increment',
                  child: const Icon(
                    Icons.fast_rewind,
                    size: 40,
                    color: Colors.transparent,
                  ),
                ),
              ],
            )),
        Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 30, right: 10),
              child: GestureDetector(
                onTap: () {
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.portraitUp,
                    DeviceOrientation.portraitUp
                  ]);
                },
                child: showIconsFlag == true
                    ? const Icon(
                        Icons.fullscreen,
                        color: Colors.white,
                        size: 30,
                      )
                    : Container(),
              ),
            ))
      ]),
    );
  }
}
