import 'dart:async';
import 'dart:ui';

import 'package:car_online/entity/Traffic.dart';
import 'package:car_online/widget/ProgressWait.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:car_online/Config.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../../Api.dart';

class TrafficDetailActivity extends StatefulWidget {

  int id;

  TrafficDetailActivity(this.id);

  @override
  state createState() => state();
}

class state extends State<TrafficDetailActivity> {
  Traffic? traffic;
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  bool isLoading = true;

  @override
  initState() {
    super.initState();
    Api.getTraffic(widget.id).then((value){
      setState(() {
        traffic = value;
      });

      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.width*0.8;

      flutterWebviewPlugin.launch(
        'http://admin:Dahua123@78.138.133.226/cgi-bin/mjpg/video.cgi?channel=1&subtype=1',
        withOverviewMode: true,
        withZoom: true,
        rect: Rect.fromLTWH(
          0.0,
          MediaQuery.of(context).viewPadding.top+AppBar().preferredSize.height,
          width,
          height,
        ),
        hidden: true,
        scrollBar: false
      );

      Timer.periodic(
        Duration(seconds:3),
        (Timer timer) {
          flutterWebviewPlugin.evalJavascript('document.querySelector(\'html\').innerHTML += "";document.querySelector(\'body\').innerHTML += "<style>*{width:${width}px !important;height:${height}px !important}</style>";');
          timer.cancel();
          flutterWebviewPlugin.show();
          setState(() {
            isLoading = false;
          });
        },
      );

    });
  }

  @override
  void dispose() {
    super.dispose();
    flutterWebviewPlugin.close();
  }

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
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Видео с камеры', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14)),
            traffic==null ? SizedBox() : Text(traffic!.name),
          ],
        ),
      ),
      backgroundColor: Config.activityBackColor,
      body: Stack(
        children: [
          ProgressWait(
            visible: isLoading,
            color: Config.primaryColor,
            size: ProgressWaitSize.large,
          )
        ],
      ),
    );
  }
}

