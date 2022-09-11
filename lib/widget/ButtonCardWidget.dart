import 'dart:async';

import 'package:flutter/material.dart';

import '../Config.dart';

class ButtonCardWidget extends StatefulWidget {
  double size;
  double borderRadius;
  double? borderSize;
  bool isInnerBorder;
  Widget? back;
  Function? isActiveHandler;
  Function? onTap;
  Color? bgColor;
  ButtonCardWidget(this.size,this.borderRadius,this.back,
      {this.borderSize, this.isActiveHandler, this.isInnerBorder=false, this.onTap, this.bgColor});

  @override
  state createState() => state();
}

class state extends State<ButtonCardWidget>{

  Color? borderColor = Config.primaryDarkColor;

  @override
  initState(){
    if (widget.isActiveHandler!=null)
      setState(() {
        borderColor = widget.isActiveHandler!() ? Colors.white : Config.primaryDarkColor;
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onTap!=null)
          widget.onTap!();
      },
      onTapDown: (d){
        setState(() {
          borderColor = Colors.white.withOpacity(0.5);
        });
        Timer(Duration(milliseconds: 100), () {
          if (this.mounted)
            setState(() {
              borderColor = widget.isActiveHandler!=null ? widget.isActiveHandler!() ? Colors.white : Config.primaryDarkColor : Config.primaryDarkColor;
            });
        });
      },
      child:
        widget.isInnerBorder ?
          Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                color: borderColor,
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              padding: EdgeInsets.all(widget.borderSize==null ? 0 : widget.borderSize!),
              child: Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                      color: Config.primaryDarkColor,
                      borderRadius: BorderRadius.circular(widget.borderRadius*0.9),
                      border: Border.all(color: Config.primaryColor, width: widget.borderSize==null ? 0 : widget.borderSize!)
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(widget.borderRadius*0.9),
                      child: widget.back
                  )
              )
          )
      :
      Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
              color: widget.bgColor == null ? Config.primaryDarkColor : widget.bgColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(color:borderColor!, width: 2)
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.borderRadius - 2),
              child: widget.back
          )
      )



    );
  }
}




