import 'package:car_online/Config.dart';
import 'package:car_online/activity/services/check/models/OsagoCheckResult.dart';
import 'package:flutter/material.dart';

class OsagoCard extends StatelessWidget {
  const OsagoCard({
    Key? key,
    required this.osagoCheckResult,
  }) : super(key: key);

  final OsagoCheckResult osagoCheckResult;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Config.padding),
      child: Material(
        color: Config.baseInfoColor,
        borderRadius: BorderRadius.circular(Config.activityBorderRadius),
        child: Padding(
          padding: EdgeInsets.all(Config.padding / 2),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Серия и номер полиса',
                    style: TextStyle(color: Config.textColor,
                        fontSize: Config.textMediumSize),
                  ),

                  Flexible(
                    child: Text(
                      '${osagoCheckResult.series} ${osagoCheckResult.number}',
                      style: TextStyle(fontSize: Config.textMediumSize,
                          color: Config.textTitleColor),
                    ),
                  ),
                ],
              ),

              SizedBox(height: Config.padding / 2,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Страховая компания',
                    style: TextStyle(color: Config.textColor,
                        fontSize: Config.textMediumSize),
                  ),

                  Flexible(
                    child: Text(
                      osagoCheckResult.company,
                      style: TextStyle(fontSize: Config.textMediumSize,
                          color: Config.textTitleColor),
                    ),
                  ),
                ],
              ),

              SizedBox(height: Config.padding / 2,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Статус',
                    style: TextStyle(color: Config.textColor,
                        fontSize: Config.textMediumSize),
                  ),

                  Flexible(
                    child: Text(
                      osagoCheckResult.status ? 'Действителен' : 'Просрочен',
                      style: TextStyle(fontSize: Config.textMediumSize,
                          color: osagoCheckResult.status ? Config.successColor : Config.errorColor),
                    ),
                  ),
                ],
              ),

              SizedBox(height: Config.padding / 2,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Договор заключен',
                    style: TextStyle(color: Config.textColor,
                        fontSize: Config.textMediumSize),
                  ),

                  Flexible(
                    child: Text(
                      osagoCheckResult.madeDate,
                      style: TextStyle(fontSize: Config.textMediumSize,
                          color: Config.textTitleColor),
                    ),
                  ),
                ],
              ),

              SizedBox(height: Config.padding / 2,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Период действия',
                    style: TextStyle(color: Config.textColor,
                        fontSize: Config.textMediumSize),
                  ),

                  Flexible(
                    child: Text(
                      osagoCheckResult.expiryDate,
                      style: TextStyle(fontSize: Config.textMediumSize,
                          color: Config.textTitleColor),
                    ),
                  ),
                ],
              ),

              SizedBox(height: Config.padding / 2,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'VIN',
                    style: TextStyle(color: Config.textColor,
                        fontSize: Config.textMediumSize),
                  ),

                  Flexible(
                    child: Text(
                      osagoCheckResult.vin,
                      style: TextStyle(fontSize: Config.textMediumSize,
                          color: Config.textTitleColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

