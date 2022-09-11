import 'package:car_online/activity/profile/check_pdd/domain/model/CheckPddResult.dart';
import 'package:car_online/widget/MainButton.dart';
import 'package:flutter/material.dart';

import '../../../../Config.dart';

class CheckPddResultPage extends StatelessWidget {

  final CheckPddResult result;

  CheckPddResultPage(this.result);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.primaryColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Config.primaryColor,
                Config.primaryDarkColor
              ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
        child: Center(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "ТЕСТ ЗАВЕРШЕН",
                style: TextStyle(
                    color: Config.textColorOnPrimary,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 50,),
              Column(
                children: [
                  Text(
                    "Ваш результат:",
                    style: TextStyle(
                      color: Config.textColorOnPrimary,
                      fontSize: Config.textLargeSize,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    result.toString(),
                    style: TextStyle(
                        color: Config.textColorOnPrimary,
                        fontSize: 36,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
        floatingActionButton: Padding(
          padding: EdgeInsets.all(Config.padding),
          child: MainButton(
              label: "Выйти",
              onPressed: () {
                Navigator.of(context).pop();
              },
              bgColor: Config.primaryColor,
              labelColor: Config.textColorOnPrimary
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked
    );
  }
}