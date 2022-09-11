import 'package:car_online/activity/stubs/CarsListHolder.dart';
import 'package:car_online/widget/ButtonCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../Config.dart';
import 'models/CarModel.dart';
import 'models/FineModel.dart';

class FinesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FinesPage();
  }
}

class _FinesPage extends State<FinesPage> {

  int totalCost = 0;
  List<CarModel> carsList = List.generate(CarsListHolder.carsList.length,
          (index) => CarModel(CarsListHolder.carsList[index]));
  List<FineModel> finesList = List.empty();


  @override
  void initState() {
    super.initState();
    carsList.first.isChecked = true;
    finesList = getFines(carsList.first);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: Text('Штрафы'),
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
      backgroundColor: Config.activityBackColor,

      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                  'Просмотр и оплата штрафов \n'
                                      'без комиссии',
                                  style: TextStyle(
                                    fontSize: 16, color: Colors.white,)
                              ),

                              SizedBox(height: 20,)

                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 70,),
                    ],
                  ),
                ),
              ),

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
                      Config.padding, Config.padding * 6,
                      Config.padding, 0
                  ),

                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              SizedBox(height: 20,),

                              Text(
                                '${finesList.length} Штрафа',
                                style: TextStyle(fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),

                              SizedBox(height: 5,),

                              Text("Обновлено ${DateFormat("dd-MM-yyyy").format(DateTime.now()).replaceAll("-", ".")}",
                                style: TextStyle(
                                    color: Colors.grey.shade600, fontSize: 12),
                              ),
                              SizedBox(height: 10,),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 250,
                        child: ListView(
                            scrollDirection: Axis.vertical,
                            children: getFinesItems()
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "К оплате:",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Config.textTitleColor),
                          ),
                          Text(
                            "${totalCost.toString()} Р",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                          ),
                          )
                        ],
                      ),
                      SizedBox(height: 15,),
                      Material(
                        color: Config.primaryColor,
                        borderRadius: BorderRadius.circular(Config.activityBorderRadius),
                        child: InkWell(
                          splashColor: Config.primaryLightColor,
                          borderRadius: BorderRadius.circular(Config.activityBorderRadius),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: Config.padding),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Оплатить',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Positioned(
            left: 0,
            top: 40,
            right: 0,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.fromLTRB(
                Config.padding, Config.padding,
                Config.padding, Config.padding,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: getCarsItems(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getFinesItems() {
    return List.generate(
        finesList.length,
            (index) => getFineListViewItem(finesList[index])
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
                )
            )
    );
  }

  GestureDetector getCarListViewItem(CarModel carModel) {
    return GestureDetector(
      child: Column(
        children: <Widget>[
          Opacity(
            opacity: carModel.isChecked ? 1 : 0.6,
            child: ButtonCardWidget(
              80 + Config.padding / 2,
              Config.activityBorderRadius * 1.5,
              Stack(
                children: [
                  Container(
                    child: Image.asset(
                      carModel.car.imgPath,
                      width: 80 + Config.padding / 2,
                      height: 80 + Config.padding / 2,
                      fit: BoxFit.cover,),
                  ),
                ],
              ),
              borderSize: 2,
              onTap: () {
                setState(() {
                  totalCost = 0;
                  carsList.forEach((carModel) {
                    carModel.isChecked = false;
                  });
                  carModel.isChecked = true;
                  finesList = getFines(carModel);
                });
              },
            ),
          ),

          Text(carModel.car.carName,
              style: TextStyle(fontSize: 14, color: Config.textTitleColor)),
          Text(carModel.car.carNumber,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600,)),
        ],
      ),
    );
  }

  Widget getFineListViewItem(FineModel fineModel) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 5,),
          Checkbox(onChanged: (isChecked) {
            setState(() {
              fineModel.isChecked = isChecked!;
              if (isChecked) {
                totalCost += fineModel.cost;
              }
              else {
                totalCost -= fineModel.cost;
              }
            });
          }, value: fineModel.isChecked,
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(fineModel.reason,
                  style: TextStyle(fontSize: 14, color:Config.textTitleColor)),
              SizedBox(height: 5,),
              Text(fineModel.payTime, style: TextStyle(fontSize: 12,
                  color: fineModel.isExpired ? Colors.red : Colors.green)),
              SizedBox(height: 5,),
              Text(fineModel.other, style: TextStyle(fontSize: 10, color:Config.textColor)),
              SizedBox(height: 5,),
            ],
          ),
          Text("${fineModel.cost} Р", style: TextStyle(fontSize: 20,
              fontWeight: FontWeight.bold,
              color: fineModel.isExpired ? Colors.red : Colors.green))
        ],
      ),
    );
  }

  List<FineModel> getFines(CarModel carModel) {
    if (carModel.car.carName.contains("Tiguan")) {
      return [
        FineModel(
            "Штраф по административному \nправонарушению...",
            "Осталось дней для оплаты со \nскидкой: 7 дней",
            "13.11.2021 Республика Татарстан, г. \n"
                "Казань, ул Проспект Победы, д.141",
            500,
            false
        ),
        FineModel(
            "Штраф по административному \nправонарушению...",
            "Оплата просрочена: 5 дней",
            "13.11.2021 Республика Татарстан, г. \n"
                "Казань, ул Проспект Победы, д.141",
            500,
            true
        ),
        FineModel(
            "Штраф по административному \nправонарушению...",
            "Оплата просрочена: 5 дней",
            "13.11.2021 Республика Татарстан, г. \n"
                "Казань, ул Проспект Победы, д.141",
            500,
            true
        ), FineModel(
            "Штраф по административному \nправонарушению...",
            "Оплата просрочена: 5 дней",
            "13.11.2021 Республика Татарстан, г. \n"
                "Казань, ул Проспект Победы, д.141",
            500,
            true
        )
      ];
    }
    else {
      return [
        FineModel(
            "Штраф по административному \nправонарушению...",
            "Осталось дней для оплаты со \nскидкой: 7 дней",
            "13.11.2021 Республика Татарстан, г. \n"
                "Казань, ул Проспект Победы, д.141",
            250,
            false
        ),
        FineModel(
            "Штраф по административному \nправонарушению...",
            "Оплата просрочена: 5 дней",
            "13.11.2021 Республика Татарстан, г. \n"
                "Казань, ул Проспект Победы, д.141",
            500,
            true
        )
      ];
    }
  }
}
