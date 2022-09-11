
import 'dart:ui';

import 'package:car_online/entity/Notif.dart';
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class Traffic {
  late int id;
  late String name;
  late int points;
  late Color pointsColor = Colors.black;
  late Point point;
  late bool isSelected;

  // isSelected for search and add to favorites
  Traffic({required this.id, required this.name, required this.points,
    required this.point, this.isSelected=false}){
    pointsColor = Colors.green;
    if (points>=4) pointsColor = Colors.orange;
    if (points>=7) pointsColor = Colors.red;
    if (points>=10) pointsColor = Colors.red.shade900;
  }
}
//(цифры 1-3 - зеленый, 4-6 - желтый, 7-9 - красный, 10 - бордовый примерно так в яндекс пробках)