import 'dart:async';

import 'package:flutter/material.dart';
import 'package:car_online/Config.dart';
import 'package:car_online/widget/AnimatedVisible.dart';


class ProgressWait extends StatefulWidget {
  bool visible;
  EdgeInsets? padding;
  ProgressWaitSize size;
  String? text;
  bool? primary;
  Color? color;
  bool isBlock;

  ProgressWait({this.visible = true, this.primary, this.color, this.padding, this.size = ProgressWaitSize.medium, this.text, this.isBlock=true});

  @override
  ActivityState createState() => ActivityState();
}

class ActivityState extends State<ProgressWait>{

  bool isFirst = true;
  int index = 1;
  Timer? timer1;
  Duration duration = Duration(milliseconds: Config.animDuration);
  double size = 8;
  Color? color;

  @override
  initState(){
    timer1 = new Timer.periodic(duration, (Timer t){
      if (widget.visible)
        setState(() {
          index = index==6 ? 1 : index+1;
        });
    });
    if (widget.size==ProgressWaitSize.small) size = 6;
    if (widget.size==ProgressWaitSize.medium) size = 8;
    if (widget.size==ProgressWaitSize.large) size = 12;
    super.initState();
  }
  @override
  void dispose() {
    if (timer1!=null) timer1!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.primary!=null){
      color = widget.primary! ? Config.progressColor : Config.progressHintColor;
    } else {
      color = widget.color;
    }
    return Visibility(
      visible: widget.visible,
      child: Padding(
        padding: widget.padding!=null ? widget.padding! : EdgeInsets.all(0),
        child: Column(
          mainAxisSize: widget.isBlock ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: widget.isBlock ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedOpacity(
                    opacity: index==1 ? 1: 0.25,
                    duration: duration,
                    child: Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    )
                ),
                SizedBox(width: size/3),
                AnimatedOpacity(
                    opacity: index==2 ? 1: 0.25,
                    duration: duration,
                    child: Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    )
                ),
                SizedBox(width: size/3),
                AnimatedOpacity(
                    opacity: index==3 ? 1: 0.25,
                    duration: duration,
                    child: Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    )
                ),
              ],
            ),
            Visibility(
                visible: widget.text!=null,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text('${widget.text}', style: TextStyle(color: Config.textColor, fontSize: 16, fontWeight: FontWeight.w600),textAlign: TextAlign.center)
                )
            )
          ],
        )
      )
    );
  }
}

enum ProgressWaitSize {
  small,
  medium,
  large
}



