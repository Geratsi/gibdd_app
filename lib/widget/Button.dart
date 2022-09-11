import 'package:car_online/widget/ProgressWait.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:car_online/Config.dart';

class Button extends StatelessWidget {
  String text;
  Function callback;

  IconData? iconData;
  double? iconSize;
  double? size;
  bool isWait;
  bool isVisible;
  bool isBlock;
  bool? primary;
  Color? color;
  Color? backgroundColor;
  EdgeInsetsGeometry? margin;
  EdgeInsetsGeometry? padding;

  Button(this.text, this.callback, {
    this.iconData,
    this.size,
    this.iconSize,
    this.primary,
    this.color,
    this.backgroundColor,
    this.isWait=false,
    this.isVisible=true,
    this.margin,
    this.padding,
    this.isBlock=false,
  });

  @override
  Widget build(BuildContext context) {
    if (primary!=null){
      backgroundColor = primary! ? Config.primaryColor : Config.activityHintColor;
      color = primary! ? Config.textColorOnPrimary : Config.textColor;
    } else {
      if (backgroundColor==null) backgroundColor = Config.activityHintColor;
      if (color==null) color = Config.textColor;
    }
    return Visibility(
      visible: isVisible,
      child: SizedBox(
        width: isBlock ? double.infinity : null,
        child: Padding(
            padding: margin==null ? EdgeInsets.all(0) : margin!,
            child: Container(
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(Config.activityBorderRadius),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(Config.activityBorderRadius),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        child: Padding(
                          padding: padding==null ? EdgeInsets.fromLTRB(Config.padding, Config.padding/2, Config.padding, Config.padding/2) : padding!,
                          child: Stack(
                            children: [
                              Opacity(
                                  opacity: isWait ? 0 : 1,
                                  child: Row(
                                    mainAxisSize: isBlock ? MainAxisSize.max : MainAxisSize.min,
                                    mainAxisAlignment: isBlock ? MainAxisAlignment.center : MainAxisAlignment.start,
                                    children: [
                                      Visibility(
                                          visible: text!=null,
                                          child: Text(text, style: TextStyle(
                                            color:color,
                                            fontWeight: FontWeight.w500,
                                            fontSize: size==null ? Config.textMediumSize : size,
                                          ))
                                      ),
                                      Visibility(
                                          visible: iconData!=null,
                                          child: Padding(
                                              padding: padding==null ? EdgeInsets.fromLTRB(10, 0, 0, 0) : EdgeInsets.fromLTRB(padding!.horizontal/4, 0, 0, 0),
                                              child: Icon(iconData, color: color, size: iconSize==null ? (size==null ? Config.textMediumSize : size!*1.5) : iconSize)
                                          )
                                      ),
                                    ],
                                  )
                              ),
                              Visibility(
                                  visible: isWait,
                                  child: Positioned.fill(
                                      child: ProgressWait(
                                        visible: isWait,
                                        color: color!,
                                        size: ProgressWaitSize.medium,
                                        isBlock: false,
                                      )
                                  )
                              )
                            ],
                          ),
                        ),
                        onTap: (){
                          callback();
                        },
                      ),
                    )
                )
            )
        )
      )
    );
  }

}



