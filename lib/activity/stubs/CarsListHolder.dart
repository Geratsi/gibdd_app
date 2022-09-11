import 'package:car_online/activity/profile/car_info_page/models/CarInfo.dart';
import 'package:car_online/activity/profile/car_info_page/models/Casco.dart';
import 'package:car_online/activity/profile/car_info_page/models/Osago.dart';
import 'package:car_online/activity/services/evacuation/models/Car.dart';
import 'package:car_online/activity/services/evacuation/models/CarEvent.dart';

class CarsListHolder {

  static List<Car> carsList = [
    Car("assets/img/vw.jpg", 'T828HK 116', 'VW Tiguan 2020', 'VF1HD95584A295F4', '33 УВ 345678'),
    Car("assets/img/hy.jpg", 'H185PE 716', 'Hyundai Solaris 2021', 'VF1FF31584A295F44', '25 УВ 345678')
  ];

  static CarEvent getCarEvent(Car car) {
    if (car.carName.contains("Audi")) {
      return CarEvent("авто эвакуировано на \n спец. стоянку по адресу: \n ул. Аделя Кутуя 157", car);
    }
    else if (car.carName.contains("Volkswagen")) {
      return CarEvent("авто эвакуировано на \n спец. стоянку по адресу: \n ул. Аделя Кутуя 157", car);
    }
    else if (car.carName.contains('Hyundai')) {
      return CarEvent('Нарушение ПДД: пункт 1.3 ПДД РФ: Остановка ТС в зоне действия дорожного знака 3.27 "Остановка запрещена". Согласно части 5 статьи 12.16 КоАП РФ, ваш автомобиль был помещен на специализированную стоянку по адресу: г.Казань, ул. Аделя Кутуя 157 Б. Телефон для связи: +7‒937‒520‒40‒40', car);
    }
    else {
      return CarEvent(null, car);
    }
  }

  static List<String> getManufacturers() {
    return _manufacturers;
  }

  static List<String> getModels(String manufacturer) {
    switch(manufacturer) {
      case "Audi": {
        return _audiModels;
      }
      case "Nissan": {
        return _nissanModels;
      }
      case "Volkswagen": {
        return _volkswagenModels;
      }
      case "Hyundai": {
        return _hyundaiModels;
    }
      default: return _audiModels;
    }
  }

  static getCarInfo(Car car) {
    if (car.carName == "Volkswagen Tiguan 2020") {
      return CarInfo(car, Osago("99 45 2345670", '02.01.2020'), Casco('9800489', '02.01.2020'));
    }
    else if (car.carName == "Hyundai Solaris 2021") {
      return CarInfo(car, Osago('33 УВ 345678', '99 45 2345670'), Casco('28.03.2021', '9800489'));
    }
    else {
      return CarInfo(car, Osago(null, null), Casco(null, null));
    }
  }

  static List<String> _manufacturers = [
    "Audi",
    "Nissan",
    "Volkswagen",
    "Hyundai"
  ];

  static List<String> _audiModels = [
    "A5",
    "RS6",
    "Q5",
    "A4"
  ];

  static List<String> _nissanModels = [
    "X-Trail",
    //"Silvia S15",
    //"Skyline R32",
    "Qashqai",
    //"Z400",
    //"Fairlady Z"
  ];

  static List<String> _hyundaiModels = [
    "Solaris",
    "Elantra",
    "Sonata"
  ];

  static List<String> _volkswagenModels = [
    "Tiguan",
    "Polo",
    "Golf",
    "T1"
  ];
}