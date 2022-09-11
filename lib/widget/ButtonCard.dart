import 'package:flutter/material.dart';

import '../Config.dart';

class ButtonCard extends StatelessWidget {
  String text;
  double? textSize;
  Color? textColor;
  Function onTap;
  Color? color;
  Widget icon;

  ButtonCard(this.text, this.icon, this.color, this.onTap, {this.textSize, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:color,
        borderRadius: BorderRadius.circular(Config.activityBorderRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Config.activityBorderRadius),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            child: Column(
              children:[
                Align(
                  alignment: FractionalOffset.center,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(Config.padding, Config.padding, Config.padding, Config.padding/4),
                    child: icon
                  ),
                ),
                Text(
                  text,
                  style: TextStyle(color: textColor ?? Config.textColor, fontSize: textSize ?? 16, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                )
              ]
            ),
            onTap: (){
              onTap();
            },
          )
        )
      )
    );
  }

}



