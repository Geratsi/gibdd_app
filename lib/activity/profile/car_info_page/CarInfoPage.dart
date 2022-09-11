import 'package:car_online/activity/profile/car_settings/CarSettingsPage.dart';
import 'package:car_online/activity/services/evacuation/models/Car.dart';
import 'package:car_online/activity/stubs/CarsListHolder.dart';
import 'package:car_online/widget/ButtonCardWidget.dart';
import 'package:flutter/material.dart';

import '../../../config.dart';
import 'models/CarInfo.dart';

class CarInfoPage extends StatefulWidget {

  CarInfoPage(this.car);

  late Car car;

  @override
  State createState() {
    return _CarInfoPage(car);
  }
}

class _CarInfoPage extends State<CarInfoPage> {

  _CarInfoPage(this.car);

  late Car car;

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
        backgroundColor: Config.activityBackColor,
        body: SingleChildScrollView(
          child: Column(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ButtonCardWidget(
                            80 + Config.padding / 2,
                            Config.activityBorderRadius * 1.2,
                            Stack(
                              children: [
                                Container(
                                  child: Image.asset(
                                    car.imgPath,
                                    width: 80 + Config.padding / 2,
                                    height: 80 + Config.padding / 2,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                            borderSize: 2,
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                  car.carName,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white,
                                      fontWeight: FontWeight.w600)
                              ),

                              SizedBox(height: 10,),

                              Text(
                                  car.carNumber,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white,
                                      fontWeight: FontWeight.w600)
                              ),
                            ],
                          ),

                          ButtonCardWidget(
                            40,
                            Config.activityBorderRadius,
                            Stack(
                              children: [
                                Positioned(
                                    bottom: 8,
                                    left: 8,
                                    right: 8,
                                    top: 8,
                                    child: Image.asset(
                                        "assets/img/settings_icon.png")
                                )
                              ],
                            ),
                            onTap: () {
                              navigateToCarSettings(car);
                            },
                          ),
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
                      Config.padding, 50
                  ),

                  child: Column(
                    children: <Widget>[

                      Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: getDataTitles(),
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: getData(CarsListHolder.getCarInfo(car)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

  void navigateToCarSettings(Car car) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => CarSettingsPage(car))
    ).
    then((value) => Navigator.of(context).pop());
  }

  List<Widget> getDataTitles() {
    return <Widget> [
      Text(
        'Данные автомобиля',
        style: TextStyle(fontSize: 20,
            fontWeight: FontWeight.w600),
      ),

      SizedBox(height: 20,),

      Text('Госномер',
        style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
      ),

      SizedBox(height: 15,),

      Text('VIN',
        style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
      ),
      SizedBox(height: 15,),

      Text('СТС',
        style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
      ),

      SizedBox(height: 20,),

      Text(
        'ОСАГО',
        style: TextStyle(fontSize: 20,
            fontWeight: FontWeight.w600),
      ),

      SizedBox(height: 20,),

      Text(
        'Номер',
        style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
      ),

      SizedBox(height: 15),

      Text(
        'Дата выдачи',
        style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
      ),

      SizedBox(height: 20,),

      Text(
        'КАСКО',
        style: TextStyle(fontSize: 20,
            fontWeight: FontWeight.w600),
      ),

      SizedBox(height: 20,),

      Text(
        'Номер',
        style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
      ),

      SizedBox(height: 15,),

      Text(
        'Дата выдачи',
        style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
      ),
    ];
  }

  List<Widget> getData(CarInfo carInfo) {
        return <Widget>[
          SizedBox(height: 40),

          Text(carInfo.car.carNumber, style: TextStyle(fontSize: 16)),

          SizedBox(height: 15,),

          Text(carInfo.car.vin, style: TextStyle(fontSize: 16)),

          SizedBox(height: 20,),

          Text(carInfo.car.ctc, style: TextStyle(fontSize: 16)),

          SizedBox(height: 60),

          Text(carInfo.osago.number, style: TextStyle(fontSize: 16)),

          SizedBox(height: 20,),

          Text(carInfo.osago.date, style: TextStyle(fontSize: 16)),

          SizedBox(height: 60,),

          Text(carInfo.casco.number, style: TextStyle(fontSize: 16)),

          SizedBox(height: 15,),

          Text(carInfo.casco.date, style: TextStyle(fontSize: 16)),
        ];
      }
}