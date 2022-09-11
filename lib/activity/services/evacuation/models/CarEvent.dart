import 'Car.dart';

class CarEvent {

  String? eventDescription;
  late Car car;

  CarEvent(String? eventDescription, Car car) {
    this.eventDescription = eventDescription;
    this.car = car;
  }
}