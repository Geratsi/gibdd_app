import 'package:car_online/Api.dart';
import 'package:car_online/Config.dart';
import 'package:car_online/activity/NewsActivity.dart';
import 'package:car_online/activity/traffics/TrafficsActivity.dart';
import 'package:car_online/activity/WeatherActivity.dart';
import 'package:car_online/activity/profile/check_pdd/ui/CheckPddActivity.dart';
import 'package:car_online/activity/services/FirstHelpActivity.dart';
import 'package:car_online/activity/services/MainInformationActivity.dart';
import 'package:car_online/activity/services/accident/TrafficAccidentActivity.dart';
import 'package:car_online/activity/services/check/VerifyPage.dart';
import 'package:car_online/activity/services/crackAnalise/CrackAnaliseActivity.dart';
import 'package:car_online/activity/services/evacuation/EvacuationPage.dart';
import 'package:car_online/activity/services/fines/FinesPage.dart';
import 'package:car_online/activity/services/inspector/InspectorActivity.dart';
import 'package:car_online/activity/services/registration_unit/ui/RegistrationUnitPage.dart';
import 'package:car_online/activity/traffics/TrafficsActivity.dart';
import 'package:car_online/entity/News.dart';
import 'package:car_online/entity/Weather.dart';
import 'package:car_online/widget/ButtonCard.dart';
import 'package:car_online/widget/ButtonCardWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import 'NotifsActivity.dart';

class MainActivity extends StatefulWidget {
  @override
  state createState() => state();
}

class state extends State<MainActivity> with TickerProviderStateMixin {

  TextEditingController searchController = new TextEditingController();
  Weather? weather = null;

  List<News> news = [];

  @override
  initState() {
    super.initState();

    Api.getNewsList().then((value){
      setState(() {
        news = value;
      });
    });


    Api.getWeatherInfo().then((value) {
      if (mounted)
        setState(() {
          weather = value;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Config.activityBackColor,
      appBar: AppBar(
        backgroundColor: Config.primaryColor,
        shadowColor: Colors.transparent,
        centerTitle: false,
        title: Container(
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
            )
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NotifsActivity()));
            },
          )
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                Config.padding, Config.padding / 2,
                                Config.padding, 0),
                            child: Text("Добрый день, Михаил",
                                style: TextStyle(color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500)),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.fromLTRB(
                                Config.padding, Config.padding,
                                Config.padding, Config.padding),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    ButtonCardWidget(
                                        40,
                                        Config.activityBorderRadius,
                                        Padding(
                                          padding: EdgeInsets.all(Config.padding/3),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.circular(60),
                                              ),
                                              child: Center(
                                                  child: Text("3",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .white,
                                                          fontSize: 18,
                                                          fontWeight: FontWeight
                                                              .w600))
                                              ),
                                            )
                                        ),
                                        borderSize: 2,
                                        isInnerBorder: false,
                                        onTap: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => TrafficsActivity())
                                          );
                                        },
                                    ),
                                    SizedBox(height: Config.padding / 2),
                                    ButtonCardWidget(
                                        40,
                                        Config.activityBorderRadius,
                                        weather == null ?
                                          Container(
                                              padding: EdgeInsets.all(8),
                                              child: CircularProgressIndicator()
                                          ) :
                                        Stack(
                                          children: [
                                            Opacity(
                                                opacity: 0.3,
                                                child: Center(
                                                    child: SvgPicture.network(
                                                      weather!.iconUrl,
                                                      width: Config.padding*2,
                                                      placeholderBuilder: (
                                                          BuildContext context) =>
                                                          Container(
                                                              padding: EdgeInsets.all(2),
                                                              child: CircularProgressIndicator()
                                                          ),
                                                    )
                                                )
                                            ),
                                            Center(
                                                child: Text("${weather!.temp}", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600))
                                            )
                                          ],
                                        ),
                                        borderSize: 2,
                                        isInnerBorder: false,
                                        onTap: () async {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => WeatherActivity())
                                          );
                                          /*
                                          showDialog<void>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(Config.activityBorderRadius))),
                                                  backgroundColor: Config.activityBackColor,
                                                  contentPadding: EdgeInsets.all(Config.padding),
                                                  content: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      WeatherView(weather!),
                                                      SizedBox(height: Config.padding/2),
                                                      Button('ОК', () {
                                                        Navigator.of(context).pop();
                                                      },isBlock: true)
                                                    ]
                                                  ),
                                                );
                                              }
                                          );
                                           */
                                        },
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 90,
                                  padding: EdgeInsets.fromLTRB(Config.padding / 2, 0, 0, 0),
                                  child: Row(
                                        children: [
                                          for (var i=0;i<news.length;i++)
                                            Row(
                                              children: [
                                                ButtonCardWidget(
                                                  90,
                                                  Config.activityBorderRadius * 1.5,
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        child: Stack(
                                                          children: [
                                                            Image.asset(
                                                                news[i].image,
                                                                width: 90 +
                                                                    Config.padding / 2,
                                                                height: 90 +
                                                                    Config.padding / 2,
                                                                fit: BoxFit.cover
                                                            ),
                                                            Container(
                                                              color: Colors.black.withOpacity(0.5),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Positioned(
                                                          bottom: 0,
                                                          left: 0,
                                                          right: 0,
                                                          child: Padding(
                                                              padding: EdgeInsets
                                                                  .fromLTRB(
                                                                  Config.padding /
                                                                      4,
                                                                  Config.padding /
                                                                      2,
                                                                  Config.padding /
                                                                      4,
                                                                  Config.padding /
                                                                      2),
                                                              child: Text(
                                                                  news[i]
                                                                      .name,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize: 13,
                                                                      fontWeight: FontWeight
                                                                          .w600)
                                                              )
                                                          )
                                                      )
                                                    ],
                                                  ),
                                                  borderSize: 2,
                                                  isInnerBorder: true,
                                                  onTap: (){
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => NewsActivity(news, i))
                                                    );
                                                  },
                                                ),
                                                SizedBox(width: i ==
                                                    news.length - 1 ? 0 : Config
                                                    .padding / 2),
                                              ],
                                            )
                                        ]
                                    )
                                ),
                                //SizedBox(width: Config.padding*0.8),
                              ],
                            ),
                          ),
                          SizedBox(height: Config.activityBorderRadius * 2),
                        ],
                      )
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
                      transform: Matrix4.translationValues(
                          0.0, -(Config.activityBorderRadius * 4), 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.all(Config.padding),
                              child: Text(
                                  "Основные", style: TextStyle(color: Config
                                  .textTitleColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500))
                          ),
                          GridView.count(
                            shrinkWrap: true,
                            primary: false,
                            padding: EdgeInsets.fromLTRB(
                                Config.padding, 0, Config.padding,
                                Config.padding / 2
                            ),
                            crossAxisSpacing: Config.padding / 1.5,
                            mainAxisSpacing: Config.padding / 1.5,
                            crossAxisCount: 3,
                            childAspectRatio: width/410,
                            children: <Widget>[
                              ButtonCard(
                                  "Народный инспектор",
                                  Image.asset("assets/img/People.png"),
                                  Config.baseInfoColor,
                                      () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => InspectorActivity())
                                    );
                                  }
                              ),
                              ButtonCard(
                                  "Проверка\nавто и ВУ",
                                  Image.asset(
                                      "assets/img/Driver License.png"),
                                  Config.baseInfoColor,
                                      () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => VerifyPage())
                                    );
                                  }
                              ),
                              /*ButtonCard(
                                  "Онлайн камеры",
                                  Image.asset("assets/img/Bullet Camera.png"),
                                  Config.baseInfoColor,
                                  () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => OnlineMapsActivity())
                                    );
                                  }
                              ),*/
                              ButtonCard(
                                  "Штрафы",
                                  Image.asset("assets/img/Card Payment.png"),
                                  Config.baseInfoColor,
                                      () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => FinesPage())
                                    );
                                  }
                              ),
                              ButtonCard(
                                  "Проверка эвакуации",
                                  Image.asset("assets/img/Tow Truck.png"),
                                  Config.baseInfoColor,
                                      () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => EvacuationPage())
                                        );
                                      }
                              ),
                              ButtonCard(
                                  "Оформить ДТП",
                                  Image.asset(
                                      "assets/img/Hazard Warning Flasher.png"),
                                  Config.baseInfoColor,
                                  () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => TrafficAccidentActivity())
                                    );
                                  }
                              ),
                              ButtonCard(
                                  "Регистрация \nТС",
                                  Image.asset(
                                      "assets/img/Driver License.png"),
                                  Config.baseInfoColor,
                                      () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => RegistrationUnitPage())
                                        );
                                      }
                              ),
                              ButtonCard(
                                  "Проверка\nзнаний ПДД",
                                  Image.asset(
                                    "assets/img/test-icon.png",
                                    width: 50,
                                    height: 50,
                                  ),
                                  Config.baseInfoColor,
                                      () {
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => CheckPddActivity()));
                                  }
                              ),
                              ButtonCard(
                                  "Разбор ДТП",
                                  Image.asset(
                                    "assets/img/crash.png",
                                    width: 50,
                                    height: 50,
                                  ),
                                  Config.baseInfoColor,
                                      () {
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => CrackAnaliseActivity())
                                        );
                                      }
                              ),
                            ],
                          ),
                          GridView.count(
                            shrinkWrap: true,
                            primary: false,
                            padding: EdgeInsets.fromLTRB(
                                Config.padding, 0, Config.padding, 0),
                            crossAxisSpacing: Config.padding / 1.5,
                            mainAxisSpacing: Config.padding / 1.5,
                            crossAxisCount: 2,
                            childAspectRatio: width/230,
                            children: <Widget>[
                              ButtonCard(
                                "Первая\nпомощь",
                                Image.asset("assets/img/plus.png"),
                                Config.baseWarningInfoColor,
                                () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => FirstHelpActivity()));
                                },
                              ),
                              ButtonCard(
                                "Позвонить\nв ГИБДД",
                                Image.asset("assets/img/phone.png"),
                                Config.baseWarningInfoColor,
                                    () async {
                                  if (await canLaunch("tel:88435333888")) {
                                    await launch("tel:88435333888");
                                  } else {
                                    throw 'Could not launch';
                                  }
                                },
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: Config.padding / 1.5, horizontal: Config.padding),
                            child: Material(
                              color: Config.baseInfoColor,
                              borderRadius: BorderRadius.circular(Config.activityBorderRadius),
                              child: InkWell(
                                splashColor: Config.primaryLightColor,
                                borderRadius: BorderRadius.circular(Config.activityBorderRadius),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: Config.padding, horizontal: Config.padding / 3),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Text('Справочная информация',
                                            style: TextStyle(
                                              color: Config.textColor,
                                              fontSize: Config.textMediumSize,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => MainInformationActivity()));
                                  // canLaunch("https://www.gosuslugi.ru/").then((value){
                                  //   if (value) launch("https://www.gosuslugi.ru/");
                                  // });
                                },
                              ),
                            ),
                          ),

                          // Padding(
                          //   padding: EdgeInsets.fromLTRB(Config.padding,
                          //     Config.padding / 1.5, Config.padding, Config.padding,),
                          //   child: Text("Наши партнеры",
                          //     style: TextStyle(color: Config
                          //         .textTitleColor,
                          //         fontSize: 20,
                          //         fontWeight: FontWeight.w500),
                          //   ),
                          // ),

                          // SingleChildScrollView(
                          //   scrollDirection: Axis.horizontal,
                          //   padding: EdgeInsets.symmetric(horizontal: Config.padding),
                          //   child: Row(
                          //     children: [
                          //       ButtonCardWidget(
                          //         150,
                          //         Config.activityBorderRadius,
                          //         Stack(
                          //           children: <Widget>[
                          //             Container(
                          //               child: Image.asset(
                          //                 'assets/img/tatneft.jpg',
                          //                 width: 140 + Config.padding / 2,
                          //                 height: 140 + Config.padding / 2,
                          //                 fit: BoxFit.cover,
                          //               ),
                          //             ),
                          //
                          //             Positioned(
                          //               top: 3,
                          //               left: 5,
                          //               child: Text(
                          //                 '%',
                          //                 style: TextStyle(fontSize: Config.textLargeSize,
                          //                     color: Config.primaryDarkColor),
                          //               ),
                          //             )
                          //           ],
                          //         ),
                          //         bgColor: Config.activityBackColor,
                          //         onTap: () {},
                          //       ),
                          //
                          //       SizedBox(width: 20,),
                          //
                          //       ButtonCardWidget(
                          //         150,
                          //         Config.activityBorderRadius,
                          //         Container(
                          //           child: Image.asset(
                          //             'assets/img/f1_logo.png',
                          //             width: 140 + Config.padding / 2,
                          //             height: 140 + Config.padding / 2,
                          //             fit: BoxFit.contain,
                          //           ),
                          //         ),
                          //         bgColor: Config.primaryDarkColor,
                          //         onTap: () {},
                          //       ),
                          //
                          //       SizedBox(width: 20,),
                          //
                          //       ButtonCardWidget(
                          //         150,
                          //         Config.activityBorderRadius,
                          //         Container(
                          //           child: Image.asset(
                          //             'assets/img/ttmf.ico',
                          //             width: 140 + Config.padding / 2,
                          //             height: 140 + Config.padding / 2,
                          //             fit: BoxFit.cover,
                          //           ),
                          //         ),
                          //         bgColor: Config.activityBackColor,
                          //         onTap: () {},
                          //       ),
                          //     ],
                          //   ),
                          // ),

                          // GridView.count(
                          //   shrinkWrap: true,
                          //   primary: false,
                          //   padding: EdgeInsets.fromLTRB(
                          //       Config.padding, 0, Config.padding,
                          //       Config.padding / 2),
                          //   crossAxisSpacing: Config.padding / 1.5,
                          //   mainAxisSpacing: Config.padding / 1.5,
                          //   crossAxisCount: 3,
                          //   childAspectRatio: width/410,
                          //   children: <Widget>[
                          //     ButtonCard(
                          //         "Регистрация\nТС",
                          //         Image.asset(
                          //             "assets/img/Driver License.png"),
                          //         Config.infoColor,
                          //             () {
                          //           Navigator.push(
                          //             context,
                          //             MaterialPageRoute(builder: (context) => RegistrationPage())
                          //           );
                          //             }
                          //     ),
                          //     ButtonCard(
                          //         "Получить\nправа",
                          //         Image.asset(
                          //             "assets/img/Driver License.png"),
                          //         Config.infoColor,
                          //             () {
                          //               Navigator.push(
                          //                   context,
                          //                   MaterialPageRoute(builder: (context) => GetLicense())
                          //               );
                          //             }
                          //     ),
                          //     ButtonCard(
                          //         "Проверка\nПДД",
                          //         Image.asset(
                          //             "assets/img/Driver License.png"),
                          //         Config.infoColor,
                          //             () {
                          //               Navigator.push(
                          //                   context,
                          //                   MaterialPageRoute(builder: (context) => CheckRules())
                          //               );
                          //             }
                          //     ),
                          //     ButtonCard(
                          //         "Шиномонтаж",
                          //         Image.asset(
                          //             "assets/img/Driver License.png"),
                          //         Config.infoColor,
                          //             () {
                          //               Navigator.push(
                          //                   context,
                          //                   MaterialPageRoute(builder: (context) => TyresRepair())
                          //               );
                          //             }
                          //     ),
                          //     ButtonCard(
                          //         "СТО",
                          //         Image.asset(
                          //             "assets/img/Driver License.png"),
                          //         Config.infoColor,
                          //             () {
                          //               Navigator.push(
                          //                   context,
                          //                   MaterialPageRoute(builder: (context) => Sto())
                          //               );
                          //             }
                          //     ),
                          //   ],
                          // ),
                        ],
                      )
                  ),
                ],
              )
          )
        ],
      ),
    );
  }
}

class Tab{
  String name;
  Widget icon;
  StatefulWidget content;
  Tab(this.name, this.icon, this.content);
}

