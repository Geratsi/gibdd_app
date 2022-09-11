import 'package:car_online/Config.dart';
import 'package:car_online/activity/services/check/models/LicenseCheckResult.dart';
import 'package:car_online/res/Strings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LicenseCard extends StatelessWidget {
  LicenseCard(this.licenseCheckResult);

  final DateTime _now = DateTime.now().toLocal();
  final LicenseCheckResult licenseCheckResult;

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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      Strings.license_check_card_categories_title,
                      style: TextStyle(color: Colors.grey.shade600,
                          fontSize: Config.textMediumSize)
                  ),
                  Text(
                      licenseCheckResult.categories,
                      style: TextStyle(fontSize: Config.textMediumSize)
                  )
                ],
              ),

              SizedBox(height: Config.padding / 2,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      Strings.license_check_card_birth_date_title,
                      style: TextStyle(color: Colors.grey.shade600,
                          fontSize: Config.textMediumSize)
                  ),
                  Text(
                      licenseCheckResult.birthDate,
                      style: TextStyle(fontSize: Config.textMediumSize)
                  )
                ],
              ),

              SizedBox(height: Config.padding / 2,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      Strings.license_check_card_issue_date_title,
                      style: TextStyle(color: Colors.grey.shade600,
                          fontSize: Config.textMediumSize)
                  ),
                  Text(
                      licenseCheckResult.issueDate,
                      style: TextStyle(fontSize: Config.textMediumSize)
                  )
                ],
              ),

              SizedBox(height: Config.padding / 2,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      Strings.license_check_card_expiry_date_title,
                      style: TextStyle(color: Colors.grey.shade600,
                          fontSize: Config.textMediumSize)
                  ),
                  Text(licenseCheckResult.expiryDate != null
                      ? licenseCheckResult.expiryDate!
                      : Strings.License_check_card_deprived_message,
                      style: TextStyle(
                          fontSize: Config.textMediumSize,
                          color: licenseCheckResult.expiryDate != null
                              ? Config.textTitleColor
                              : Colors.red
                      )
                  )
                ],
              ),

              licenseCheckResult.expiryDate == null
                ? Column(
                    children: <Widget>[
                      SizedBox(height: Config.padding / 2,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Дата вынесения\nпостановления',
                            style: TextStyle(color: Config.textColor,
                                fontSize: Config.textMediumSize),
                          ),
                          Text(
                            DateFormat('dd.MM.y').format(
                              DateTime(_now.month < 6 ? _now.year - 1 : _now.year,
                              _now.month < 6 ? _now.month + 6 : _now.month - 6,
                              _now.day),
                            ),
                            style: TextStyle(
                                fontSize: Config.textMediumSize,
                                color: licenseCheckResult.expiryDate != null
                                    ? Config.textColor
                                    : Config.errorColor
                            ),
                          )
                        ],
                      ),

                      SizedBox(height: Config.padding / 2,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Срок лишения права\nуправления',
                            style: TextStyle(color: Config.textColor,
                                fontSize: Config.textMediumSize),
                          ),
                          Text(
                            '12 мес.',
                            style: TextStyle(
                              fontSize: Config.textMediumSize,
                              color: licenseCheckResult.expiryDate != null
                                  ? Config.textColor
                                  : Config.errorColor,
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}