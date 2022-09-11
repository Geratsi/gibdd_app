import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_weather_bg/bg/weather_bg.dart';
import 'package:flutter_weather_bg/utils/weather_type.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../Api.dart';
import '../Config.dart';
import '../entity/Weather.dart';


class WeatherActivity extends StatefulWidget {

  @override
  state createState() => state();
}

class state extends State<WeatherActivity> {

  Weather? weather;
  List<Shadow> headerTextShadows = [
    Shadow(blurRadius: 4.0, color: Colors.black)
  ];


  @override
  initState() {
    super.initState();
    Api.getWeatherInfo().then((value){
      if (value!=null){
        setState(() {
          weather = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double headerHeight = 200;
    return Scaffold(
      body:
        weather==null ?
          SafeArea(
            child: Stack(
              children: [

              ],
            ),
          )
        :
          Stack(
          children: [
            Stack(
              children: [
                WeatherBg(
                  weatherType: weather!.weatherType,
                  width: mediaQueryData.size.width,
                  height: mediaQueryData.size.height,
                ),
                Container(
                  width: mediaQueryData.size.width,
                  height: mediaQueryData.size.height,
                  color: weather!.isDay ? Colors.black.withOpacity(0.1) : Colors.transparent,
                )
              ],
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: mediaQueryData.size.width,
                      height: headerHeight,
                      child: Stack(
                        children: [
                          Positioned(
                            child: AppBar(
                              shadowColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
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
                            )
                          ),
                          Center(
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Казань", style: TextStyle(color: Colors.white, fontSize: Config.padding*1.2, shadows: headerTextShadows)),
                                GestureDetector(
                                  child: Text("${weather!.temp}°", style: TextStyle(color: Colors.white, fontSize: Config.padding*4, fontWeight: FontWeight.w300, shadows: headerTextShadows)),
                                  onTap: (){
                                    WeatherType last = WeatherType.sunny;
                                    for (var value in WeatherType.values) {
                                      last = value;
                                    }
                                    if (weather!.weatherType==last){
                                      setState(() {
                                        weather!.weatherType = WeatherType.heavyRainy;
                                      });
                                    } else {
                                      bool found = false;
                                      for (var value in WeatherType.values) {
                                        if (weather!.weatherType==value){
                                          found = true;
                                        } else {
                                          if (found){
                                            setState(() {
                                              weather!.weatherType = value;
                                            });
                                            break;
                                          }
                                        }
                                      }
                                    }
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.network(
                                        weather!.iconUrl,
                                        width: Config.padding*1.4,
                                        placeholderBuilder: (BuildContext context) =>
                                            Container(
                                                width: Config.padding*1.4,
                                                height: Config.padding*1.4,
                                                padding: EdgeInsets.all(Config.padding*0.7),
                                                child: Center(
                                                    child: CircularProgressIndicator(color: Colors.white)
                                                )
                                            )
                                    ),
                                    SizedBox(width: Config.padding/2),
                                    Text("${weather!.conditionStr}", style: TextStyle(color: Colors.white, fontSize: Config.padding*1.2, shadows: headerTextShadows)),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(Config.padding, 0, Config.padding, Config.padding),
                      child: Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(Config.activityBorderRadius),
                              ),
                              width: mediaQueryData.size.width,
                              padding: EdgeInsets.all(Config.padding),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(MdiIcons.numeric, size: Config.padding*3, color:Colors.white),
                                  SizedBox(width: Config.padding),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Регистрационные номера", style: TextStyle(color: Colors.white, fontSize: 16)),
                                      SizedBox(height: Config.padding/2),
                                      SizedBox(
                                          width: mediaQueryData.size.width-(Config.padding*8),
                                          child: Text("Перед поездкой рекомендуется проверять читаемость регистрационных номеров автомобиля, и при необходимость их очищать", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500))
                                      )
                                    ],
                                  )
                                ],
                              )
                          ),
                          SizedBox(height: Config.padding/2),
                          Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(Config.activityBorderRadius),
                              ),
                              width: mediaQueryData.size.width,
                              padding: EdgeInsets.all(Config.padding),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(MdiIcons.carWash, size: Config.padding*3, color:Colors.white),
                                  SizedBox(width: Config.padding),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Мойка автомобиля", style: TextStyle(color: Colors.white, fontSize: 16)),
                                      SizedBox(height: Config.padding/2),
                                      SizedBox(
                                        width: mediaQueryData.size.width-(Config.padding*8),
                                        child: Text("Рекомендуется выполнять мойку автомобиля в крытых помещениях, протирать уплотнители дверей и автомобиль до полной сухости", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500))
                                      )
                                    ],
                                  )
                                ],
                              )
                          ),
                          SizedBox(height: Config.padding/2),
                          for (var k in weather!.info.keys)
                            Column(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(Config.activityBorderRadius),
                                    ),
                                    width: mediaQueryData.size.width,
                                    padding: EdgeInsets.all(Config.padding),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("${k}", style: TextStyle(color: Colors.white, fontSize: 16)),
                                        Text("${weather!.info[k]}", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500))
                                      ],
                                    )
                                ),
                                SizedBox(height: Config.padding/2),
                              ],
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            )
          ],
        )
    );
  }
}

