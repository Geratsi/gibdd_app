class Car {

  late String imgPath;
  late String carNumber;
  late String carName;
  late String vin;
  late String ctc;

  Car(String? imgPath, String carNumber, String carName, String vin, String ctc) {
    this.imgPath = imgPath != null ? imgPath : "assets/img/ic_car.png";
    this.carNumber = carNumber;
    this.carName = carName;
    this.vin = vin;
    this.ctc = ctc;
  }
}


