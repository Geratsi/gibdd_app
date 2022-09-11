import 'package:car_online/Config.dart';
import 'package:car_online/activity/services/check/models/OperationBtnModel.dart';
import 'package:car_online/activity/services/check/widgets/tabs/CarCheckTab.dart';
import 'package:car_online/activity/services/check/widgets/tabs/LicenseCheckTab.dart';
import 'package:car_online/activity/services/check/widgets/tabs/OsagoCheckTab.dart';
import 'package:car_online/widget/ButtonCard.dart';
import 'package:flutter/material.dart';

class VerifyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VerifyPage();
  }
}

class _VerifyPage extends State<VerifyPage> {
  final List<OperationBtnModel> _panelButtons = [
    OperationBtnModel("Проверить авто", "assets/img/ic_car.png"),
    OperationBtnModel("Проверить водителя", "assets/img/Driver License.png"),
    OperationBtnModel('Проверить полис РСА', 'assets/img/polis.png'),
  ];

  @override
  void initState() {
    _panelButtons[0].isChecked = true;

    super.initState();
  }

  Widget getTextInputs() {
    if (_panelButtons[0].isChecked) {
      return CarCheckTab();
    }
    else if (_panelButtons[1].isChecked) {
      return LicenseCheckTab();
    }
    else {
      return OsagoCheckTab();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.activityBackColor,

      appBar: AppBar(
        title: Text('Проверка авто, ВУ и полиса'),
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
                padding: EdgeInsets.fromLTRB(
                    Config.padding, Config.padding / 2,
                    Config.padding, Config.padding * 2.5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Данный сервис используется \n'
                          'для проверки авто, полиса РСА и\n'
                          'водительского удостоверения',
                      style: TextStyle(
                        color: Config.textColorOnPrimary,
                        fontSize: Config.textMediumSize,),
                    ),
                  ],
                ),
              ),
            ),

            Container(
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
                    bottomRight: Radius.zero
                ),
              ),

              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  Config.padding, Config.padding,
                  Config.padding, Config.padding / 2,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    GridView.count(
                      shrinkWrap: true,
                      primary: false,
                      padding: EdgeInsets.fromLTRB(
                          0, 0, 0,
                          Config.padding / 2
                      ),
                      crossAxisSpacing: Config.padding / 1.5,
                      mainAxisSpacing: Config.padding / 1.5,
                      crossAxisCount: 3,
                      childAspectRatio: 0.94,
                      children: _panelButtons.map((btnModel) {
                        return Opacity(
                          opacity: btnModel.isChecked ? 1 : 0.5,
                          child: ButtonCard(
                            btnModel.title,
                            Image.asset(
                              btnModel.imgPath,
                              width: 50,
                              height: 50,
                            ),
                            Config.baseInfoColor,
                                () {
                              setState(() {
                                btnModel.isChecked = true;
                                _panelButtons.forEach((element) {
                                  if (element != btnModel) {
                                    element.isChecked = false;
                                  }
                                });
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),

                    SizedBox(height: 20,),

                    Column(
                        children: [
                          getTextInputs(),
                        ]
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}