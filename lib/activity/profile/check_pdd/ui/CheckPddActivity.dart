import 'package:car_online/Config.dart';
import 'package:car_online/activity/profile/check_pdd/domain/model/CheckPddResult.dart';
import 'package:car_online/activity/profile/check_pdd/ui/CheckPddTabsComponent.dart';
import 'package:car_online/activity/stubs/CheckPddResultsHolder.dart';
import 'package:car_online/widget/MainButton.dart';
import 'package:flutter/material.dart';


class CheckPddActivity extends StatefulWidget {
  const CheckPddActivity({Key? key}) : super(key: key);

  @override
  _CheckPddActivityState createState() => _CheckPddActivityState();
}

class _CheckPddActivityState extends State<CheckPddActivity>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Проверка знаний ПДД',),
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

      body: Column(
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
              ),
            ),

            child: Padding(
              padding: EdgeInsets.fromLTRB(Config.padding, Config.padding,
                  Config.padding, Config.padding * 2),
              child: Text(
                'В данном разделе можно проверить,\nа также освежить свои знания\nактуальных правил дорожного движения',
                style: TextStyle(color: Config.textColorOnPrimary,
                    fontSize: Config.textMediumSize),
              ),
            ),
          ),

          Container(
            transform: Matrix4.translationValues(
                0.0, -(Config.activityBorderRadius * 3) + Config.padding, 0.0
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
              padding: EdgeInsets.all(Config.padding),
              child: Column(
                children: <Widget>[
                  Text(
                    'Пройдите тестирование, чтобы получить лучший результат',
                    style: TextStyle(fontSize: Config.textMediumSize,
                        color: Config.textColor),
                  ),

                  SizedBox(height: Config.padding,),

                  MainButton(
                    label: 'Начать тестирование',
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (
                          context) => CheckPddTabsComponent()))
                          .then((value) => setState(() {}));
                    },
                    bgColor: Config.primaryColor,
                    labelColor: Config.textColorOnPrimary,
                  ),

                  SizedBox(height: Config.padding,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Мой лучший результат',
                        style: TextStyle(
                            fontSize: Config.textMediumSize,
                            color: Config.textTitleColor),
                      ),

                      Text(
                        _getBestResult().toString(),
                        style: TextStyle(
                            fontSize: Config.textLargeSize,
                            color: _getScoreTextColor(_getBestResult()),
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  CheckPddResult _getBestResult() {
    List<CheckPddResult> results = List.from(CheckPddResultsHolder.getResults());
    results.sort();
    CheckPddResult result = results[results.length - 1];
    return result;
  }

  Color _getScoreTextColor(CheckPddResult result) {
    var ratio = result.correctAnswerNumber/result.questionsNumber;
    if (ratio < 0.4) {
      return Config.errorColor;
    }
    else if (ratio > 0.8) {
      return Config.successColor;
    }
    else {
      return Config.warningColor;
    }
  }
}

