import 'dart:io';

import 'package:car_online/Config.dart';
import 'package:car_online/activity/services/inspector/models/InspectorMaterialModel.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class InspectorMaterialVideo extends StatefulWidget {
  const InspectorMaterialVideo({
    Key? key,
    required this.model,
  }) : super(key: key);

  final InspectorMaterialModel model;

  @override
  _InspectorMaterialVideoState createState() => _InspectorMaterialVideoState();
}

class _InspectorMaterialVideoState extends State<InspectorMaterialVideo> {
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
  
  @override
  void dispose() {
    controller.dispose();
    
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Stack(
            children: <Widget>[
              Wrap(
                children: <Widget>[
                  Transform.scale(
                    scale: 1.2,
                    child: AspectRatio(aspectRatio: controller.value.aspectRatio,
                      child: VideoPlayer(controller),
                    ),
                  ),
                ],
              ),

              Center(
                child: Icon(Icons.play_arrow, size: 50, color: Config.activityBackColor,),
              ),
            ],
          );

        } else {
          return
            Center(child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }
}

