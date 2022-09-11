
import 'package:car_online/Api.dart';
import 'package:car_online/widget/MainButton.dart';
import 'package:flutter/material.dart';
import 'package:car_online/Config.dart';
import 'package:url_launcher/url_launcher.dart';

class MainInformationActivity extends StatelessWidget {
  const MainInformationActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: Text('Справочные материалы'),
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
                              suffixIcon: Icon(Icons.search, color: Colors.white),
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
                    bottomRight: Radius.zero
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

                child: GridView.count(
                  shrinkWrap: true,
                  primary: false,
                  crossAxisSpacing: Config.padding / 1.5,
                  mainAxisSpacing: Config.padding / 1.5,
                  crossAxisCount: 2,
                  childAspectRatio: MediaQuery.of(context).size.width/110,
                  children: [
                    MainButton(label: 'КоАП',
                      onPressed: () {
                        canLaunch("https://xn--b1aew.xn--p1ai/folder/2296021").then((value){
                          if (value) launch("https://xn--b1aew.xn--p1ai/folder/2296021");
                        });
                      },
                      bgColor: Config.primaryColor, labelColor: Colors.white,
                    ),

                    MainButton(label: 'Штрафы',
                      onPressed: () {
                        canLaunch("https://auto.mail.ru/info/penalty").then((value){
                          if (value) launch("https://auto.mail.ru/info/penalty");
                        });
                      },
                      bgColor: Config.primaryColor, labelColor: Colors.white,
                    ),
                  ],
                ),
                // child: Column(
                //   children: <Widget>[
                //     Row(
                //       children: <Widget>[
                //         Expanded(
                //           child: MainButton(label: 'КоАП', onPressed: () {}, bgColor: Config.primaryColor, labelColor: Colors.white),
                //         ),
                //         Expanded(
                //           child: MainButton(label: 'Штрафы', onPressed: () {}, bgColor: Config.primaryColor, labelColor: Colors.white),
                //         ),
                //       ],
                //     )
                //   ],
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

