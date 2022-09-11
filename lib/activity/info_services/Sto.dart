import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Config.dart';

class Sto extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Sto();
  }

}

class _Sto extends State<Sto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          shadowColor: Colors.transparent,
          leading: Row(
            children: <Widget>[
              SizedBox(width: Config.padding * 0.5,),
              IconButton(
                icon: Image.asset("assets/img/arrow_back.png"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          )
      ),

      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Config.primaryColor,
                        Config.primaryDarkColor,
                        //Color.fromARGB(255, 69,96,181),
                      ],
                    )
                ),

                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      Config.padding, Config.padding / 2,
                      Config.padding, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('СТО',
                          style: TextStyle(color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                        ],
                      ),

                      SizedBox(height: 90,),
                    ],
                  ),
                ),
              ),

              /*Container(
                height: (Config.activityBorderRadius * 2) + 1,
                transform: Matrix4.translationValues(
                    0.0, -(Config.activityBorderRadius * 2), 0.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                          Config.activityBorderRadius * 2),
                      topRight: Radius.circular(
                          Config.activityBorderRadius * 2),
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero
                  ),
                ),
              ),*/

              Container(
                transform: Matrix4.translationValues(
                    0.0, -(Config.activityBorderRadius * 4), 0.0
                ),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                          Config.activityBorderRadius * 2),
                      topRight: Radius.circular(
                          Config.activityBorderRadius * 2),
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero
                  ),
                ),

                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      Config.padding, Config.padding * 2,
                      Config.padding, 200
                  ),

                  child: Column(
                    children: <Widget>[

                      Row(
                        children: <Widget>[
                          Column(
                              children: [
                                Text(
                                    "В разработке"
                                ),
                              ]
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}