import 'package:car_online/Config.dart';
import 'package:car_online/activity/services/accident/models/AccidentDetails.dart';
import 'package:flutter/material.dart';

class AccidentCard extends StatelessWidget {
  AccidentCard(this.accidentDetails, this.onClickCallback, this.onLongClickCallback);

  final AccidentDetails accidentDetails;
  final Function onClickCallback;
  final Function onLongClickCallback;

  final Map<String, Color> statusColors = {
    'В работе': Config.primaryDarkColor,
    'Принята': Config.textTitleColor,
    'Закрыта': Config.successColor,
  };

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Config.baseInfoColor,
      borderRadius: BorderRadius.circular(Config.activityBorderRadius),
        child: InkWell(
          onTap: () {
            onClickCallback();
          },
          onLongPress: () {
            onLongClickCallback();
          },
          splashColor: Config.primaryLightColor,
          child: Padding(
            padding: EdgeInsets.all(Config.padding / 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "Номер заявки",
                              style: TextStyle(color: Config.textColor,
                                fontSize: Config.textMediumSize, )
                          ),
                          Text(
                              accidentDetails.number.toString(),
                              style: TextStyle(fontSize: Config.textMediumSize,
                                color: Config.textTitleColor,)
                          )
                        ],
                      ),

                      SizedBox(height: Config.padding / 2,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Статус",
                            style: TextStyle(color: Config.textColor,
                                fontSize: Config.textMediumSize),
                          ),
                          Text(
                            accidentDetails.status,
                            style: TextStyle(color: statusColors[accidentDetails.status],
                              fontSize: Config.textMediumSize,),
                          )
                        ],
                      ),

                      SizedBox(height: Config.padding / 2,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "Центр оформления\nДТП",
                              style: TextStyle(color: Config.textColor,
                                  fontSize: Config.textMediumSize)
                          ),
                          Text(
                              accidentDetails.address,
                              style: TextStyle(fontSize: Config.textMediumSize,
                                  color: Config.textTitleColor)
                          )
                        ],
                      ),

                      SizedBox(height: Config.padding / 2,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                              "Qr код заявки",
                              style: TextStyle(color: Config.textColor,
                                  fontSize: Config.textMediumSize)
                          ),

                          InkWell(
                            borderRadius: BorderRadius.circular(Config.activityBorderRadius),
                            splashColor: Config.primaryLightColor,
                            child: Padding(
                              padding: EdgeInsets.all(Config.padding / 4),
                              child:  Icon(Icons.qr_code_2, size: 50,
                                color: Config.textTitleColor,),
                            ),
                            onTap: () {
                              _showModal(context);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }

  void _showModal(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              color: Config.activityBackColor,
              constraints: BoxConstraints(maxHeight: 280),
              child: Image.asset(
                'assets/img/qrCode.png',
                fit: BoxFit.cover,
              ),
            ),
          );
        }
    );
  }
}