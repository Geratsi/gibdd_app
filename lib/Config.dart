import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class Config{
  //MAIN STYLE
  static Color primaryLightColor = Colors.blue.shade400;
  static Color primaryColor = Colors.blue.shade800;
  static Color primaryDarkColor = Colors.blue.shade900;

  static Color secondaryButtonColor = Colors.blue.shade100;

  static Color shadowColor = Colors.black.withOpacity(0.25);
  static Color shadowNavColor = Colors.black.withOpacity(0.15);
  static Color shadowCardColor = Colors.black.withOpacity(0.25);

  static Color splashColor = primaryLightColor;
  static Color splashOverlayColor = primaryLightColor.withOpacity(0.5);

  static Color progressColor = Colors.blue.shade800;
  static Color progressHintColor = Colors.blue.shade400;
  static Color successColor = Colors.green.shade600;
  static Color warningColor = Colors.orange.shade600;
  static Color errorColor = Colors.red.shade400;

  static int animDuration = 250;

  //GLOBAL COMPONENTS
  //TEXT
  static Color textTitleColor = Colors.grey.shade900;
  static Color textColorOnPrimary = Colors.white;
  static Color textColor = Colors.grey.shade800;
  static double textLargeSize = 20;
  static double textMediumSize = 16;
  static double textSmallSize = 14;

  //ACTIVITY
  static Color activityBackColor = Colors.white;
  static Color activityHintColor = Colors.grey.shade100;
  static double activityBorderRadius = 12;
  static double padding = 16;

  //ACTIVITY BAR
  static Color activityBottomBarItemActiveColor = Colors.white;
  static Color activityBottomBarItemUnActiveColor = Colors.blue.shade900;

  static String url = '';
  static String appServerUrl = "",
      appServerEnv = ""
  ;

  //OTHER
  static Color baseInfoColor = Colors.blue.shade50;
  static Color baseWarningInfoColor = Colors.red.shade100;
  static Color infoColor = Colors.orange.shade50;
  static Point pointKazan = Point(latitude: 55.7887, longitude: 49.1221);
}
