import 'package:car_online/activity/services/OnlineMapsActivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'activity/AppActivity.dart';
import 'Config.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  state createState() => state();
}

class state extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ru'), // пока оставил на русском языке, потом слушателя сделаем
      ],
      title: 'Помощник водителю',
      theme: ThemeData(
        primarySwatch: MaterialColor(Config.primaryColor.value, {
          50:Config.primaryColor.withOpacity(.1),
          100:Config.primaryColor.withOpacity(.2),
          200:Config.primaryColor.withOpacity(.3),
          300:Config.primaryColor.withOpacity(.4),
          400:Config.primaryColor.withOpacity(.5),
          500:Config.primaryColor.withOpacity(.6),
          600:Config.primaryColor.withOpacity(.7),
          700:Config.primaryColor.withOpacity(.8),
          800:Config.primaryColor.withOpacity(.9),
          900:Config.primaryColor.withOpacity(1),
        }),
        scaffoldBackgroundColor: Config.activityBackColor,
        appBarTheme: AppBarTheme(centerTitle: true),
        primaryColor: Config.primaryColor,
        primaryColorLight:MaterialColor(Config.primaryColor.value, {}),
        highlightColor: Colors.transparent,
        splashColor: Config.splashColor,
        textSelectionHandleColor: Config.primaryColor,
        shadowColor: Config.shadowColor,
      ),
      home: AppActivity(),
    );
  }
}