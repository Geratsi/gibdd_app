import 'package:flutter/material.dart';
import 'package:car_online/Config.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CrackAnaliseComponent extends StatefulWidget {
  const CrackAnaliseComponent({
    Key? key,
    required this.videoHash,
    this.comments,
  }) : super(key: key);

  final String videoHash;
  final String? comments;

  @override
  State<CrackAnaliseComponent> createState() => _CrackAnaliseComponentState();
}

class _CrackAnaliseComponentState extends State<CrackAnaliseComponent> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: widget.videoHash,
      flags: YoutubePlayerFlags(autoPlay: false, mute: true, enableCaption: false, loop: true),
    )..addListener(() {});
  }

  @override
  void deactivate() {
    super.deactivate();

    _controller.pause();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Config.padding),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Config.activityBorderRadius),
            border: Border.all(width: 1, color: Config.activityHintColor),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(Config.activityBorderRadius - 1),
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: false,
                  progressIndicatorColor: Colors.redAccent,
                  progressColors: ProgressBarColors(
                    playedColor: Config.primaryColor,
                    handleColor: Config.primaryDarkColor,
                  ),
                  onReady: () {},
                  topActions: [
                    Expanded(
                      child: Text(
                        _controller.metadata.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white, fontSize: Config.textLargeSize),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),

              widget.comments != null ?
              Padding(
                padding: EdgeInsets.all(Config.padding / 2),
                child: Text(
                  widget.comments!,
                  style: TextStyle(color: Config.textColor,
                      fontSize: Config.textMediumSize),),
              ) : SizedBox(),
            ],
          )
      ),
    );
  }
}

