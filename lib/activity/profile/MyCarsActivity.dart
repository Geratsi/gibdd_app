import 'package:car_online/widget/ButtonCardWidget.dart';
import 'package:car_online/widget/Box.dart';
import 'package:car_online/activity/services/evacuation/models/Car.dart';
import 'package:car_online/activity/stubs/CarsListHolder.dart';
import 'package:car_online/config.dart';
import 'package:car_online/widget/ButtonCard.dart';
import 'package:flutter/material.dart';

import 'add_car_page/AddCarPage.dart';
import 'car_info_page/CarInfoPage.dart';

class MyCarsActivity extends StatefulWidget {
  const MyCarsActivity({Key? key}) : super(key: key);

  @override
  _MyCarsActivityState createState() => _MyCarsActivityState();
}

class _MyCarsActivityState extends State<MyCarsActivity> {

  List<Car> carList = CarsListHolder.carsList;

  void _showQRCode(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                color: Config.activityBackColor,
                height: 300,
                child: Image.asset(
                  'assets/img/qrCode.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        );
      }
    );
  }

  List<Widget> getCarButtonsList(List<Car> cars) {
    return List.generate(
        cars.length,
            (index) => getCarButtonView(cars[index])
    );
  }

  Widget getCarButtonView(Car car) {
    return Column(
      children: [
        ButtonCardWidget(
          150,
          Config.activityBorderRadius,
          Container(
            child: Image.asset(
              car.imgPath,
              width: 160 + Config.padding / 2,
              height: 160 + Config.padding / 2,
              fit: BoxFit.cover,
            ),
          ),
          bgColor: Config.activityBackColor,
          onTap: () {
            navigateToCarInfo(car);
          },
        ),

        Padding(
          padding: EdgeInsets.all(Config.padding / 2),
          child: Column(
            children: <Widget>[
              Text('CTC', style: TextStyle(fontSize: 18, color: Config.textColor),),

              SizedBox(height: 5,),

              Text(car.ctc, style: TextStyle(fontSize: 18, color: Config.textColor)),
            ],
          ),
        ),

        Material(
          color: Config.activityBackColor,
          child: InkWell(
            borderRadius: BorderRadius.circular(Config.activityBorderRadius),
            splashColor: Config.primaryLightColor,
            child: Padding(
              padding: EdgeInsets.all(Config.padding / 4),
              child:  Icon(Icons.qr_code_2, size: 50,),
            ),
            onTap: () {
              _showQRCode(context);
            },
          ),
        ),
        // ButtonCard('', Icon(Icons.qr_code_2, size: 40,), Config.activityBackColor, () {}),
      ],
    );
  }

  void navigateToAddCarPage() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddCarPage())
    ).then((value) => setState(() {}));
  }

  void navigateToCarInfo(Car car) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CarInfoPage(car)),
    ).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.activityBackColor,

      appBar: AppBar(
        title: Text('Мои автомобили',),
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
                ),
              ),

              child: Padding(
                padding: EdgeInsets.only(
                    top: Config.padding * 1.5
                ),

                child: SizedBox(width: MediaQuery.of(context).size.width,),
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
              transform: Matrix4.translationValues(
                  0.0, -(Config.activityBorderRadius * 4)+Config.padding, 0.0
              ),

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

              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  Config.padding, 0,
                  Config.padding, Config.padding,
                ),
                child: Column(
                  children: <Widget>[
                    GridView.count(
                      shrinkWrap: true,
                      primary: false,
                      padding: EdgeInsets.fromLTRB(
                          0, 0, 0,
                          Config.padding / 2
                      ),
                      crossAxisSpacing: Config.padding,
                      mainAxisSpacing: Config.padding,
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,
                      children: getCarButtonsList(carList)
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder( // BeveledRectangleBorder for rectangle border, not circle
            borderRadius: BorderRadius.circular(Config.activityBorderRadius)
        ),
        backgroundColor: Config.primaryColor,
        onPressed: () {
          navigateToAddCarPage();
        },
        icon: Icon(Icons.add),
        label: Text(
          'Добавить автомобиль',
          style: TextStyle(fontSize: Config.textLargeSize),
        ),
      ),
    );
  }
}

