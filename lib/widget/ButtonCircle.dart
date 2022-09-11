import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ButtonCircle extends StatelessWidget {
  Color backgroundColor;
  Color splashColor;
  double width;
  Widget child;
  Function onPress;

  ButtonCircle(this.backgroundColor, this.splashColor, this.width, this.child, this.onPress);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        height: width,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20.0,
              spreadRadius: 0.0,
            )
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(width)),
            highlightColor: Colors.transparent,
            splashColor: splashColor,
            child: Center(
              child: child,
            ),
            onTap: (){
              onPress();
            },
          ),
        ),
      ),
    );
  }

}



