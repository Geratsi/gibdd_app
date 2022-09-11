class OsagoCheckResult {

  OsagoCheckResult(
      this.series,
      this.number,
      this.company,
      this.status,
      this.madeDate,
      this.expiryDate,
      this.registerNumber,
      this.vin,
      );

  String series;
  String number;
  String company;
  bool status;
  String madeDate;
  String expiryDate;
  String? registerNumber;
  String vin;
}