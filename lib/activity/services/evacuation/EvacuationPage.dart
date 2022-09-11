import 'package:car_online/activity/stubs/CarsListHolder.dart';
import 'package:car_online/widget/ButtonCardWidget.dart';
import 'package:car_online/widget/MainButton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Config.dart';
import 'models/Car.dart';
import 'models/CarEvent.dart';

class EvacuationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EvacuationPage();
  }
}

class _EvacuationPage extends State<EvacuationPage> {
  bool _isVisible = false;
  List<Car> carsList = CarsListHolder.carsList;

  late List<CarEvent> eventsList;

  @override
  void initState() {
    eventsList = List.generate(CarsListHolder.carsList.length,
            (index) => CarsListHolder.getCarEvent(CarsListHolder.carsList[index]));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.activityBackColor,

      appBar: AppBar(
        title: Text('Проверка эвакуации'),
        centerTitle: true,
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
      ),

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
                padding: EdgeInsets.only(
                    top: Config.padding * 1.5
                ),

                child: SizedBox(width: MediaQuery.of(context).size.width,),
              ),
            ),

            Container(
              transform: Matrix4.translationValues(
                  0.0, -(Config.activityBorderRadius * 2), 0.0
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
                    Config.padding, Config.padding,
                    Config.padding, Config.padding / 2,
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Мои автомобили',
                      style: TextStyle(fontSize: Config.textLargeSize,
                          color: Config.textTitleColor),
                    ),

                    SizedBox(height: Config.padding / 2,),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: getCarsItems(),
                      ),
                    ),

                    SizedBox(height: Config.padding,),

                    MainButton(
                      label: 'Проверить',
                      onPressed: () {
                        setState(() {
                          _isVisible = !_isVisible;
                        });
                      },
                      bgColor: Config.primaryColor,
                      labelColor: Config.textColorOnPrimary,
                    ),

                    Visibility(
                      visible: _isVisible,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Config.activityBorderRadius),
                          color: Config.baseInfoColor,
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: Config.padding / 2,
                          horizontal: Config.padding / 3,
                        ),
                        margin: EdgeInsets.only(top: Config.padding),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Результат проверки',
                              style: TextStyle(fontSize: Config.textLargeSize,
                                  color: Config.textTitleColor),
                            ),

                            SizedBox(height: Config.padding / 2,),

                            Text("Обновлено ${DateFormat("dd-MM-yyyy")
                                .format(DateTime.now()).replaceAll("-", ".")}",
                              style: TextStyle(color: Config.textColor,
                                  fontSize: Config.textSmallSize),
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(vertical: Config.padding / 2),
                              child: Divider(height: 1,),
                            ),

                            ...eventsList.map((item) => getEventsListViewItem(item)),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: Config.padding,),

                    MainButton(
                      label: 'Вызов эвакуатора',
                      onPressed: () async {
                        if (await canLaunch('tel:88432401919')) {
                          await launch('tel:88432401919');
                        } else {
                          throw 'Could not launch';
                        }
                      },
                      bgColor: Config.baseInfoColor,
                      labelColor: Config.primaryDarkColor,
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

  List<Widget> getCarsItems() {
    return List.generate(
      carsList.length,
        (index) =>
        Container(
          child: Row(
            children: [
              getCarListViewItem(carsList[index]),

              SizedBox(width: Config.padding),
            ],
          ),
        ),
    );
  }

  Widget getCarListViewItem(Car car) {
    return GestureDetector(
      child: Column(
        children: <Widget>[
          ButtonCardWidget(
            90 + Config.padding / 2,
            Config.activityBorderRadius * 1.5,
            Stack(
              children: [
                Container(
                  child: Image.asset(
                    car.imgPath,
                    width: 90 + Config.padding / 2,
                    height: 90 + Config.padding / 2,
                    fit: BoxFit.cover,),
                ),
              ],
            ),
            borderSize: 2,
            onTap: () {},
          ),

          SizedBox(height: Config.padding / 4,),

          Text(
            car.carName,
            style: TextStyle(fontSize: Config.textMediumSize,
                color: Config.textTitleColor),
          ),

          Text(
            car.carNumber,
            style: TextStyle(fontSize: Config.textMediumSize,
              color: Config.textColor,),),
        ],
      ),
    );
  }

  Widget getEventsListViewItem(CarEvent carEvent) {
    return Container(
      child: Column(
        children: [
          Text(
            carEvent.car.carName,
            style: TextStyle(fontSize: Config.textMediumSize,
                color: Config.textTitleColor),
          ),

          SizedBox(height: Config.padding / 3,),

          Text(
            carEvent.car.carNumber,
            style: TextStyle(fontSize: Config.textMediumSize,
              color: Config.textColor,),
          ),

          SizedBox(height: Config.padding,),

          Padding(
            padding: EdgeInsets.only(right: Config.padding / 4),
            child: Image.asset(
                ((carEvent.eventDescription == null) ? "assets/img/ic_success.png" : "assets/img/ic_failure.png"),
                width: 20,
                height: 20
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  ((carEvent.eventDescription == null) ? "Событие не зарегистрировано" : carEvent.eventDescription!),
                  style: TextStyle(
                      fontSize: Config.textMediumSize,
                      color: ((carEvent.eventDescription == null) ? Colors.green : Colors.red),
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: Config.padding),
            child: Divider(height: 1,),
          ),
        ],
      ),
    );
  }
}