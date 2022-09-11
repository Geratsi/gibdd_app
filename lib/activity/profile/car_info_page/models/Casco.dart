class Casco {

  Casco(String? number, String? date) {
    this.number = number != null ? number : "Отсутствует";
    this.date = date != null ? date : "Отсутствует";
  }

  late String number;
  late String date;
}