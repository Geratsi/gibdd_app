import 'package:car_online/activity/services/check/models/CarCheckDetailedResult.dart';
import 'package:car_online/activity/services/check/models/CarCheckResult.dart';
import 'package:car_online/activity/stubs/CheckDataHolder.dart';
import 'package:car_online/res/Strings.dart';
import 'package:flutter/material.dart';

import '../../../Config.dart';

class CarDetailedInfo extends StatefulWidget {

  CarDetailedInfo(this.carCheckResult);

  final CarCheckResult carCheckResult;

  @override
  State<StatefulWidget> createState() => _CarDetailedInfo(carCheckResult);
}

class _CarDetailedInfo extends State<CarDetailedInfo> {

  _CarDetailedInfo(this.carCheckResult);

  final CarCheckResult carCheckResult;
  late CarCheckDetailedResult carCheckDetailedResult;


  @override
  void initState() {
    carCheckDetailedResult =
        CheckDataHolder.getCarCheckDetailedResult(carCheckResult);
    super.initState();
  }

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
                      ],
                    )
                ),

                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    Config.padding, Config.padding / 2,
                    Config.padding, Config.padding * 2.5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          carCheckResult.carName,
                          style: TextStyle(
                              fontSize: 20, color: Colors.white,
                              fontWeight: FontWeight.w600)
                      ),

                      SizedBox(height: 10,),

                      Text(
                          carCheckResult.vin,
                          style: TextStyle(
                            fontSize: 16, color: Colors.white,)
                      ),
                    ],
                  ),
                  // Container(
                  //   width: 80 + Config.padding / 2,
                  //   height: 80 + Config.padding / 2,
                  //   decoration: BoxDecoration(
                  //     color: Config.activityHintColor,
                  //     borderRadius: BorderRadius.circular(
                  //         Config.activityBorderRadius * 1.2),
                  //   ),
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         carCheckResult.carRating.toString(),
                  //         style: TextStyle(
                  //             color: carCheckResult.carRating > 75
                  //                 ? Colors.green
                  //                 : carCheckResult.carRating > 50
                  //                 ? Colors
                  //                 .amberAccent
                  //                 : Colors.red,
                  //             fontSize: 20,
                  //             fontWeight: FontWeight.bold),
                  //       ),
                  //       SizedBox(height: 5,),
                  //       Text(
                  //         Strings.car_check_card_rating_title,
                  //         style: TextStyle(
                  //             fontSize: 14, color: Config.primaryColor),
                  //         textAlign: TextAlign.center,
                  //       ),
                  //     ],
                  //   ),
                  // ),
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
                        Config.padding, 50
                    ),

                    child: SingleChildScrollView(
                      child: baseData(carCheckResult),
                    )
                ),
              ),
            ],
          ),
        )
    );
  }

  Widget baseData(CarCheckResult carCheckResult) {
    return Column(
        children: [
          Row(
            children: [
              Text(
                Strings.car_detailed_base_data_title,
                style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(height: 20,),
          _getTextRow(Strings.car_detailed_car_issue_date_title,
              carCheckDetailedResult.carCheckResult.carDate),
          SizedBox(height: 10,),
          _getTextRow(
              Strings.car_detailed_pts_title, carCheckDetailedResult.ptsType),
          SizedBox(height: 10,),
          _getTextRow(
              Strings.car_detailed_pts_issue_date_title,
              carCheckDetailedResult.ptsDate),
          SizedBox(height: 10,),
          _getTextRow(
              Strings.car_detailed_engine_capacity_title,
              carCheckDetailedResult.carCheckResult.engineCapacity),
          SizedBox(height: 10,),
          _getTextRow(Strings.car_detailed_engine_power,
              carCheckDetailedResult.carCheckResult.enginePower),
          SizedBox(height: 10,),
          _getTextRow(Strings.car_detailed_car_color_title,
              carCheckDetailedResult.carCheckResult.carColor),
          SizedBox(height: 10,),
          _getTextRow(
              Strings.car_detailed_is_car_disposed_title,
              carCheckDetailedResult.isCarDisposed ? "Да" : "Нет"),
          SizedBox(height: 20,),
          _getEventRow(
              carCheckDetailedResult.restrictions == null,
              Strings.car_detailed_restrictions_title,
              carCheckDetailedResult.restrictions == null ? Strings
                  .car_detailed_restrictions_passed : carCheckDetailedResult
                  .restrictions!),
          SizedBox(height: 20,),
          _getEventRow(
              carCheckDetailedResult.wanted == null,
              Strings.car_detailed_wanted_title,
              carCheckDetailedResult.wanted == null ? Strings
                  .car_detailed_wanted_passed : carCheckDetailedResult.wanted!),
          SizedBox(height: 20,),
          _getEventRow(
              carCheckDetailedResult.mortgaged == null,
              Strings.car_detailed_mortgaged_title,
              carCheckDetailedResult.mortgaged == null ? Strings
                  .car_detailed_mortgaged_passed : carCheckDetailedResult
                  .mortgaged!),
        ]
    );
  }

  Widget _getTextRow(String title, String data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
            title,
            style: TextStyle(color: Colors.grey.shade600,
                fontSize: 16)
        ),
        Text(
            data,
            style: TextStyle(fontSize: 16)
        )
      ],
    );
  }

  Widget _getEventRow(bool isCheckPassed, String title, String message) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(height: 20,),
        Row(
          children: [
            Image.asset(
                (isCheckPassed
                    ? "assets/img/ic_success.png"
                    : "assets/img/ic_failure.png"),
                width: 20,
                height: 20
            ),
            SizedBox(width: 15,),
            Text(
                message,
                style: TextStyle(fontSize: 16)
            )
          ],
        )
      ],
    );
  }
}