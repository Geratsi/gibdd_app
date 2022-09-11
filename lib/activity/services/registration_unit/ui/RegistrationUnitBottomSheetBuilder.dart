import 'package:car_online/activity/services/registration_unit/model/RegistrationUnit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../Config.dart';

class RegistrationUnitBottomSheetBuilder {

  RegistrationUnit _registrationUnit;
  Function() _onCloseClick;
  Function(String) _onCallClick;

  RegistrationUnitBottomSheetBuilder(this._registrationUnit, this._onCloseClick,
      this._onCallClick);

  bool isScrollControlled = true;

  Widget getBuilder(BuildContext context) {
    return Wrap(
        children: [
          Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Wrap(
                      children: [
                        Container(
                          padding: EdgeInsets.all(Config.padding),
                          child: Text(
                            _registrationUnit.description,
                            style: TextStyle(
                                fontSize: Config.textMediumSize,
                                color: Config.textColorOnPrimary,
                                //fontWeight: FontWeight.bold
                            ),
                          ),
                          constraints: BoxConstraints(),
                          decoration: BoxDecoration(
                            color: Config.primaryColor,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(
                                    Config.activityBorderRadius * 2)),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: Config.activityBackColor,
                      padding: EdgeInsets.all(Config.padding),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _registrationUnit.primaryAddress,
                              style: TextStyle(
                                  fontSize: Config.textMediumSize,
                                  fontWeight: FontWeight.bold,
                                  color: Config.textColor
                              ),),
                            Text(
                              _registrationUnit.secondaryAddress,
                              style: TextStyle(
                                  color: Config.textColor
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _registrationUnit.number,
                                  style: TextStyle(
                                      fontSize: Config.textLargeSize,
                                      fontWeight: FontWeight.bold,
                                      color: Config.textColor
                                  ),
                                ),
                                IconButton(
                                    icon: Icon(
                                        Icons.call,
                                    color: Config.primaryColor),
                                    color: Config.textColor,
                                    onPressed: () async {
                                      _onCallClick(_registrationUnit.number);
                                    }
                                ),
                              ],
                            ),
                            SizedBox(height: 15,),
                          ]
                      ),
                    ),
                  ]
              )
          )
        ]
    );
  }

  RoundedRectangleBorder shape() {
    return RoundedRectangleBorder(borderRadius: BorderRadius.vertical(
        top: Radius.circular(Config.activityBorderRadius * 2)));
  }
}