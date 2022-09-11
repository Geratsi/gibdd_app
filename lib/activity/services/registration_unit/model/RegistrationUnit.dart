import 'package:yandex_mapkit/yandex_mapkit.dart';

class RegistrationUnit {

  Point coordinates;
  String number;
  String primaryAddress;
  String secondaryAddress;
  String description;

  RegistrationUnit(this.coordinates, this.number, this.primaryAddress, this.secondaryAddress, this.description);
}