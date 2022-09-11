import 'package:car_online/activity/services/check/models/CarCheckDetailedResult.dart';
import 'package:car_online/activity/services/check/models/CarCheckResult.dart';
import 'package:car_online/activity/services/check/models/LicenseCheckResult.dart';
import 'package:car_online/activity/services/check/models/OsagoCheckResult.dart';
import 'package:intl/intl.dart';

class CheckDataHolder {

  static DateTime _now = DateTime.now().toLocal();
  static List<CarCheckResult> carCheckHistory = [_getTiguanCheckResult()];

  static CarCheckResult? getCarCheckResultByNumber(String number) {
    if (number == "T828HK116" || number == "Т828НК116") {
      return _getTiguanCheckResult();
    }
    else if (number == "H185PE716" || number == "Н185РЕ716") {
      return _getSolarisCheckResult();
    }
    else {
      return null;
    }
  }

  static CarCheckResult? getCarCheckResultByVin(String vin) {
    if (vin == "VF1HD95584A295F4") {
      return _getTiguanCheckResult();
    }
    else if (vin == "VF1FF31584A295F44") {
      return _getSolarisCheckResult();
    }
    else {
      return null;
    }
  }

  static CarCheckDetailedResult getCarCheckDetailedResult(CarCheckResult carCheckResult) {
    if (carCheckResult.carName == "VW Tiguan 2020") {
      return CarCheckDetailedResult(carCheckResult, "Оригинал", "22.01.2020", false, null, null, null);
    }
    else if (carCheckResult.carName == "Hyundai Solaris 2021") {
      return CarCheckDetailedResult(carCheckResult, "Оригинал", "12.03.2019", false, null, null, null);
    }
    else {
      return CarCheckDetailedResult(carCheckResult, "Оригинал", "15.06.2021", false, null, null, null);
    }
  }

  static LicenseCheckResult getLicenseCheckResult(String licenseNumber) {
    if (licenseNumber == "1625432170") {
      return _getValidLicense();
    }
    else {
      return _getInvalidLicense();
    }
  }

  static OsagoCheckResult getOsagoCheckResult(String osagoSeries, String osagoNumber,) {
    if (osagoNumber == "1111111111") {
      return _getValidOsago(osagoSeries, osagoNumber);
    }
    else {
      return _getInvalidOsago(osagoSeries, osagoNumber);
    }
  }

  static OsagoCheckResult _getValidOsago(String series, String number) {
    return OsagoCheckResult(
      series,
      number,
      'САО "РЕСО -\nГарантия"',
      true,
      '20.10.2021',
      'с 31.10.2021\nпо 30.10.2022',
      'Т556РЕ750',
      '************00101',
    );
  }

  static OsagoCheckResult _getInvalidOsago(String series, String number) {
    return OsagoCheckResult(
      series,
      number,
      'ООО "НСГ -\nРОСЭНЕРГО"',
      false,
      '23.10.2020',
      'с 23.10.2020\nпо 22.10.2021',
      null,
      '************45390',
    );
  }

  static LicenseCheckResult _getValidLicense() {
    return LicenseCheckResult(
        "02.10.1986",
        "16.01.2016",
        "16.01.2026",
        "В, В1"
    );
  }

  static LicenseCheckResult _getInvalidLicense() {
    return LicenseCheckResult(
        "21.04.1986",
        DateFormat("dd-MM-yyyy").format(
            DateTime(_now.year - 10, _now.month, _now.day - 1)
        ).replaceAll(
            "-", "."),
        null,
        "A, A1, В, В1"
    );
  }

  static CarCheckResult _getTiguanCheckResult() {
    return CarCheckResult(
        "VF1HD95584A295F4",
        "VW Tiguan 2020",
        "Синий",
        "1.4 л.",
        "149 л.с.",
        DateFormat("dd-MM-yyyy").format(_now).replaceAll(
            "-", "."),
        91,
        "2020");
  }

  static CarCheckResult _getSolarisCheckResult() {
    return CarCheckResult(
        "VF1FF31584A295F44",
        "Hyundai Sonata 2021",
        "Голубой",
        "2.0 л.",
        "150 л.с.",
        "${DateFormat("dd-MM-yyyy").format(_now).replaceAll(
            "-", ".")}",
        91,
        "2021");
  }
}