import 'package:flutter/material.dart';

import '../Config.dart';

class MenuBottom extends StatelessWidget {
  String text;
  Widget icon;
  Color color;
  Function onTap;

  MenuBottom(this.text, this.icon, this.color, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:Material(
        color: Colors.transparent,
        child: InkWell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              Align(
                alignment: FractionalOffset.center,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(Config.padding, Config.padding/1.5, Config.padding, Config.padding/4),
                    child: icon
                ),
              ),
              Text(
                text,
                style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              )
            ]
          ),
          onTap: (){
            onTap();
          },
        )
      ),
    );
  }

}



