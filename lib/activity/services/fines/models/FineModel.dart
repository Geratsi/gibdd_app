class FineModel {

  FineModel(String reason, String payTime, String other, int cost, bool isExpired) {
    this.reason = reason;
    this.payTime = payTime;
    this.other = other;
    this.cost = cost;
    this.isExpired = isExpired;
    this.isChecked = false;
  }

  late String reason;
  late String payTime;
  late String other;
  late int cost;
  late bool isExpired;
  late bool isChecked;
}