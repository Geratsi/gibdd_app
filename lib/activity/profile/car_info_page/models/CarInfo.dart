import 'package:car_online/activity/profile/car_info_page/models/Casco.dart';
import 'package:car_online/activity/services/evacuation/models/Car.dart';

import 'Osago.dart';

class CarInfo {

  CarInfo(this.car, this.osago, this.casco);

  Car car;
  Osago osago;
  Casco casco;
}