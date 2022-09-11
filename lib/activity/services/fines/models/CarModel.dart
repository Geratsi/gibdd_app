import 'package:car_online/activity/services/evacuation/models/Car.dart';

class CarModel {

  late Car car;
  late bool isChecked;

  CarModel(Car car) {
    this.car = car;
    this.isChecked = false;
  }
}