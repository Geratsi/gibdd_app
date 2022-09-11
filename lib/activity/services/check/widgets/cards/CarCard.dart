import 'package:car_online/activity/services/check/models/CarCheckResult.dart';
import 'package:car_online/res/Strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../Config.dart';

class CarCard extends StatelessWidget {

  CarCard(this.carCheckResult, this.onClickCallback, this.onLongClickCallback);

  final CarCheckResult carCheckResult;
  final Function onClickCallback;
  final Function onLongClickCallback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Config.padding),
      child: Material(
        color: Config.baseInfoColor,
        borderRadius: BorderRadius.circular(Config.activityBorderRadius),
        child: InkWell(
          onTap: () {
            onClickCallback();
          },
          onLongPress: () {
            onLongClickCallback(carCheckResult);
          },
          splashColor: Config.primaryLightColor,
          child: Padding(
            padding: EdgeInsets.all(Config.padding / 2),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'Наименование авто',
                        style: TextStyle(color: Config.textColor,
                            fontSize: Config.textMediumSize)
                    ),
                    Text(
                        carCheckResult.carName,
                        style: TextStyle(color: Config.textTitleColor,
                            fontSize: Config.textMediumSize)
                    )
                  ],
                ),

                SizedBox(height: Config.padding / 2,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        Strings.car_check_card_vin_title,
                        style: TextStyle(color: Config.textColor,
                            fontSize: Config.textMediumSize)
                    ),
                    Text(
                        carCheckResult.vin,
                        style: TextStyle(color: Config.textTitleColor,
                            fontSize: Config.textMediumSize)
                    )
                  ],
                ),

                SizedBox(height: Config.padding / 2,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        Strings.car_check_card_color_title,
                        style: TextStyle(color: Config.textColor,
                            fontSize: Config.textMediumSize)
                    ),
                    Text(
                        carCheckResult.carColor,
                        style: TextStyle(color: Config.textTitleColor,
                            fontSize: Config.textMediumSize)
                    )
                  ],
                ),

                SizedBox(height: Config.padding / 2,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        Strings.car_check_card_engine_title,
                        style: TextStyle(color: Config.textColor,
                            fontSize: Config.textMediumSize)
                    ),
                    Text(
                        "${carCheckResult
                            .engineCapacity} / ${carCheckResult
                            .enginePower}",
                        style: TextStyle(color: Config.textTitleColor,
                            fontSize: Config.textMediumSize)
                    )
                  ],
                ),

                SizedBox(height: Config.padding / 2,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        Strings.car_check_card_date_title,
                        style: TextStyle(color: Config.textColor,
                            fontSize: Config.textMediumSize)
                    ),
                    Text(
                        carCheckResult.checkDate,
                        style: TextStyle(color: Config.textTitleColor,
                            fontSize: Config.textMediumSize)
                    )
                  ],
                ),

                // SizedBox(width: 10,),
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       carCheckResult.carRating.toString(),
                //       style: TextStyle(
                //           color: carCheckResult.carRating > 75
                //               ? Colors.green
                //               : carCheckResult.carRating > 50 ? Colors
                //               .amberAccent : Colors.red,
                //           fontSize: 20,
                //           fontWeight: FontWeight.bold),
                //     ),
                //     SizedBox(height: 5,),
                //     Text(
                //       Strings.car_check_card_rating_title,
                //       style: TextStyle(fontSize: 14),
                //       textAlign: TextAlign.center,
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}