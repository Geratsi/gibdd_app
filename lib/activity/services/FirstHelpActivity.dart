import 'package:flutter/material.dart';
import 'package:car_online/Config.dart';

class FirstHelpActivity extends StatefulWidget {
  const FirstHelpActivity({Key? key}) : super(key: key);

  @override
  _FirstHelpActivityState createState() => _FirstHelpActivityState();
}

class _FirstHelpActivityState extends State<FirstHelpActivity> {
  @override
  Widget build(BuildContext context) {
    final windowWidth = MediaQuery.of(context).size.width;
    final itemWidth = (windowWidth - Config.padding * 3) / 2;

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: Text('Первая помощь'),
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

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        Config.padding, Config.padding,
                        Config.padding, 40
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 38,
                          child: TextField(
                            style: TextStyle(color: Colors.white.withOpacity(0.8)),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide: BorderSide(width: 0, style: BorderStyle.none),
                                ),
                                contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                filled: true,
                                hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
                                hintText: "Поиск...",
                                fillColor: Config.primaryDarkColor,
                                suffixIcon: Icon(Icons.search, color: Colors.white)
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Container(
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
                  bottomRight: Radius.zero,
                ),
              ),
            ),

            Container(
              transform: Matrix4.translationValues(0.0, -(Config.activityBorderRadius * 4), 0.0),
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
                  Config.padding, Config.padding,
                  Config.padding, Config.padding / 2,
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Image.asset("assets/img/help-1.png", width: itemWidth, height: itemWidth,),
                            Text('Массаж сердца', style: TextStyle(fontSize: 20),),
                            SizedBox(height: 20,),
                          ],
                        ),

                        Column(
                          children: <Widget>[
                            Image.asset("assets/img/help-2.png", width: itemWidth, height: itemWidth,),
                            Text('Искуственное', style: TextStyle(fontSize: 20),),
                            Text('дыхание', style: TextStyle(fontSize: 20),),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 20,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Image.asset("assets/img/help-3.png", width: itemWidth, height: itemWidth,),
                            Text('Перелом', style: TextStyle(fontSize: 20),),
                            SizedBox(height: 20,),
                          ],
                        ),

                        Column(
                          children: <Widget>[
                            Image.asset("assets/img/help-4.png", width: itemWidth, height: itemWidth,),
                            Text('Кровотечение', style: TextStyle(fontSize: 20),),
                            SizedBox(height: 20,),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 20,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Image.asset("assets/img/help-2.png", width: itemWidth, height: itemWidth,),
                            Text('Искуственное', style: TextStyle(fontSize: 20),),
                            Text('дыхание', style: TextStyle(fontSize: 20),),
                          ],
                        ),

                        Column(
                          children: <Widget>[
                            Image.asset("assets/img/help-1.png", width: itemWidth, height: itemWidth,),
                            Text('Массаж сердца', style: TextStyle(fontSize: 20),),
                            SizedBox(height: 20,),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

