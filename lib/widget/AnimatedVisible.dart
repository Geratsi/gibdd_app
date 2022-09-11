

import 'package:flutter/material.dart';
import 'package:car_online/Config.dart';

class AnimatedVisible extends StatelessWidget {
  bool visible;
  Widget child;

  AnimatedVisible(this.visible, this.child);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedOpacity(
      opacity: visible ? 1 : 0,
      duration: Duration(milliseconds: Config.animDuration),
      child: Visibility(
        visible: visible,
        child: child
      )
    );
  }

}



