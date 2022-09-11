
import 'package:flutter/material.dart';
import 'package:car_online/Config.dart';
import 'package:car_online/entity/Traffic.dart';
import 'package:car_online/activity/traffics/TrafficActivity.dart';

class FavouriteTrafficsActivity extends StatefulWidget {
  FavouriteTrafficsActivity({
    Key? key,
    required this.traffics,
  });

  final List<Traffic> traffics;

  @override
  state createState() => state();
}

class state extends State<FavouriteTrafficsActivity> {
  late List<Traffic> traffics;

  @override
  initState() {
    super.initState();
    traffics = widget.traffics;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Трафик'),
          shadowColor: Colors.transparent,
          leading: Row(
            children: <Widget>[
              SizedBox(
                width: Config.padding * 0.5,
              ),
              IconButton(
                icon: Image.asset("assets/img/arrow_back.png"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),

        body: traffics.isEmpty
            ? Center(child: CircularProgressIndicator(color: Colors.white))
            : SingleChildScrollView(
            child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < traffics.length; i++)
                      traffics[i].isSelected == false
                          ? Container()
                          : Material(
                          color: Colors.transparent,
                          child: InkWell(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                  Config.padding, Config.padding / 2,
                                  Config.padding, Config.padding / 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 28,
                                        height: 28,
                                        decoration: BoxDecoration(
                                          color: traffics[i].pointsColor,
                                          borderRadius: BorderRadius.circular(Config.activityBorderRadius),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "${traffics[i].points}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: Config.padding / 2),
                                      Expanded(
                                          child: Text(traffics[i].name,
                                              style: TextStyle(
                                                  color: Config.textColor,
                                                  fontSize: 16))),
                                      SizedBox(width: Config.padding / 2),
                                    ],
                                  ),
                                  i < traffics.length - 1
                                      ? Container(
                                    height: 1.5,
                                    transform:
                                    Matrix4.translationValues(0.0,
                                        Config.padding / 2, 0.0),
                                    color: Colors.grey.withOpacity(0.5),
                                  )
                                      : SizedBox(),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TrafficActivity(traffic: traffics[i])));
                            },
                          ))
                  ],
                ))));
  }
}