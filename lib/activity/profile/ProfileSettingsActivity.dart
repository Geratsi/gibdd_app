import 'package:car_online/config.dart';
import 'package:car_online/widget/AndroidSelect.dart';
import 'package:car_online/widget/MainButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const List<String> languages = [
  'Русский', 'English', 'Татар теле',
];

class ProfileSettingsActivity extends StatefulWidget {
  const ProfileSettingsActivity({Key? key}) : super(key: key);

  @override
  _ProfileSettingsActivityState createState() => _ProfileSettingsActivityState();
}

class _ProfileSettingsActivityState extends State<ProfileSettingsActivity> {
  bool _speed = false;
  bool _notifications = true;
  bool _geolocation = true;
  String _language = 'Русский';

  void _chooseLanguage(BuildContext context) {
    Iterable<Map> _selectActions = languages.map((String label) {
      return {
        'label': label,
        'handler': () {
          Navigator.of(context).pop();
          setState(() {
            _language = label;
            print(_language);
          });
        }
      };
    });

    // if (Platform.isIOS) {
    //   showCupertinoModalPopup(
    //     context: context,
    //     builder: (_) => IOSSelect(
    //       title: 'Выберите язык',
    //       selectActions: _selectActions,
    //     ),
    //   );
    //
    // } else if (Platform.isAndroid) {
    showDialog(
      context: context,
      builder: (_) => AndroidSelect(
        title: 'Выберите язык',
        selectActions: _selectActions,
        themData: Theme.of(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.activityBackColor,

      appBar: AppBar(
        title: Text('Мои настройки',),
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
        )
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 45,
                          child: Transform.scale(
                            scale: 0.8,
                            child: CupertinoSwitch(
                              activeColor: Config.primaryColor,
                              value: _speed,
                              onChanged: (val) {
                                setState(() {
                                  _speed = !_speed;
                                });
                              },
                            ),
                          ),
                        ),

                        SizedBox(width: 20,),

                        Text('Отслеживание скорости', style: TextStyle(fontSize: 18,))
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 45,
                          child: Transform.scale(
                            scale: 0.8,
                            child: CupertinoSwitch(
                              activeColor: Config.primaryColor,
                              value: _notifications,
                              onChanged: (val) {
                                setState(() {
                                  _notifications = !_notifications;
                                });
                              },
                            ),
                          ),
                        ),

                        SizedBox(width: 20,),

                        Text('Уведомления', style: TextStyle(fontSize: 18,))
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 45,
                          child: Transform.scale(
                            scale: 0.8,
                            child: CupertinoSwitch(
                              activeColor: Config.primaryColor,
                              value: _geolocation,
                              onChanged: (val) {
                                setState(() {
                                  _geolocation = !_geolocation;
                                });
                              },
                            ),
                          ),
                        ),

                        SizedBox(width: 20,),

                        Text('Геолокация', style: TextStyle(fontSize: 18,))
                      ],
                    ),

                    SizedBox(height: 10,),

                    Material(
                      color: Config.baseInfoColor,
                      borderRadius: BorderRadius.circular(Config.activityBorderRadius),
                      child: InkWell(
                      splashColor: Config.primaryLightColor,
                      borderRadius: BorderRadius.circular(Config.activityBorderRadius),
                      child: Padding(
                        padding: EdgeInsets.all(Config.padding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Изменить язык',
                              style: TextStyle(
                                color: Config.primaryColor,
                                fontSize: Config.textMediumSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text(_language,
                              style: TextStyle(fontSize: 18,
                                  color: Config.primaryColor),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        _chooseLanguage(context);
                        },
                      ),
                    ),

                    SizedBox(height: 20,),

                    MainButton(
                      label: 'Сохранить изменения',
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      labelColor: Config.textColorOnPrimary,
                      bgColor: Config.primaryColor,
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

