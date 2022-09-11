import 'dart:async';

//import 'package:car_online/activity/profile/routes/RouteToCatInfoPage2.dart';
import 'package:car_online/entity/News.dart';
//import 'package:car_online/activity/profile/routes/RouteToCarInfoPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:car_online/Config.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Api.dart';
import 'CommentsActivity.dart';

class NewsActivity extends StatefulWidget {
  List<News> newsList = [];
  int newsIndex;

  NewsActivity(this.newsList, this.newsIndex);

  @override
  state createState() => state();
}

class state extends State<NewsActivity> with SingleTickerProviderStateMixin{
  TabController? controller;
  int index = 0;

  @override
  initState() {
    super.initState();
    controller = TabController(
      initialIndex: widget.newsIndex,
      length: widget.newsList.length,
      vsync: this
    );
    index = widget.newsIndex;
    controller!.addListener(() {
      setState(() {
        index = controller!.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
        backgroundColor: Config.primaryColor,
        body:Stack(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(Config.padding, Config.padding/2, Config.padding, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (var i=0;i<widget.newsList.length;i++)
                    Container(
                        width: (width/widget.newsList.length)-Config.padding,
                        height: Config.padding/3,
                        decoration: BoxDecoration(
                          color: index==i ? Colors.white : Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(Config.activityBorderRadius),
                        ),
                    )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, Config.padding, 0, 0),
              child: TabBarView(
                controller: controller,
                children: <Widget>[
                  for (var i=0;i<widget.newsList.length;i++)
                    SingleChildScrollView(
                      child: Container(
                        color: Config.primaryColor,
                        padding: EdgeInsets.all(Config.padding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(widget.newsList[i].name, style: TextStyle(color: Colors.white, fontSize: 20)),
                            SizedBox(height: Config.padding/2),
                            GestureDetector(
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(Config.activityBorderRadius*2),
                                  child: Image.asset(
                                      widget.newsList[i].imageDetail,
                                      fit : BoxFit.fill,
                                      width: width
                                  )
                              ),
                              onTap: (){
                                if (controller!.index+1<widget.newsList.length)
                                controller!.index++;
                              },
                            ),
                            SizedBox(height: Config.padding/2),
                            Text(widget.newsList[i].des, style: TextStyle(color: Colors.white, fontSize: 16)),
                            SizedBox(height: Config.padding/2),
                            Text("17 ноября, 10:30", style: TextStyle(color: Colors.white, fontSize: 16)),
                            SizedBox(height: Config.padding/2),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      Api.addNewsLike(widget.newsList[i]).then((value){
                                        setState(() {
                                          widget.newsList[i] = value;
                                        });
                                      });
                                    });
                                  },
                                  child: Icon(MdiIcons.thumbUp, color: Colors.white),
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(Config.padding*3, Config.padding*3),
                                      padding: EdgeInsets.zero,
                                      shape: CircleBorder(),
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      shadowColor: Colors.transparent
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, Config.padding*0.9, 0, 0),
                                  child: Text("${widget.newsList[i].likes}", style: TextStyle(color: Colors.white, fontSize: 16)),
                                ),

                                SizedBox(width: Config.padding/2),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Icon(MdiIcons.thumbDown, color: Colors.white),
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(Config.padding*3, Config.padding*3),
                                      padding: EdgeInsets.zero,
                                      shape: CircleBorder(),
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      shadowColor: Colors.transparent
                                  ),
                                ),
                                SizedBox(width: Config.padding/2),
                                ElevatedButton(
                                  onPressed: () async {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => CommentsActivity(widget.newsList[i].name, 10)));
                                  },
                                  child: Icon(MdiIcons.message, color: Colors.white),
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(Config.padding*3, Config.padding*3),
                                      padding: EdgeInsets.zero,
                                      shape: CircleBorder(),
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      shadowColor: Colors.transparent
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, Config.padding*0.9, 0, 0),
                                  child: Text("${widget.newsList[i].commentsLength}", style: TextStyle(color: Colors.white, fontSize: 16)),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    )
                ],
              )
            )
          ],
        ),

    );

  }
}

