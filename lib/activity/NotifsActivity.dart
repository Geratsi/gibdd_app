import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_online/Storage.dart';
//import 'package:car_online/activity/profile/routes/RouteToCatInfoPage2.dart';
import 'package:car_online/entity/Notif.dart';
import 'package:car_online/entity/News.dart';
import 'package:car_online/widget/Button.dart';
//import 'package:car_online/activity/profile/routes/RouteToCarInfoPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:car_online/Config.dart';
import 'package:car_online/widget/ButtonCardWidget.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../Api.dart';

class NotifsActivity extends StatefulWidget {

  NotifsActivity();

  @override
  state createState() => state();
}

class state extends State<NotifsActivity> {

  List<Notif>? notifs;

  @override
  initState() {
    super.initState();
    Api.getNotifs().then((value){
      setState(() {
        notifs = value;
      });
    });
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
          title: Text('Уведомления'),
        ),
        backgroundColor: Config.activityBackColor,
        body:
          notifs==null ?
              Center(child: CircularProgressIndicator(color: Colors.white))
            :
              SingleChildScrollView(
                child: Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Config.padding/2),
                        for (var i=0;i<notifs!.length;i++)
                          Padding(
                            padding: EdgeInsets.fromLTRB(Config.padding, 0, Config.padding, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: Config.padding/2),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(notifs![i].channelName, style: TextStyle(color: Config.primaryColor, fontSize: 16, fontWeight: FontWeight.w600)),
                                    Text(notifs![i].date, style: TextStyle(color: Config.primaryColor, fontSize: 16, fontWeight: FontWeight.w600)),
                                  ],
                                ),
                                SizedBox(height: Config.padding/2),
                                Text(notifs![i].text, style: TextStyle(color: Config.textColor, fontSize: 16)),
                                SizedBox(height: Config.padding),
                                i<notifs!.length-1 ?
                                  Container(
                                    height: 1,
                                    color: Colors.grey.withOpacity(0.5),
                                  )
                                : SizedBox(),
                                SizedBox(height: Config.padding/2),
                              ],
                            ),
                          )

                      ],
                    )
                )
            )
    );
  }
}

