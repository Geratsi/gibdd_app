import 'dart:async';
import 'dart:io';

import 'package:car_online/activity/services/inspector/cards/InspectorMaterialVideo.dart';
import 'package:car_online/activity/services/inspector/models/InspectorMaterialModel.dart';
import 'package:flutter/material.dart';
import 'package:car_online/Config.dart';
import 'package:video_player/video_player.dart';

class VideoDialogActivity extends StatefulWidget {
  const VideoDialogActivity({
    Key? key,
    required this.model,
  }) : super(key: key);

  final InspectorMaterialModel model;

  @override
  _VideoDialogActivityState createState() => _VideoDialogActivityState();
}

class _VideoDialogActivityState extends State<VideoDialogActivity> {
  late VideoPlayerController controller;
  late Future<void> initializeVideoPlayerFuture;

  @override
  void initState() {
    if (widget.model.isAsset) {
      controller = VideoPlayerController.asset(widget.model.sourceURL);
    } else {
      controller = VideoPlayerController.file(File(widget.model.sourceURL));
    }

    initializeVideoPlayerFuture = controller.initialize();

    super.initState();
  }

  bool _isTapped = false;

  @override
  void dispose() {
    controller.pause();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: InteractiveViewer(
            child: FutureBuilder(
              future: initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Config.activityBorderRadius / 2),
                          color: Config.activityBackColor,
                        ),
                        padding: EdgeInsets.all(Config.padding / 4),
                        child: AspectRatio(aspectRatio: controller.value.aspectRatio, child: VideoPlayer(controller),),
                        // child: controller.value.aspectRatio < 1
                        //     ? RotatedBox(
                        //       quarterTurns: 3,
                        //       child: AspectRatio(aspectRatio: controller.value.aspectRatio,
                        //         child: VideoPlayer(controller),
                        //       ),
                        //     )
                        //     : AspectRatio(aspectRatio: controller.value.aspectRatio,
                        //       child: VideoPlayer(controller),
                        // ),
                      ),

                      AnimatedOpacity(
                        opacity: _isTapped ? 0.0 : 1.0,
                        duration: const Duration(milliseconds: 100),
                        child: GestureDetector(
                          onTapUp: (_) {
                            setState(() {
                              _isTapped = false;
                            });
                          },

                          onTapDown: (_) {
                            Timer(const Duration(seconds: 1), () {
                              setState(() {_isTapped = true;});
                            });
                          },

                          onTap: () {
                            setState(() {
                              if (controller.value.isPlaying) {
                                controller.pause();
                              } else {
                                controller.play();
                              }
                            });
                          },

                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Icon(controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                              color: Config.activityBackColor, size: 50,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );

                } else {
                  return Center(child: CircularProgressIndicator.adaptive(),);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

