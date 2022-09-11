import 'package:car_online/tool/FlareSingleLoopController.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:car_online/Config.dart';
import 'package:car_online/widget/Button.dart';

import 'AnimatedVisible.dart';

class InfoBox extends StatelessWidget {
  bool visible;
  String? name;
  IconData? iconData;
  String? iconFlare;
  String? desc;
  String buttonText;
  Function? onTap;
  bool primary;

  InfoBox({this.visible=true, this.name, this.iconData,this.iconFlare, this.desc, this.buttonText='ОК', this.onTap, this.primary=true});

  @override
  Widget build(BuildContext context) {
    return AnimatedVisible(
      visible,
      Padding(
        padding: EdgeInsets.all(40),
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: iconData!=null,
                  child: Column(
                    children: [
                      Icon(iconData, size: 50, color: Config.textColor),
                      SizedBox(height: 20),
                    ],
                  )
                ),
                Visibility(
                  visible: iconFlare!=null,
                  child: SizedBox(
                    height: 150,
                    child: FlareActor(
                      iconFlare,
                      animation: "Untitled",
                      controller: FlareSingleLoopController("Untitled", 1),
                      fit: BoxFit.fitHeight,
                      alignment: Alignment.center,
                    )
                  )
                ),
                Visibility(
                  visible: name!=null,
                  child: Text(name==null ? '' : name!, style: TextStyle(color: Config.textColor, fontSize: 18, fontWeight: FontWeight.w600),textAlign: TextAlign.center),
                ),
                Visibility(
                  visible: desc!=null,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10),
                      Text(desc==null ? '' : desc!, style: TextStyle(color: Config.textColor, fontSize: 16, fontWeight: FontWeight.w600),textAlign: TextAlign.center),
                    ],
                  ),
                ),
                Visibility(
                  visible: onTap!=null,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20),
                      Button(buttonText, (){
                        onTap!();
                      }, primary: primary)
                    ],
                  ),
                )
              ],
            )
        ),
      )
    );
  }

}



