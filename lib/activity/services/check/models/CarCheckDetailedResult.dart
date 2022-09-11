import 'package:car_online/activity/services/check/models/CarCheckResult.dart';

class CarCheckDetailedResult {

  CarCheckDetailedResult(
      this.carCheckResult,
      this.ptsType,
      this.ptsDate,
      this.isCarDisposed,
      this.restrictions,
      this.wanted,
      this.mortgaged,
      );

  CarCheckResult carCheckResult;
  String ptsType;
  String ptsDate;
  bool isCarDisposed;
  String? restrictions;
  String? wanted;
  String? mortgaged;
}